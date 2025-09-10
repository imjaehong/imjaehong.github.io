`timescale 1ns / 1ps

module VGA_Display_ImgROM (
    input  logic       clk,
    input  logic       reset,
    // input  logic [3:0] sw_red,
    // input  logic [3:0] sw_green,
    // input  logic [3:0] sw_blue,
    // input  logic       sw_mode,
    output logic       h_sync,
    output logic       v_sync,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port,
    input  logic       sw_r,
    input  logic       sw_g,
    input  logic       sw_b
);
    logic pclk;
    logic DE;
    // logic [3:0] sw_r, sw_g, sw_b;
    // logic [3:0] bar_r, bar_g, bar_b;
    logic [9:0] x_pixel, y_pixel;
    logic [16:0] addr;
    logic [15:0] data;
    logic [3:0] i_r, i_g, i_b;

    VGA_Decoder U_VGA_DEC (
        .*,
        .x_pixel(x_pixel),
        .y_pixel(y_pixel)
    );

    imgReader U_IMG_READER (
        .DE    (DE),
        .x     (x_pixel),
        .y     (y_pixel),
        .addr  (addr),
        .data  (data),
        .r_port(i_r),
        .g_port(i_g),
        .b_port(i_b)
    );

    ImgROM U_ImgROM (
        .clk (pclk),  // pclk 을 받아여됨
        .addr(addr),
        .data(data)
    );

    // RGB_OnOff_Filter U_RGB_OnOff_Filter (
    //     .sw_r(sw_r),
    //     .sw_g(sw_g),
    //     .sw_b(sw_b),
    //     .i_r (i_r),
    //     .i_g (i_g),
    //     .i_b (i_b),
    //     .o_r (r_port),
    //     .o_g (g_port),
    //     .o_b (b_port)
    // );

    GrayScaleFilter U_GrayScaleFilter (
        .i_r(i_r),
        .i_g(i_g),
        .i_b(i_b),
        .o_r(r_port),
        .o_g(g_port),
        .o_b(b_port)
    );

    // VGA_RGB_SWITCH U_VGA_RGB_SW (
    //     .*,
    //     .r_port(sw_r),
    //     .g_port(sw_g),
    //     .b_port(sw_b)
    // );

    // VGA_Color_Bar U_VGA_Color_Bar (
    //     .*,
    //     .r_port(bar_r),
    //     .g_port(bar_g),
    //     .b_port(bar_b)
    // );

    // mux_2x1 U_MUX (
    //     .sel  (sw_mode),
    //     .rbg_a({sw_r, sw_g, sw_b}),       // sw color
    //     .rbg_b({bar_r, bar_g, bar_b}),    // color bar
    //     .rbg  ({r_port, g_port, b_port})
    // );
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
