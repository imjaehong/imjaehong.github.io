`timescale 1ns / 1ps

module ram (
    input  logic       clk,
    input  logic [7:0] addr,
    input  logic       we,
    input  logic [7:0] wdata,
    output logic [7:0] rdata
);
    logic [7:0] mem[0:2**8-1];

    always_ff @(posedge clk) begin
        if (we) begin
            mem[addr] <= wdata;
            
            // case (size) // example : Byte, Half, Word 
            //     2'b00: begin
            //         mem[addr+0] <= wData[7:0];
            //     end
            //     2'b01: begin
            //         mem[addr+0] <= wData[7:0];
            //         mem[addr+1] <= wData[15:8];
            //     end
            //     2'b10: begin
            //         mem[addr+0] <= wData[7:0];
            //         mem[addr+1] <= wData[15:8];
            //         mem[addr+2] <= wData[23:16];
            //         mem[addr+3] <= wData[31:24];
            //     end
            // endcase
        end
    end

    assign rdata = mem[addr];
endmodule
