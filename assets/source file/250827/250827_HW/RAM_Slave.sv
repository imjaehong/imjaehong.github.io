`timescale 1ns / 1ps

module RAM_Slave (
    // global signals
    input  logic        PCLK,
    input  logic        PRESET,
    // APB Interface Signals
    input  logic [31:0] PADDR,
    input  logic        PWRITE,
    input  logic        PENABLE,
    input  logic [31:0] PWDATA,
    input  logic        PSEL,
    output logic [31:0] PRDATA,
    output logic        PREADY
);
    logic [11:0] mem[0:2**4-1];
    logic [31:0] r_addr;
    logic r_we;

    assign r_addr = PADDR - 32'h1000_0000;
    assign r_we   = PWRITE & PENABLE & PSEL;

    always_ff @(posedge PCLK, posedge PRESET) begin
        if (PRESET) begin
            PREADY <= 1'b0;
        end else begin
            if (PSEL && PENABLE) PREADY <= 1'b1;
            else PREADY <= 1'b0;
        end
    end

    RAM U_ram (
        .clk  (PCLK),
        .we   (r_we),
        .addr (r_addr),
        .wData(PWDATA),
        .rData(PRDATA)
    );

endmodule

module RAM (
    input  logic        clk,
    input  logic        we,
    input  logic [31:0] addr,
    input  logic [31:0] wData,
    output logic [31:0] rData
);
    logic [31:0] mem[0:2**4-1];

    always_ff @(posedge clk) begin
        if (we) mem[addr[31:2]] <= wData;
    end

    assign rData = mem[addr[31:2]];
endmodule
