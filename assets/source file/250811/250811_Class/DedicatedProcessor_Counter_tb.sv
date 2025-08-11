`timescale 1ns / 1ps

module DedicatedProcessor_Counter_tb ();

    logic       clk;
    logic       reset;
    logic [7:0] OutBuffer;

    DedicatedProcessor_Counter dut (.*);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #10;
        reset = 0;
    end

endmodule