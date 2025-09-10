`timescale 1ns / 1ps

module ImgROM (
    input  logic                       clk,
    input  logic [$clog2(320*240)-1:0] addr,
    output logic [               15:0] data
);
    logic [15:0] mem[0:320*240-1];

    initial begin
        $readmemh("Rengoku.mem", mem);
    end

    always_ff @(posedge clk) begin
        data <= mem[addr];
    end

    //assign data = mem[addr];
endmodule
