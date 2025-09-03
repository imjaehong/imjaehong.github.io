`timescale 1ns / 1ps

module tb_apb ();
    //Global Signals
    logic        PCLK;
    logic        PRESET;

    logic [31:0] PADDR;
    logic        PWRITE;
    logic        PENABLE;
    logic [31:0] PWDATA;
    logic        PSEL0;
    logic        PSEL1;
    logic        PSEL2;
    logic        PSEL3;
    logic [31:0] PRDATA0;
    logic [31:0] PRDATA1;
    logic [31:0] PRDATA2;
    logic [31:0] PRDATA3;
    logic        PREADY0;
    logic        PREADY1;
    logic        PREADY2;
    logic        PREADY3;
    logic        PREADY;
    logic        PSEL;
    logic [31:0] PRDATA;
    logic        transfer;
    logic        ready;
    logic        write;
    logic [31:0] addr;
    logic [31:0] wdata;
    logic [31:0] rdata;

    APB_Master U_APB_Master (.*);

    RAM U_RAM (
        .*,
        .PADDR (PADDR[11:0]),
        .PSEL  (PSEL0),
        .PRDATA(PRDATA0),
        .PREADY(PREADY0)
    );

    APB_Slave U_APB_Slave1 (
        .*,
        .PSEL  (PSEL1),
        .PRDATA(PRDATA1),
        .PREADY(PREADY1)
    );

    APB_Slave U_APB_Slave2 (
        .*,
        .PSEL  (PSEL2),
        .PRDATA(PRDATA2),
        .PREADY(PREADY2)
    );

    always #5 PCLK = ~PCLK;

    initial begin
        PCLK   = 0;
        PRESET = 1;
        #10;
        PRESET = 0;
    end

    task automatic apb_write(input logic [31:0] apb_addr, input logic [31:0] apb_wdata);
        @(posedge PCLK);
        #1;
        write = 1;
        addr = apb_addr;
        wdata = apb_wdata;
        transfer = 1;
        @(posedge PCLK);
        #1;
        transfer = 0;
        wait(ready);
    endtask  

    task automatic apb_read(input logic [31:0] apb_addr);
        @(posedge PCLK);
        #1;
        write = 0;
        addr = apb_addr;
        transfer = 1;
        @(posedge PCLK);
        #1;
        transfer = 0;
        wait(ready);
    endtask

    initial begin
        #10;
        apb_write(32'h1000_0000, 32'd1);
        apb_write(32'h1000_0004, 32'd2);
        apb_write(32'h1000_0008, 32'd3);

        apb_read(32'h1000_0000);
        apb_read(32'h1000_0004);
        apb_read(32'h1000_0008);

        @(posedge PCLK);
        #1;
        write = 1;
        addr = 32'h1000_1000;
        wdata = 32'd11;
        transfer = 1;
        @(posedge PCLK);
        #1;
        transfer = 0;
        wait (ready);

        @(posedge PCLK);
        #1;
        write = 1;
        addr = 32'h1000_2000;
        wdata = 32'd12;
        transfer = 1;
        @(posedge PCLK);
        #1;
        transfer = 0;
        wait (ready);

        // @(posedge PCLK);
        // #1;
        // write = 1;
        // addr = 32'h1000_3000;
        // wdata = 32'd20;
        // transfer = 1;
        // @(posedge PCLK);
        // #1;
        // transfer = 0;
        // wait (ready);

        // @(posedge PCLK);
        // #1;
        // write = 0;
        // addr = 32'h1000_3000;
        // transfer = 1;
        // @(posedge PCLK);
        // #1;
        // transfer = 0;
        // wait (ready);

        #50;
        $finish;
    end
endmodule
