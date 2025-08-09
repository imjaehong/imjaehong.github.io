`timescale 1ns / 1ps

module top_Uart_UpDownCounter (
    input  logic       clk,
    input  logic       reset,
    input  logic [2:0] btn,
    input  logic       rx,
    output logic       tx,
    output logic [1:0] led_mode,
    output logic [1:0] led_run_stop,
    output logic [3:0] fndCom,
    output logic [7:0] fndFont
);

    logic [7:0] uart_data;

    uart U_Uart (
        .clk      (clk),
        .reset    (reset),
        .rx       (rx),
        .tx       (tx),
        .uart_data(uart_data)
    );

    top_UpDownCounter U_Top_UpDownCounter (
        .clk         (clk),
        .reset       (reset),
        .btn         (btn),
        .uart_data   (uart_data),
        .led_mode    (led_mode),
        .led_run_stop(led_run_stop),
        .fndCom      (fndCom),
        .fndFont     (fndFont)
    );

endmodule
