`timescale 1ns / 1ps

module top_UpDownCounter (
    input  logic       clk,
    input  logic       reset,
    input  logic       btn_mode,
    input  logic       btn_run_stop,
    input  logic       btn_clear,
    output logic [1:0] led_mode,
    output logic [1:0] led_run_stop,
    output logic [3:0] fndCom,
    output logic [7:0] fndFont
);

    logic [13:0] count;
    logic btn_mode_edge, btn_run_stop_edge, btn_clear_edge;

    button_detector U_BTN_MODE (
        .clk         (clk),
        .reset       (reset),
        .i_btn       (btn_mode),
        .rising_edge (),
        .falling_edge(btn_mode_edge),
        .both_edge   ()
    );

    button_detector U_BTN_RUN_STOP (
        .clk         (clk),
        .reset       (reset),
        .i_btn       (btn_run_stop),
        .rising_edge (btn_run_stop_edge),
        .falling_edge(),
        .both_edge   ()
    );

    button_detector U_BTN_CLEAR (
        .clk         (clk),
        .reset       (reset),
        .i_btn       (btn_clear),
        .rising_edge (),
        .falling_edge(btn_clear_edge),
        .both_edge   ()
    );

    UpDownCounter U_UpDownCounter (
        .clk         (clk),
        .reset       (reset),
        .btn_mode    (btn_mode_edge),
        .btn_run_stop(btn_run_stop_edge),
        .btn_clear   (btn_clear_edge),
        .led_mode    (led_mode),
        .led_run_stop(led_run_stop),
        .count       (count)
    );

    fndController U_FND_CTRL (
        .clk    (clk),
        .reset  (reset),
        .number (count),
        .fndCom (fndCom),
        .fndFont(fndFont)
    );

endmodule
