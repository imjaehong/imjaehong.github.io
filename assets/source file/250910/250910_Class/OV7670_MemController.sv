`timescale 1ns / 1ps

module OV7670_MemController (
    input  logic        clk,
    input  logic        reset,
    // ov7670 side
    input  logic        href,
    input  logic        vsync,
    input  logic [ 7:0] ov7670_data,
    // memory side
    output logic        we,
    output logic [16:0] wAddr,
    output logic [15:0] wData
);
    logic [15:0] pixel_data;
    logic [ 9:0] h_counter;  // 320 * 2 = 640 (320 pixel)
    logic [ 7:0] v_counter;  // 240 line

    assign wAddr = v_counter * 320 + h_counter[9:1];
    assign wData = pixel_data;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            h_counter  <= 0;
            pixel_data <= 0;
            we         <= 1'b0;
        end else begin
            if (href) begin
                h_counter <= h_counter + 1;
                if (h_counter[0] == 0) begin
                    pixel_data[15:8] <= ov7670_data;
                    we <= 1'b0;
                end else begin
                    pixel_data[7:0] <= ov7670_data;
                    we <= 1'b1;
                end
            end else begin
                h_counter <= 0;
                we <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            v_counter <= 0;
        end else begin
            if (vsync) begin
                v_counter <= 0;
            end else begin
                if (h_counter == (320 * 2 - 1)) begin
                    v_counter <= v_counter + 1;
                end
            end
        end
    end
endmodule
