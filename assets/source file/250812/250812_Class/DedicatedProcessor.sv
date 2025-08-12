`timescale 1ns / 1ps

module DedicatedProcessor (
    input  logic       clk,
    input  logic       reset,
    output logic [7:0] OutPort

);

    logic SumSrcMuxSel;
    logic ISrcMuxSel;
    logic SumEn;
    logic IEn;
    logic AdderSrcMuxSel;
    logic OutPortEn;
    logic ILe10;

    DataPath U_DataPath (.*);
    ControlUnit U_ControlUnit (.*);

endmodule
