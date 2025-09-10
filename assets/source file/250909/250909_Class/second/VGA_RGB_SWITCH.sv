`timescale 1ns / 1ps

module VGA_RGB_SWITCH (
    input  logic [3:0] sw_red,
    input  logic [3:0] sw_green,
    input  logic [3:0] sw_blue,
    input  logic       DE,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port
);
    assign r_port = DE ? sw_red : 4'b0;
    assign g_port = DE ? sw_green : 4'b0;
    assign b_port = DE ? sw_blue : 4'b0;
endmodule
