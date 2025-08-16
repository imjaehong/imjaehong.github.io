`timescale 1ns / 1ps

module ControlUnit (
    input  logic [31:0] instrCode,
    output logic        regFileWe,
    output logic [ 1:0] aluControl
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
        aluControl = 2'bx;
        case (opcode)
            7'b0110011: begin // R-Type
                aluControl = 2'bx;
                case (operator)
                    4'b0000: aluControl = 2'b00; // add
                    4'b1000: aluControl = 2'b01; // sub
                    4'b0111: aluControl = 2'b10; // and 
                    4'b0110: aluControl = 2'b11; // or
                endcase
            end 
        endcase
    end

endmodule
