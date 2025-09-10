`timescale 1ns / 1ps

module RGB_OnOff_Filter(
    input  logic       sw_r,
    input  logic       sw_g,
    input  logic       sw_b,
    input  logic [3:0] i_r,
    input  logic [3:0] i_g,
    input  logic [3:0] i_b,
    output logic [3:0] o_r,
    output logic [3:0] o_g,
    output logic [3:0] o_b
    );
    assign o_r = sw_r ? i_r : 4'b0;
    assign o_g = sw_g ? i_g : 4'b0;
    assign o_b = sw_b ? i_b : 4'b0;

endmodule
