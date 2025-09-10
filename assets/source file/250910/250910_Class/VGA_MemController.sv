`timescale 1ns / 1ps

module VGA_MemController (
    // VGA side
    input  logic        DE,
    input  logic [ 9:0] x_pixel,
    input  logic [ 9:0] y_pixel,
    // frame buffer side
    output logic        den,
    output logic [16:0] rAddr,
    input  logic [15:0] rData,
    // export side
    output logic [ 3:0] r_port,
    output logic [ 3:0] g_port,
    output logic [ 3:0] b_port
);

assign den = DE && x_pixel < 320 && y_pixel <240; // QVGA Area
assign rAddr = den ? (y_pixel * 320 + x_pixel) : 17'bz;
assign {r_port, g_port, b_port} = den ? {rData[15:12], rData[10:7], rData[4:1]} : 12'b0;

endmodule
