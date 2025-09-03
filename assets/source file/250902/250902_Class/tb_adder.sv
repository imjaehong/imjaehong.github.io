`timescale 1ns / 1ps

interface adder_intf;
    logic       clk;
    logic [7:0] a;
    logic [7:0] b;
    logic [8:0] result;
endinterface

class transaction;
    rand bit [7:0] a;
    rand bit [7:0] b;
    bit      [8:0] result;
endclass

class generator;
    transaction tr;
    mailbox #(transaction) gen2drv_mbox;

    function new(mailbox#(transaction) gen2drv_mbox);
        this.gen2drv_mbox = gen2drv_mbox;
    endfunction

    task run(int run_count);
        repeat (run_count) begin
            tr = new();
            tr.randomize();
            gen2drv_mbox.put(tr);
            #10;
        end
    endtask
endclass

class driver;
    transaction tr;
    virtual adder_intf adder_if;
    mailbox #(transaction) gen2drv_mbox;

    function new(mailbox#(transaction) gen2drv_mbox,
                 virtual adder_intf adder_if);
        this.gen2drv_mbox = gen2drv_mbox;
        this.adder_if = adder_if;
    endfunction

    task run();
        forever begin
            gen2drv_mbox.get(tr);
            adder_if.a = tr.a;
            adder_if.b = tr.b;
            @(posedge adder_if.clk);
        end
    endtask
endclass

class monitor;
    transaction tr;
    virtual adder_intf adder_if;
    mailbox #(transaction) mon2scb_mbox;

    function new(mailbox#(transaction) mon2scb_mbox,
                 virtual adder_intf adder_if);
        this.mon2scb_mbox = mon2scb_mbox;
        this.adder_if = adder_if;
    endfunction

    task run();
        forever begin
            tr = new();
            @(posedge adder_if.clk);
            #1;
            tr.a = adder_if.a;
            tr.b = adder_if.b;
            tr.result = adder_if.result;
            mon2scb_mbox.put(tr);
        end
    endtask
endclass

class scoreboard;
    transaction tr;
    mailbox #(transaction) mon2scb_mbox;
    bit [7:0] a, b;

    function new(mailbox#(transaction) mon2scb_mbox);
        this.mon2scb_mbox = mon2scb_mbox;
    endfunction

    task run();
        // tr = new();
        forever begin
            mon2scb_mbox.get(tr);
            a = tr.a;
            b = tr.b;
            if (tr.result == (a + b)) begin
                $display("PASS! : %d + %d = %d", a, b, tr.result);
            end else begin
                $display("FAIL! : %d + %d = %d", a, b, tr.result);
            end
        end
    endtask
endclass

class environment;
    generator gen;
    driver drv;
    monitor mon;
    scoreboard scb;
    mailbox #(transaction) gen2drv_mbox;
    mailbox #(transaction) mon2scb_mbox;

    function new(virtual adder_intf adder_if);
        gen2drv_mbox = new();
        mon2scb_mbox = new();
        gen = new(gen2drv_mbox);
        drv = new(gen2drv_mbox, adder_if);
        mon = new(mon2scb_mbox, adder_if);
        scb = new(mon2scb_mbox);
    endfunction

    task run();
        fork
            gen.run(10);
            drv.run();
            mon.run();
            scb.run();
        join_any
        #(10 * 10) $finish;
    endtask
endclass

module tb_adder ();
    environment env;
    adder_intf adder_if ();

    adder dut (
        .clk   (adder_if.clk),
        .a     (adder_if.a),
        .b     (adder_if.b),
        .result(adder_if.result)
    );

    always #5 adder_if.clk = ~adder_if.clk;

    initial begin
        adder_if.clk = 1;
    end

    initial begin
        env = new(adder_if);
        env.run();
    end
endmodule
