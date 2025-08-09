`timescale 1ns / 1ps

module FndController (
    input  logic        clk,
    input  logic        reset,
    input  logic [13:0] number,
    output logic [ 3:0] fndCom,
    output logic [ 7:0] fndFont
);

    logic tick_1khz;
    logic [1:0] count;
    logic [3:0] digit_1, digit_10, digit_100, digit_1000, digit;

    clk_div_1khz U_CLK_DIV_1KHZ (
        .clk      (clk),
        .reset    (reset),
        .tick_1khz(tick_1khz)
    );

    counter_2bit U_COUNTER_2BIT (
        .clk  (clk),
        .reset(reset),
        .tick (tick_1khz),
        .count(count)
    );

    decoder_2x4 U_DECODER_2X4 (
        .x(count),
        .y(fndCom)
    );

    digitSplitter U_DIGITSPLITTER (
        .number    (number),
        .digit_1   (digit_1),
        .digit_10  (digit_10),
        .digit_100 (digit_100),
        .digit_1000(digit_1000)
    );

    mux_4x1 U_MUX_4X1 (
        .sel(count),
        .x0 (digit_1),
        .x1 (digit_10),
        .x2 (digit_100),
        .x3 (digit_1000),
        .y  (digit)
    );

    BCDtoFND_Decoder U_BCDTOFND_DECODER (
        .bcd(digit),
        .fnd(fndFont)
    );

endmodule


module clk_div_1khz (
    input  logic clk,
    input  logic reset,
    output logic tick_1khz
);
    logic [$clog2(100_000):0] div_counter;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            div_counter <= 0;
            tick_1khz   <= 0;
        end else begin
            if (div_counter == 100_000 - 1) begin
                div_counter <= 0;
                tick_1khz   <= 1;
            end else begin
                div_counter <= div_counter + 1;
                tick_1khz   <= 0;
            end
        end
    end

endmodule


module counter_2bit (
    input  logic       clk,
    input  logic       reset,
    input  logic       tick,
    output logic [1:0] count
);
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            count <= 0;
        end else begin
            if (tick) begin
                count <= count + 1;
            end
        end
    end
    
endmodule


module decoder_2x4 (
    input  logic [1:0] x,
    output logic [3:0] y
);
    always_comb begin
        case (x)
            2'b00: y = 4'b1110;
            2'b01: y = 4'b1101;
            2'b10: y = 4'b1011;
            2'b11: y = 4'b0111;
        endcase
    end

endmodule


module digitSplitter (
    input  logic [13:0] number,
    output logic [ 3:0] digit_1,
    output logic [ 3:0] digit_10,
    output logic [ 3:0] digit_100,
    output logic [ 3:0] digit_1000
);
    assign digit_1    = number % 10;
    assign digit_10   = number / 10 % 10;
    assign digit_100  = number / 100 % 10;
    assign digit_1000 = number / 1000 % 10;

endmodule


module mux_4x1 (
    input  logic [1:0] sel,
    input  logic [3:0] x0,
    input  logic [3:0] x1,
    input  logic [3:0] x2,
    input  logic [3:0] x3,
    output logic [3:0] y
);
    always_comb begin
        y = 4'b0000;
        case (sel)
            2'b00: y = x0;
            2'b01: y = x1;
            2'b10: y = x2;
            2'b11: y = x3;
        endcase
    end

endmodule


module BCDtoFND_Decoder (
    input  logic [3:0] bcd,
    output logic [7:0] fnd
);
    always_comb begin
        case (bcd)
            4'h0: fnd = 8'hc0;
            4'h1: fnd = 8'hf9;
            4'h2: fnd = 8'ha4;
            4'h3: fnd = 8'hb0;
            4'h4: fnd = 8'h99;
            4'h5: fnd = 8'h92;
            4'h6: fnd = 8'h82;
            4'h7: fnd = 8'hf8;
            4'h8: fnd = 8'h80;
            4'h9: fnd = 8'h90;
            4'ha: fnd = 8'h88;
            4'hb: fnd = 8'h83;
            4'hc: fnd = 8'hc6;
            4'hd: fnd = 8'ha1;
            4'he: fnd = 8'h86;
            4'hf: fnd = 8'h8e;
            default: fnd = 8'hff;
        endcase
    end
    
endmodule
