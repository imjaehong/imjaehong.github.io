`timescale 1ns / 1ps

module GPO_Periph (
    // global signals
    input  logic        PCLK,
    input  logic        PRESET,
    // APB Interface Signals
    input  logic [ 2:0] PADDR,
    input  logic        PWRITE,
    input  logic        PENABLE,
    input  logic [31:0] PWDATA,
    input  logic        PSEL,
    output logic [31:0] PRDATA,
    output logic        PREADY,
    // External Port
    output logic [ 7:0] gpo
);
    logic [7:0] cr;
    logic [7:0] odr;

    APB_SlaveIntf_GPO U_APB_SlaveIntf_GPO (.*);
    GPO U_GPO (.*);

endmodule

module APB_SlaveIntf_GPO (
    // global signals
    input  logic        PCLK,
    input  logic        PRESET,
    // APB Interface Signals
    input  logic [ 2:0] PADDR,
    input  logic        PWRITE,
    input  logic        PENABLE,
    input  logic [31:0] PWDATA,
    input  logic        PSEL,
    output logic [31:0] PRDATA,
    output logic        PREADY,
    // Internal Port
    output logic [ 7:0] cr,
    output logic [ 7:0] odr
);
    logic [31:0] slv_reg0, slv_reg1;

    assign cr  = slv_reg0;
    assign odr = slv_reg1;

    always_ff @(posedge PCLK, posedge PRESET) begin
        if (PRESET) begin
            slv_reg0 <= 0;
            slv_reg1 <= 0;
        end else begin
            PREADY <= 1'b0;
            if (PSEL && PENABLE) begin
                PREADY <= 1'b1;
                if (PWRITE) begin
                    case (PADDR[2])
                        2'd0: slv_reg0 <= PWDATA;
                        2'd1: slv_reg1 <= PWDATA;
                    endcase
                end else begin
                    case (PADDR[2])
                        2'd0: PRDATA <= slv_reg0;
                        2'd1: PRDATA <= slv_reg1;
                    endcase
                end
            end
        end
    end
endmodule

module GPO (
    input  logic [7:0] cr,
    input  logic [7:0] odr,
    output logic [7:0] gpo
);
    genvar i;
    generate
        for (i = 0; i < 8; i++) begin
            assign gpo[i] = cr[i] ? odr[i] : 1'bz;
        end
    endgenerate
endmodule
