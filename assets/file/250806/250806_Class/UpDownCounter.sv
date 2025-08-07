`timescale 1ns / 1ps

module UpDownCounter (
    input  logic        clk,
    input  logic        reset,
    input  logic        sw_mode,
    output logic [13:0] count
);

    logic tick_10hz;

    clk_div_10hz U_CLK_DIV_10hz (
        .clk      (clk),
        .reset    (reset),
        .tick_10hz(tick_10hz)
    );

    up_down_counter U_UP_DOWN_COUNTER (
        .clk  (clk),
        .reset(reset),
        .tick (tick_10hz),
        .mode (sw_mode),
        .count(count)
    );

endmodule


module clk_div_10hz (
    input  logic clk,
    input  logic reset,
    output logic tick_10hz
);

    //logic [23:0] div_counter;
    logic [$clog2(10_000_000)-1:0] div_counter;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            div_counter <= 0;
            tick_10hz   <= 1'b0;
        end else begin
            if (div_counter == 10_000_000 - 1) begin
                div_counter <= 0;
                tick_10hz   <= 1'b1;
            end else begin
                div_counter <= div_counter + 1;
                tick_10hz   <= 1'b0;
            end
        end
    end

endmodule


module up_down_counter (
    input  logic        clk,
    input  logic        reset,
    input  logic        tick,
    input  logic        mode,
    output logic [13:0] count
);

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            count <= 0;
        end else begin
            if (mode == 1'b0) begin  // up counter
                if (tick) begin
                    if (count == 9999) begin
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end
            end else begin  // down counter
                if (tick) begin
                    if (count == 0) begin
                        count <= 9999;
                    end else begin
                        count <= count - 1;
                    end
                end
            end
        end
    end
    
endmodule
