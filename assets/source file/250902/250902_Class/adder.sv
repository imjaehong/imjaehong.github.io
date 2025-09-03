`timescale 1ns / 1ps

module adder (
    input  logic       clk,
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [8:0] result
);
    always_ff @(posedge clk) begin
        result <= a + b;
    end
endmodule
