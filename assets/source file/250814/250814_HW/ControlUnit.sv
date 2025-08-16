`timescale 1ns / 1ps

module ControlUnit (
    input  logic [31:0] instrCode,
    output logic        regFileWe,
    output logic [ 3:0] aluControl
);

    // logic 은 선언하면서 연결이 안되기 때문에 wire 사용 (logic 사용시 assign 필요)
    wire [6:0] opcode = instrCode[6:0];
    wire [3:0] operator = {instrCode[30], instrCode[14:12]};

    always_comb begin
        regFileWe = 1'b0;
        case (opcode)
            7'b0110011: regFileWe = 1'b1; 
        endcase
    end

    always_comb begin
        aluControl = 4'bx;
        case (opcode)
            7'b0110011: begin // R-Type
                aluControl = 4'bx;
                case (operator)
                    4'b0000: aluControl = 4'b0000; // ADD
                    4'b1000: aluControl = 4'b0001; // SUB
                    4'b0001: aluControl = 4'b0010; // SLL
                    4'b0101: aluControl = 4'b0011; // SRL
                    4'b1101: aluControl = 4'b0100; // SRA
                    4'b0010: aluControl = 4'b0101; // SLT
                    4'b0011: aluControl = 4'b0110; // SLTU
                    4'b0100: aluControl = 4'b0111; // XOR
                    4'b0110: aluControl = 4'b1000; // OR
                    4'b0111: aluControl = 4'b1001; // AND
                endcase
            end 
        endcase
    end

endmodule
