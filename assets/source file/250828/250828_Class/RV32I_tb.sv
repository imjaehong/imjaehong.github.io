`timescale 1ns / 1ps

module RV32I_tb ();

    logic clk;
    logic reset;
    logic [7:0] gpo;

    MCU dut (.*);

    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;

        #10;
        reset = 0;

        #(10 * 10) $finish;
    end

endmodule
