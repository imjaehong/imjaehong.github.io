`timescale 1ns / 1ps

module DataPath (
    input  logic       clk,
    input  logic       reset,
    input  logic       RFSrcMuxSel,
    input  logic [2:0] RAddr1,
    input  logic [2:0] RAddr2,
    input  logic [2:0] WAddr,
    input  logic       we,
    input  logic       OutPortEn,
    input  logic [1:0] ALUop,
    output logic       lte,
    output logic [7:0] OutPort
);

    logic [7:0] AddrResult, RFSrcMuxOut;
    logic [7:0] RData1, RData2;
    logic [7:0] ALUResult;

    Mux_2x1 U_RFSrcMux (
        .sel(RFSrcMuxSel),
        .x0 (ALUResult),
        .x1 (8'b1),
        .y  (RFSrcMuxOut)
    );

    RegFile U_RegFile (
        .clk   (clk),
        .RAddr1(RAddr1),
        .RAddr2(RAddr2),
        .WAddr (WAddr),
        .we    (we),
        .Wdata (RFSrcMuxOut),
        .RData1(RData1),
        .RData2(RData2)
    );

    Comparator U_lte (
        .a  (RData1),
        .b  (RData2),
        .lte(lte)
    );

    // Adder U_Adder (
    //     .a  (RData1),
    //     .b  (RData2),
    //     .sum(AddrResult)
    // );

ALU U_ALU(
    .sel(ALUop),
    .a(RData1),
    .b(RData2),
    .alu_result(ALUResult)
);

    Register U_Register (
        .clk  (clk),
        .reset(reset),
        .en   (OutPortEn),
        .d    (RData1),
        .q    (OutPort)
    );

endmodule


module RegFile (
    input  logic       clk,
    input  logic [2:0] RAddr1,
    input  logic [2:0] RAddr2,
    input  logic [2:0] WAddr,
    input  logic       we,
    input  logic [7:0] Wdata,
    output logic [7:0] RData1,
    output logic [7:0] RData2
);

    logic [7:0] mem[0:2**3-1];  // [0:2**(Number of addresses)-1]

    always_ff @(posedge clk) begin
        if (we) begin
            mem[WAddr] <= Wdata;
        end
    end

    assign RData1 = (RAddr1 == 0) ? 8'b0 : mem[RAddr1];
    assign RData2 = (RAddr2 == 0) ? 8'b0 : mem[RAddr2];

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


module ALU (
    input  logic [1:0] sel,
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] alu_result
);

    always_comb begin
        alu_result = a + b;
        case (sel)
            2'd0: alu_result = a + b;
            2'd1: alu_result = a - b;
            2'd2: alu_result = a & b;
            2'd3: alu_result = a | b;
        endcase
    end

endmodule


module Comparator (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic       lte
);

    assign lte = a < b;

endmodule
