`timescale 1ns / 1ps

module RAM (
    // global signals
    input  logic        PCLK,
    input  logic        PRESET,
    // APB Interface Signals
    input  logic [11:0] PADDR,
    input  logic        PWRITE,
    input  logic        PENABLE,
    input  logic [31:0] PWDATA,
    input  logic        PSEL,
    output logic [31:0] PRDATA,
    output logic        PREADY
);
    logic [31:0] mem[0:2**10-1];  // 0x0000 ~ 0x0fff 

    always_ff @(posedge PCLK) begin
        PREADY <= 1'b0;
        if (PSEL && PENABLE) begin
            PREADY <= 1'b1;
            if (PWRITE) mem[PADDR[11:2]] <= PWDATA;
            else PRDATA <= mem[PADDR[11:2]];
        end
    end

endmodule
