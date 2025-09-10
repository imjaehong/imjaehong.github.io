`timescale 1ns / 1ps

module imgReader (
    input  logic        DE,
    input  logic [ 9:0] x,
    input  logic [ 9:0] y,
    output logic [16:0] addr,
    input  logic [15:0] data,
    output logic [ 3:0] r_port,
    output logic [ 3:0] g_port,
    output logic [ 3:0] b_port
);
    //assign addr   = DE ? (320 * y + x) : 17'bz;
    //assign addr   = (DE && (x < 320) && (y < 240)) ? (320 * y + x) : 17'bz;
    logic img_show;

    assign img_show = (DE && (x < 320) && (y < 240));
    assign addr     = img_show ? (320 * y + x) : 17'bz;

    assign r_port   = img_show ? data[15:12] : 4'bz;
    assign g_port   = img_show ? data[10:7] : 4'bz;
    assign b_port   = img_show ? data[4:1] : 4'bz;

endmodule
