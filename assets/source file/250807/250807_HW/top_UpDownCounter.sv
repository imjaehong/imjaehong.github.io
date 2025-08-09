`timescale 1ns / 1ps

module top_UpDownCounter (
    input  logic       clk,
    input  logic       reset,
    input  logic       btnU,
    input  logic       btnL,
    input  logic       btnR,
    output logic [3:0] led,
    output logic [3:0] fndCom,
    output logic [7:0] fndFont
);

    logic [13:0] count;
    logic o_btn_u, o_btn_l, o_btn_r;

    btn_debounce U_BTN_DEBOUNCE_U (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btnU),
        .o_btn(o_btn_u)
    );

    btn_debounce U_BTN_DEBOUNCE_L (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btnL),
        .o_btn(o_btn_l)
    );

    btn_debounce U_BTN_DEBOUNCE_R (
        .clk  (clk),
        .rst  (rst),
        .i_btn(btnR),
        .o_btn(o_btn_r)
    );

    UpDownCounter U_UPDOWNCOUNTER (
        .clk    (clk),
        .reset  (reset),
        .sw_mode(o_btn_u),
        .btn_L  (o_btn_l),
        .btn_R  (o_btn_r),
        .led    (led),
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
