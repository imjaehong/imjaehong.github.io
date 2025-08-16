`timescale 1ns / 1ps

module ROM (
    input  logic [31:0] addr,
    output logic [31:0] data
);

    logic [31:0] rom[0:61];

    initial begin
        //rom[x]=32'b func7 _ rs2 _ rs1 _f3 _ rd  _  op
        rom[0] = 32'b0000000_00001_00010_000_00100_0110011;  // add x4, x2, x1
        rom[1] = 32'b0100000_00001_00010_000_00101_0110011;  // sub x5, x2, x1
        rom[2] = 32'b0000000_00000_00011_111_00110_0110011;  // and x6, x3, x0
        rom[3] = 32'b0000000_00000_00011_110_00111_0110011;  // or  x7, x3, x0
    end

    // 하위 2bit 를 없애면 4(2^2)의 배수로 표현이 됨, 4byte 단위로 이동 가능
    assign data = rom[addr[31:2]];

endmodule
