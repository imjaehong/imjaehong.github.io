`timescale 1ns / 1ps

module ROM (
    input  logic [31:0] addr,
    output logic [31:0] data
);
    logic [31:0] rom[0:61];

    initial begin
        //rom[x]=32'b fucn7 _ rs2 _ rs1 _f3 _ rd  _ op // R-Type
        rom[0] = 32'b0000000_00001_00010_000_00100_0110011;  // add x4, x2, x1 @@@ mem[4] : 12 + 11 = 23
        rom[1] = 32'b0100000_00001_00010_000_00101_0110011;  // sub x5, x2, x1 @@@ mem[5] : 12 - 11 = 1
        rom[2] = 32'b0000000_00001_00011_111_00110_0110011;  // and x6, x3, x1 @@@ mem[6] : 13 and 11 = 9
        rom[3] = 32'b0000000_00010_00011_110_00111_0110011;  // or  x7, x3, x2 @@@ mem[7] : 13 or 12 = 13
        //rom[x]=32'b imm7  _ rs2 _ rs1 _f3 _ imm5_ op // S-Type
        rom[4] = 32'b0000000_00010_00000_010_01000_0100011;  // sw x2, 8(x0) @@@ ROM, mem[2] : 12
        //rom[x]=32'b imm7  _ rs2 _ rs1 _f3 _ imm5 _ op // B-Type
        rom[5] = 32'b0000000_00011_00010_000_0110_0_1100011;  // beq x2, x2, 12 @@@ PCOutData = 32
        //rom[x]=32'b imm12      _ rs1 _f3 _ rd  _ op // L-Type
        rom[6] = 32'b000000001000_00000_010_01000_0000011;  // lw x8, 8(x0) @@@ RAM, mem[8] : 12
        //rom[x]=32'b imm12      _ rs1 _f3 _ rd  _ op // I-Type
        rom[7] = 32'b000000000001_00001_000_01001_0010011;  // addi x9, x1, 1 @@@ mem[9] : 11 + 1 = 12
        rom[8] = 32'b000000000100_00010_111_01010_0010011;  // andi x10, x2, 4 @@@ mem[10] : 12 AND 4 = 4
        rom[9] = 32'b000000000001_00010_110_01011_0010011;  // ori x11, x2, 1 @@@ mem[11] : 12 OR 1 = 13
        rom[10]= 32'b000000000011_00001_001_01100_0010011;  // slli x12, x1, 1 @@@ mem[12] : 11 << 3  = 88

        //rom[x]= 32'b imm20              _ rd  _ op // LU Type
        rom[11] = 32'b00000000000000000101_01101_0110111; // lui x13, 5 @@@ mem[13] : 5 << 12 = 20480
        //rom[x]= 32'b imm20              _ rd  _ op // AU Type
        rom[12] = 32'b00000000000000000101_01110_0010111; // auipc x14, 5 @@@ mem[14] : 48(=PCOutData) + (5 << 12) = 20528
        //rom[x]= 32'b imm20                 _ rd  _ op // J Type
        rom[13] = 32'b0_0000000100_0_00000000_01111_1101111; // jal x15, 4 @@@ mem[15] : 52(=PCOutData) + 4 = 56 @@@ PCOutData = 52 + 8 = 60
        //rom[x]= 32'b imm12      _ rs1 _f3 _ rd  _ op // JL Type
        rom[14] = 32'b000000001000_00010_000_10000_1100111; // jal x16, x2, 8 @@@ mem[16] : 56(=PCOutData) + 4 = 60 @@@ PCOutData = 12 + 8 = 20
        //rom[x]= 32'b imm12      _ rs1 _f3 _ rd  _ op // JL Type
        rom[15] = 32'b000000001000_00010_000_10001_1100111; // jal x17, x2, 8 @@@ mem[17] : 56(=PCOutData) + 4 = 60 @@@ PCOutData = 12 + 8 = 20
        
    end

    assign data = rom[addr[31:2]];
endmodule

