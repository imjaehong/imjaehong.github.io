`timescale 1ns / 1ps

module DataPath (
    input  logic       clk,
    input  logic       reset,
    input  logic       SumSrcMuxSel,
    input  logic       ISrcMuxSel,
    input  logic       SumEn,
    input  logic       IEn,
    input  logic       AdderSrcMuxSel,
    input  logic       OutPortEn,
    output logic       ILe10,
    output logic [7:0] OutPort
);

    logic [7:0] SumSrcMuxOut, ISrcMuxOut;
    logic [7:0] SumRegOut, IRegOut;
    logic [7:0] AdderResult, AdderSrcMuxOut;

    Mux_2x1 U_SumSrcMux (
        .sel(SumSrcMuxSel),
        .x0 (0),
        .x1 (AdderResult),
        .y  (SumSrcMuxOut)
    );

    Mux_2x1 U_ISrcMux (
        .sel(ISrcMuxSel),
        .x0 (0),
        .x1 (AdderResult),
        .y  (ISrcMuxOut)
    );

    Register U_SumReg (
        .clk  (clk),
        .reset(reset),
        .en   (SumEn),
        .d    (SumSrcMuxOut),
        .q    (SumRegOut)
    );

    Register U_IReg (
        .clk  (clk),
        .reset(reset),
        .en   (IEn),
        .d    (ISrcMuxOut),
        .q    (IRegOut)
    );

    Comparator U_ILe10 (
        .a (IRegOut),
        .b (10),
        .lt(ILe10)
    );

    Mux_2x1 U_AdderSrcMux (
        .sel(AdderSrcMuxSel),
        .x0 (SumRegOut),
        .x1 (1),
        .y  (AdderSrcMuxOut)
    );

    Adder U_Adder (
        .a  (AdderSrcMuxOut),
        .b  (IRegOut),
        .sum(AdderResult)
    );

    Register U_OutPort (
        .clk  (clk),
        .reset(reset),
        .en   (OutPortEn),
        .d    (SumRegOut),
        .q    (OutPort)
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

    assign lt = a <= b;

endmodule
