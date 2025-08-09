`timescale 1ns / 1ps

module uart_tb ();

    logic       clk;
    logic       reset;
    logic       start;
    logic [7:0] tx_data;
    logic       tx;
    logic       tx_busy;
    logic       tx_done;

    uart dut (.*);

    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;
        #10;
        reset = 0;
        #10;
        @(posedge clk);
        tx_data = 8'b11001010;
        start   = 1;
        @(posedge clk);
        start = 0;
    end

endmodule
