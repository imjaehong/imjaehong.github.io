`timescale 1ns / 1ps

module GPI_Periph (
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
    // external port
    input  logic [ 7:0] gpi
);

    logic [7:0] cr;
    logic [7:0] idr;

    APB_SlaveIntf_GPI U_APB_SlaveInterf_GPI (.*);
    GPI U_GPI (.*);

endmodule


module APB_SlaveIntf_GPI (
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
    // internal port
    output logic [ 7:0] cr,
    input  logic [ 7:0] idr
);
    logic [31:0] slv_reg0, slv_reg1;  //, slv_reg2, slv_reg3;

    assign cr = slv_reg0;
    //assign slv_reg1 = idr;

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
                        2'd1: ;  //slv_reg1 <= PWDATA;
                    endcase
                end else begin
                    case (PADDR[2])
                        2'd0: PRDATA <= slv_reg0;
                        2'd1: PRDATA <= idr;
                    endcase

                end
            end
        end
    end
endmodule

module GPI (
    input  logic [7:0] cr,
    output logic [7:0] idr,
    input  logic [7:0] gpi
);

    genvar i;
    generate
        for (i = 0; i < 8; i++) begin
            assign idr[i] = cr[i] ? gpi[i] : 1'bz;
        end
    endgenerate
endmodule
