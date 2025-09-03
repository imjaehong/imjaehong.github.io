`timescale 1ns / 1ps

interface ram_intf (
    input bit clk
);
    logic [7:0] addr;
    logic       we;
    logic [7:0] wdata;
    logic [7:0] rdata;
endinterface

class transaction;
    rand logic [7:0] addr;
    rand logic       we;
    rand logic [7:0] wdata;
    logic      [7:0] rdata;

    task print(string name);  // method
        $display("[%s] we=%d, addr=%h, wdata=%h, rdata=%h", name, we, addr,
                 wdata, rdata);
    endtask
endclass

class generator;
    transaction tr;
    mailbox #(transaction) gen2drv_mbox;  // handler
    event scb2gen_event;

    function new(mailbox#(transaction) gen2drv_mbox, event scb2gen_event);
        this.gen2drv_mbox  = gen2drv_mbox;
        this.scb2gen_event = scb2gen_event;
    endfunction

    task run(int loop);
        repeat (loop) begin
            tr = new();
            if (!tr.randomize()) $error("Randomization failed!");
            tr.print("GEN");
            gen2drv_mbox.put(tr);
            //#20;
            @(scb2gen_event);
        end
    endtask
endclass

class driver;
    transaction tr;
    mailbox #(transaction) gen2drv_mbox;
    virtual ram_intf ram_if;
    event drv2mon_event;

    function new(mailbox#(transaction) gen2drv_mbox, virtual ram_intf ram_if,
                 event drv2mon_event);
        this.gen2drv_mbox = gen2drv_mbox;
        this.ram_if = ram_if;
        this.drv2mon_event = drv2mon_event;
    endfunction

    task run();
        forever begin
            gen2drv_mbox.get(tr);
            ram_if.addr = tr.addr;
            ram_if.we   = tr.we;
            if (tr.we) ram_if.wdata = tr.wdata;
            //->drv2mon_event;  // event triggering
            tr.print("DRV");
            @(posedge ram_if.clk);
            #1;
        end
    endtask
endclass

class monitor;
    mailbox #(transaction) mon2scb_mbox;
    virtual ram_intf ram_if;
    transaction tr;
    event drv2mon_event;

    function new(mailbox#(transaction) mon2scb_mbox, virtual ram_intf ram_if,
                 event drv2mon_event);
        this.mon2scb_mbox = mon2scb_mbox;
        this.ram_if = ram_if;
        this.drv2mon_event = drv2mon_event;
    endfunction

    task run();
        forever begin
            tr = new();
            //@(drv2mon_event); // wait event
            @(posedge ram_if.clk);
            #1;
            tr.addr  = ram_if.addr;
            tr.we    = ram_if.we;
            tr.wdata = ram_if.wdata;
            if (!tr.we) tr.rdata = ram_if.rdata;
            tr.print("MON");
            mon2scb_mbox.put(tr);
        end
    endtask
endclass

class scoreboard;
    mailbox #(transaction) mon2scb_mbox;
    transaction tr;
    event scb2gen_event;
    int total_cnt, pass_cnt, fail_cnt;

    logic [7:0] ref_mem[2**8-1];
    logic [7:0] ref_rdata;

    function new(mailbox#(transaction) mon2scb_mbox, event scb2gen_event);
        this.mon2scb_mbox = mon2scb_mbox;
        this.scb2gen_event = scb2gen_event;
        this.total_cnt = 0;
        this.pass_cnt = 0;
        this.fail_cnt = 0;
    endfunction

    task run();
        forever begin
            mon2scb_mbox.get(tr);
            total_cnt++;
            tr.print("SCB");
            if (tr.we) begin
                ref_mem[tr.addr] = tr.wdata;
            end else begin
                ref_rdata = ref_mem[tr.addr];
                if (ref_rdata === tr.rdata) begin
                    pass_cnt++;
                    $display(
                        "PASS! Matched Data! ref_rdata: %h == tr.rdata: %h",
                        ref_rdata, tr.rdata);
                end else begin
                    fail_cnt++;
                    $display(
                        "FAIL! Dismatched Data! ref_rdata: %h == tr.rdata: %h",
                        ref_rdata, tr.rdata);
                end
            end
            $display("");
            ->scb2gen_event;  // event tigger
        end
    endtask
endclass

class envirment;
    mailbox #(transaction) gen2drv_mbox;
    mailbox #(transaction) mon2scb_mbox;
    generator              gen;
    driver                 drv;
    monitor                mon;
    scoreboard             scb;

    event                  drv2mon_event;
    event                  scb2gen_event;

    function new(virtual ram_intf ram_if);
        gen2drv_mbox = new();
        mon2scb_mbox = new();
        gen          = new(gen2drv_mbox, scb2gen_event);
        drv          = new(gen2drv_mbox, ram_if, drv2mon_event);
        mon          = new(mon2scb_mbox, ram_if, drv2mon_event);
        scb          = new(mon2scb_mbox, scb2gen_event);
    endfunction

    task run(int loop);
        fork
            gen.run(loop);
            drv.run();
            mon.run();
            scb.run();
        join_any
        #(50);
        $display("Total : %d", scb.total_cnt);
        $display("Pass : %d", scb.pass_cnt);
        $display("Fail : %d", scb.fail_cnt);
    endtask
endclass

module tb_ram ();
    bit clk;
    ram_intf ram_if (clk);
    envirment env;

    ram dut (
        .clk  (clk),
        .addr (ram_if.addr),
        .we   (ram_if.we),
        .wdata(ram_if.wdata),
        .rdata(ram_if.rdata)
    );

    always #5 clk = ~clk;

    initial clk = 1;

    initial begin
        env = new(ram_if);
        env.run(1000);
        $finish;
    end

endmodule
