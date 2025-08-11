`timescale 1ns / 1ps

module DedicatedProcessor (
    input  logic       clk,
    input  logic       reset,
    output logic [7:0] OutBuffer
);

    logic ASrcMuxSel;
    logic AEn;
    logic ALt10;
    logic OutBufEn;
    logic [$clog2(10_000_000)-1:0] div_counter;
    logic clk_10hz;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            div_counter <= 0;
        end else begin
            if (div_counter == 10_000_000 - 1) begin
                div_counter <= 0;
                clk_10hz    <= 1'b1;
            end else begin
                div_counter <= div_counter + 1;
                clk_10hz    <= 1'b0;
            end
        end
    end

    ControlUnit U_ControlUnit (
        //.clk(clk_10hz), // bitstream
        .*
    );

    DataPath U_DataPath (
        //.clk(clk_10hz), // bitstream
        .*
    );

endmodule


module ControlUnit (
    input  logic clk,
    input  logic reset,
    input  logic ALt10,
    output logic ASrcMuxSel,
    output logic AEn,
    output logic OutBufEn
);

    typedef enum {
        S0,
        S1,
        S2,
        S3,
        S4
    } state_e;

    state_e state, next_state;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        ASrcMuxSel = 0;
        AEn        = 0;
        OutBufEn   = 0;
        next_state = state;
        case (state)
            S0: begin
                ASrcMuxSel = 0;
                AEn        = 1;
                OutBufEn   = 0;
                next_state = S1;
            end
            S1: begin
                ASrcMuxSel = 1;
                AEn        = 0;
                OutBufEn   = 0;
                if (ALt10) next_state = S2;
                else next_state = S4;
            end
            S2: begin
                ASrcMuxSel = 1;
                AEn        = 0;
                OutBufEn   = 1;
                next_state = S3;
            end
            S3: begin
                ASrcMuxSel = 1;
                AEn        = 1;
                OutBufEn   = 0;
                next_state = S1;
            end
            S4: begin
                ASrcMuxSel = 1;
                AEn        = 0;
                OutBufEn   = 0;
                next_state = S4;
            end
        endcase
    end

endmodule


module DataPath (
    input  logic       clk,
    input  logic       reset,
    input  logic       ASrcMuxSel,
    input  logic       AEn,
    input  logic       OutBufEn,
    output logic       ALt10,
    output logic [7:0] OutBuffer
);

    logic [7:0] AdderResult, ASrcMuxOut, ARegOut;
    logic [7:0] SumResult, BSrcMuxOut, BRegOut;

    Mux_2x1 U_ASrcMux (
        .sel(ASrcMuxSel),
        .x0 (8'b0),
        .x1 (AdderResult),
        .y  (ASrcMuxOut)
    );

    Register U_A_Reg (
        .clk  (clk),
        .reset(reset),
        .en   (AEn),
        .d    (ASrcMuxOut),
        .q    (ARegOut)
    );

    Comparator U_ALt10 (
        .a (ARegOut),
        .b (8'd11),    // 8'd11
        .lt(ALt10)
    );

    Adder U_Adder (
        .a  (ARegOut),
        .b  (8'd1),
        .sum(AdderResult)
    );

    // OutBuf U_OutBuf (
    //     .en(OutBufEn),
    //     .x (ARegOut),
    //     .y (OutBuffer)
    // );

    // Register U_OutReg (
    //     .clk  (clk),
    //     .reset(reset),
    //     .en   (OutBufEn),
    //     .d    (ARegOut),
    //     .q    (OutBuffer)
    // );

    /*************** B ***************/
    Mux_2x1 U_BSrcMux (
        .sel(ASrcMuxSel),
        .x0 (8'b0),
        .x1 (SumResult),
        .y  (BSrcMuxOut)
    );

    Register U_B_Reg (
        .clk  (clk),
        .reset(reset),
        .en   (AEn),
        .d    (BSrcMuxOut),
        .q    (BRegOut)
    );

    Adder U_Sum (
        .a  (AdderResult),
        .b  (BRegOut),
        .sum(SumResult)
    );

    Register U_OutReg (
        .clk  (clk),
        .reset(reset),
        .en   (OutBufEn),
        .d    (BRegOut),
        .q    (OutBuffer)
    );

endmodule


module Register (
    input  logic       clk,
    input  logic       reset,
    input  logic       en,
    input  logic [7:0] d,
    output logic [7:0] q
);

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            if (en) begin
                q <= d;
            end
        end
    end

endmodule


module Mux_2x1 (
    input  logic       sel,
    input  logic [7:0] x0,
    input  logic [7:0] x1,
    output logic [7:0] y
);

    always_comb begin
        y = 8'b0;
        case (sel)
            1'b0: y = x0;
            1'b1: y = x1;
        endcase
    end

endmodule


module Adder (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] sum
);

    assign sum = a + b;

endmodule


module Comparator (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic       lt
);

    assign lt = a < b;

endmodule


module OutBuf (
    input  logic       en,
    input  logic [7:0] x,
    output logic [7:0] y
);

    assign y = en ? x : 8'bx;

endmodule
