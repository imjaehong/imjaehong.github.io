`timescale 1ns / 1ps

module DedicatedProcessor (
    input  logic       clk,
    input  logic       reset,
    output logic [7:0] OutPort
);

    logic       RFSrcMuxSel;
    logic [2:0] RAddr1;
    logic [2:0] RAddr2;
    logic [2:0] WAddr;
    logic       we;
    logic       OutPortEn;
    logic [1:0] ALUop;
    logic       lte;

    ControlUnit U_ControlUnit (.*);
    DataPath U_DataPath (.*);

endmodule
