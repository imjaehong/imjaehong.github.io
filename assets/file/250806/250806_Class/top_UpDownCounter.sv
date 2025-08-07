`timescale 1ns / 1ps

module top_UpDownCounter (
    input  logic       clk,
    input  logic       reset,
    input  logic       sw_mode,
    output logic [3:0] fndCom,
    output logic [7:0] fndFont
);

    logic [13:0] count;

    UpDownCounter U_UPDOWNCOUNTER (
        .clk    (clk),
        .reset  (reset),
        .sw_mode(sw_mode),
        .count  (count)
    );

    FndController U_FNDCONTROLLER (
        .clk    (clk),
        .reset  (reset),
        .number (count),
        .fndCom (fndCom),
        .fndFont(fndFont)
    );

endmodule
