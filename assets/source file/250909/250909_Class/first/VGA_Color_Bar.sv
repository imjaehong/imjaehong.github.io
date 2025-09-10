`timescale 1ns / 1ps

module VGA_Color_Bar (
    input  logic       DE,
    input  logic [9:0] x_pixel,
    input  logic [9:0] y_pixel,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port
);

    always_comb begin
        r_port = 4'b0000;
        g_port = 4'b0000;
        b_port = 4'b0000;
        if (DE) begin
            if (y_pixel < 320) begin
                if (x_pixel < 91) begin  // white
                    r_port = 4'b1111;
                    g_port = 4'b1111;
                    b_port = 4'b1111;
                end else if (x_pixel < 182) begin  // yellow
                    r_port = 4'b1111;
                    g_port = 4'b1111;
                    b_port = 4'b0000;
                end else if (x_pixel < 273) begin  // cyan
                    r_port = 4'b0000;
                    g_port = 4'b1111;
                    b_port = 4'b1111;
                end else if (x_pixel < 364) begin  // green
                    r_port = 4'b0000;
                    g_port = 4'b1111;
                    b_port = 4'b0000;
                end else if (x_pixel < 455) begin  // magentia
                    r_port = 4'b1111;
                    g_port = 4'b0000;
                    b_port = 4'b1111;
                end else if (x_pixel < 546) begin  // red
                    r_port = 4'b1111;
                    g_port = 4'b0000;
                    b_port = 4'b0000;
                end else if (x_pixel < 640) begin  // blue
                    r_port = 4'b0000;
                    g_port = 4'b0000;
                    b_port = 4'b1111;
                end
            end else if (320 <= y_pixel && y_pixel < 360) begin
                if (x_pixel < 91) begin  // blue
                    r_port = 4'b0000;
                    g_port = 4'b0000;
                    b_port = 4'b1111;
                end else if (x_pixel < 182) begin  // gray
                    r_port = 4'b0001;
                    g_port = 4'b0001;
                    b_port = 4'b0001;
                end else if (x_pixel < 273) begin  // magentia
                    r_port = 4'b1111;
                    g_port = 4'b0000;
                    b_port = 4'b1111;
                end else if (x_pixel < 364) begin  // gray
                    r_port = 4'b0001;
                    g_port = 4'b0001;
                    b_port = 4'b0001;
                end else if (x_pixel < 455) begin  // cyan
                    r_port = 4'b0000;
                    g_port = 4'b1111;
                    b_port = 4'b1111;
                end else if (x_pixel < 546) begin  // gray
                    r_port = 4'b0001;
                    g_port = 4'b0001;
                    b_port = 4'b0001;
                end else if (x_pixel < 640) begin  // white
                    r_port = 4'b1111;
                    g_port = 4'b1111;
                    b_port = 4'b1111;
                end
            end else if (360 <= y_pixel && y_pixel < 480) begin
                if (x_pixel < 114) begin  // Navy
                    r_port = 4'b0000;
                    g_port = 4'b0011;
                    b_port = 4'b0100;
                end else if (x_pixel < 227) begin  // white
                    r_port = 4'b1111;
                    g_port = 4'b1111;
                    b_port = 4'b1111;
                end else if (x_pixel < 341) begin  // purple
                    r_port = 4'b0001;
                    g_port = 4'b0000;
                    b_port = 4'b0101;
                end else if (x_pixel < 455) begin // gray
                    r_port = 4'b0001;
                    g_port = 4'b0001;
                    b_port = 4'b0001;
                end else if (x_pixel < 485) begin // black
                    r_port = 4'b0000;
                    g_port = 4'b0000;
                    b_port = 4'b0000;
                end else if (x_pixel < 515) begin // gray
                    r_port = 4'b0001;
                    g_port = 4'b0001;
                    b_port = 4'b0001;
                end else if (x_pixel < 546) begin // silver
                    r_port = 4'b0011;
                    g_port = 4'b0011;
                    b_port = 4'b0011;
                end else if (x_pixel < 640) begin // gray
                    r_port = 4'b0000;
                    g_port = 4'b0000;
                    b_port = 4'b0000;
                end
            end
        end
    end

endmodule
