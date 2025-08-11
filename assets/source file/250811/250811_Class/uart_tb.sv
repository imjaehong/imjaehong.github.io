`timescale 1ns / 1ps

module uart_tb ();

    logic       clk;
    logic       reset;
    // transmitter signal
    logic       start;
    logic [7:0] tx_data;
    logic       tx_busy;
    logic       tx_done;
    logic       tx;
    // receiver signal
    logic [7:0] rx_data;
    logic       rx_done;
    logic       rx;

    uart dut (
        .clk    (clk),
        .reset  (reset),
        .start  (start),
        .tx_data(tx_data),
        .tx_busy(tx_busy),
        .tx_done(tx_done),
        .tx     (tx),
        .rx_data(rx_data),
        .rx_done(rx_done),
        .rx     (tx)
    );

    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;
        #10;
        reset = 0;
        @(posedge clk);
        tx_data = 8'b11001010;
        start   = 1;
        @(posedge clk);
        start = 0;
        @(rx_done);
        #50;
        $finish();
    end

endmodule
