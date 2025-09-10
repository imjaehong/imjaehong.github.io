`timescale 1ns / 1ps

module VGA_Display_Switch (
    input  logic       clk,
    input  logic       reset,
    input  logic [3:0] sw_red,
    input  logic [3:0] sw_green,
    input  logic [3:0] sw_blue,
    input  logic       sw_mode,
    output logic       h_sync,
    output logic       v_sync,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port
);
    logic DE;
    logic [3:0] sw_r, sw_g, sw_b;
    logic [3:0] bar_r, bar_g, bar_b;
    logic [9:0] x_pixel, y_pixel;

    VGA_Decoder U_VGA_DEC (.*);

    VGA_RGB_SWITCH U_VGA_RGB_SW (
        .*,
        .r_port(sw_r),
        .g_port(sw_g),
        .b_port(sw_b)

    );

    VGA_Color_Bar U_VGA_Color_Bar (
        .*,
        .r_port(bar_r),
        .g_port(bar_g),
        .b_port(bar_b)
    );

    mux_2x1 U_MUX (
        .sel  (sw_mode),
        .rbg_a({sw_r, sw_g, sw_b}),       // sw color
        .rbg_b({bar_r, bar_g, bar_b}),    // color bar
        .rbg  ({r_port, g_port, b_port})
    );
endmodule

module mux_2x1 (
    input  logic        sel,
    input  logic [11:0] rbg_a,
    input  logic [11:0] rbg_b,
    output logic [11:0] rbg
);
    always_comb begin
        case (sel)
            1'b0: rbg = rbg_a;
            1'b1: rbg = rbg_b;
        endcase
    end
endmodule
