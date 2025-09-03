`timescale 1ns / 1ps

module FND_Periph (
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
    output logic [ 3:0] fndCom,
    output logic [ 7:0] fndFont
);
    logic [13:0] cr, odr;
    logic [13:0] number;

    APB_SlaveIntf_FND U_APB_SlaveIntf_FND (.*);
    FND U_FND (.*);
    fndController U_fndController (
        .*,
        .clk  (PCLK),
        .reset(PRESET)
    );

endmodule

module APB_SlaveIntf_FND (
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
    output logic [13:0] cr,
    output logic [13:0] odr
);
    logic [31:0] slv_reg0, slv_reg1;  //, slv_reg2, slv_reg3; 

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

module FND (
    input  logic [13:0] cr,
    input  logic [13:0] odr,
    output logic [13:0] number
);
    genvar i;
    generate
        for (i = 0; i < 14; i++) begin
            assign number[i] = cr[i] ? odr[i] : 1'bz;
        end
    endgenerate
endmodule
