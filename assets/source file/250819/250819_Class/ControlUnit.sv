`timescale 1ns / 1ps
`include "defines.sv"

module ControlUnit (
    input  logic [31:0] instrCode,
    output logic        regFileWe,
    output logic [ 3:0] aluControl,
    output logic        aluSrcMuxSel,
    output logic        busWe,
    output logic        RFWDSrcMuxSel,
    output logic        branch
);
    wire  [6:0] opcode = instrCode[6:0];
    wire  [3:0] operator = {instrCode[30], instrCode[14:12]};
    logic [4:0] signals;
    assign {regFileWe, aluSrcMuxSel, busWe, RFWDSrcMuxSel, branch} = signals;

    always_comb begin
        signals = 5'b0;
        case (opcode)
            //{regFileWe, aluSrcMuxSel, busWe, RFWDSrcMuxSel} = signals;
            `OP_TYPE_R: signals = 5'b1_0_0_0_0;
            `OP_TYPE_S: signals = 5'b0_1_1_0_0;
            `OP_TYPE_L: signals = 5'b1_1_0_1_0;
            `OP_TYPE_I: signals = 5'b1_1_0_0_0;
            `OP_TYPE_B: signals = 5'b0_0_0_0_1;
        endcase
    end

    always_comb begin
        aluControl = 4'bx;
        case (opcode)
            `OP_TYPE_R: aluControl = operator;
            `OP_TYPE_S: aluControl = `ADD;
            `OP_TYPE_L: aluControl = `ADD;
            `OP_TYPE_I: begin
                if (operator == 4'b1101) aluControl = operator;
                else aluControl = {1'b0, operator[2:0]};
            end
            `OP_TYPE_B: aluControl = operator;
        endcase
    end
endmodule
