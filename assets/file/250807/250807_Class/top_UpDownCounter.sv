`timescale 1ns / 1ps

module top_UpDownCounter (
    input  logic       clk,
    input  logic       reset,
    input  logic       button,
    output logic [3:0] fndCom,
    output logic [7:0] fndFont
);

    logic [13:0] count;
    logic        falling_edge;

    button_detector U_BD (
        .clk         (clk),
        .reset       (reset),
        .i_btn       (button),
        .rising_edge (),
        .falling_edge(falling_edge),
        .both_edge   ()
    );

    UpDownCounter U_UpDownCOUNTER (
        .clk   (clk),
        .reset (reset),
        .button(falling_edge),
        .count (count)
    );

    fndController U_FND_CTRL (
        .clk    (clk),
        .reset  (reset),
        .number (count),
        .fndCom (fndCom),
        .fndFont(fndFont)
    );

endmodule
