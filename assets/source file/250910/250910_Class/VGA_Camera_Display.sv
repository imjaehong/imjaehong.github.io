`timescale 1ns / 1ps

module VGA_Camera_Display (
    input  logic       clk,
    input  logic       reset,
    input  logic       sw_gray,
    // ov7670 side
    output logic       ov7670_xclk,
    input  logic       ov7670_pclk,
    input  logic       ov7670_href,
    input  logic       ov7670_vsync,
    input  logic [7:0] ov7670_data,
    // external port
    output logic       h_sync,
    output logic       v_sync,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port
);
    logic        ov7670_we;
    logic [16:0] ov7670_wAddr;
    logic [15:0] ov7670_wData;

    logic        vga_pclk;
    logic        vga_hsync;
    logic        vga_vsync;
    logic [ 9:0] vga_x_pixel;
    logic [ 9:0] vga_y_pixel;
    logic        vga_DE;

    logic        vga_den;
    logic [16:0] vga_rAddr;
    logic [15:0] vga_rData;

    logic [3:0] vga_r, gray_r;
    logic [3:0] vga_g, gray_g;
    logic [3:0] vga_b, gray_b;

    assign ov7670_xclk = vga_pclk;

    VGA_Decoder U_VGA_Decoder (
        .clk    (clk),
        .reset  (reset),
        .pclk   (vga_pclk),
        .h_sync (h_sync),
        .v_sync (v_sync),
        .x_pixel(vga_x_pixel),
        .y_pixel(vga_y_pixel),
        .DE     (vga_DE)
    );

    OV7670_MemController U_OV7670_MemController (
        .clk        (ov7670_pclk),
        .reset      (reset),
        .href       (ov7670_href),
        .vsync      (ov7670_vsync),
        .ov7670_data(ov7670_data),
        .we         (ov7670_we),
        .wAddr      (ov7670_wAddr),
        .wData      (ov7670_wData)
    );

    frame_buffer U_FrameBuffer (
        .wclk (ov7670_pclk),
        .we   (ov7670_we),
        .wAddr(ov7670_wAddr),
        .wData(ov7670_wData),
        .rclk (vga_pclk),
        .oe   (vga_den),
        .rAddr(vga_rAddr),
        .rData(vga_rData)
    );

    VGA_MemController U_VGAMemController (
        .DE     (vga_DE),
        .x_pixel(vga_x_pixel),
        .y_pixel(vga_y_pixel),
        .den    (vga_den),
        .rAddr  (vga_rAddr),
        .rData  (vga_rData),
        .r_port (vga_r),
        .g_port (vga_g),
        .b_port (vga_b)
    );

    GrayScaleFilter U_GrayScaleFilter (
        .i_r(vga_r),
        .i_g(vga_g),
        .i_b(vga_b),
        .o_r(gray_r),
        .o_g(gray_g),
        .o_b(gray_b)
    );

    mux_2x1 U_mux_2x1 (
        .sel     (sw_gray),
        .vga_rgb ({vga_r, vga_g, vga_b}),
        .gray_rgb({gray_r, gray_g, gray_b}),
        .rgb     ({r_port, g_port, b_port})
    );

endmodule

module mux_2x1 (
    input  logic        sel,
    input  logic [11:0] vga_rgb,
    input  logic [11:0] gray_rgb,
    output logic [11:0] rgb
);
    always_comb begin
        case (sel)
            1'b0: rgb = vga_rgb;
            1'b1: rgb = gray_rgb;
        endcase
    end
endmodule
