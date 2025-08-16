`timescale 1ns / 1ps

module CPU_RV32I (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] instrCode,
    output logic [31:0] instrMemAddr
);

    logic       regFileWe;
    logic [3:0] aluControl;

    ControlUnit U_ControlUnit (.*);
    DataPath U_DataPath (.*);

endmodule
