`timescale 1ns / 1ps

module VGA_Display_Switch (
    input  logic       clk,
    input  logic       reset,
    input  logic [3:0] sw_red,
    input  logic [3:0] sw_green,
    input  logic [3:0] sw_blue,
    output logic       h_sync,
    output logic       v_sync,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port
);
    logic DE;
    logic [9:0] x_pixel, y_pixel;

    VGA_Decoder U_VGA_DEC (.*);

    VGA_RGB_SWITCH U_VGA_RGB_SW (.*);

endmodule
