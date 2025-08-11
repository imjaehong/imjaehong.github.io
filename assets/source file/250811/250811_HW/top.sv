`timescale 1ns / 1ps

module top (
    input  logic       clk,
    input  logic       reset,
    output logic [3:0] fndCom,
    output logic [7:0] fndFont
);

    logic [7:0] data;

    DedicatedProcessor U_DedicatedProcessor (
        .clk(clk),
        .reset(reset),
        .OutBuffer(data)
    );

    fndController U_fndController (
        .clk(clk),
        .reset(reset),
        .number(data),
        .fndCom(fndCom),
        .fndFont(fndFont)
    );

endmodule
