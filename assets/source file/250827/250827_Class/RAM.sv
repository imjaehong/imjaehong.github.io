`timescale 1ns / 1ps

module RAM (
    input  logic        clk,
    input  logic        we,
    input  logic [31:0] addr,
    input  logic [31:0] wData,
    output logic [31:0] rData
);
    logic [31:0] mem[0:2**4-1]; // 0x00 ~ 0x0f => 0x10 * 4 => 0x40

    always_ff @( posedge clk ) begin
        if (we) mem[addr[31:2]] <= wData;
    end

    assign rData = mem[addr[31:2]];
endmodule
