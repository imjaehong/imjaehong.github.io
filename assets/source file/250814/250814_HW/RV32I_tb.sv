`timescale 1ns / 1ps

module RV32I_tb ();

    logic clk;
    logic reset;

    MCU dut (.*);

    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;

        #20;
        reset = 0;
        
        #(60 * 2)
        $finish;
    end

endmodule
