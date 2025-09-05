`timescale 1ns / 1ps

module AXI4_Lite_Master (
    // Global Signals
    input  logic        ACLK,
    input  logic        ARESETn,
    // WRITE Transaction, AW Channel
    output logic [ 3:0] AWADDR,
    output logic        AWVALID,
    input  logic        AWREADY,
    // WRITE Transaction, W Channel
    output logic [31:0] WDATA,
    output logic        WVALID,
    input  logic        WREADY,
    // WRITE Transaction, B Channel
    input  logic [ 1:0] BRESP,
    input  logic        BVALID,
    output logic        BREADY,
    // READ Transaction, AR Channel
    output logic [ 3:0] ARADDR,
    output logic        ARVALID,
    input  logic        ARREADY,
    // READ Transaction, R Channel
    input  logic [31:0] RDATA,
    input  logic        RVALID,
    output logic        RREADY,
    input  logic [ 1:0] RRESP,
    // internal signals
    input  logic [ 3:0] addr,
    input  logic        write,
    input  logic [31:0] wdata,
    output logic [31:0] rdata,
    input  logic        transfer,
    output logic        ready
);
    logic w_ready, r_ready;
    assign ready = w_ready | r_ready;

    // WRITE Transaction, AW Channel transfer
    typedef enum {
        AW_IDLE,
        AW_VALID
    } aw_state_e;

    aw_state_e aw_state, aw_state_next;
    logic [3:0] temp_awaddr_reg, temp_awaddr_next;

    always_ff @(posedge ACLK, negedge ARESETn) begin
        if (!ARESETn) begin
            aw_state        <= AW_IDLE;
            temp_awaddr_reg <= 0;
        end else begin
            aw_state        <= aw_state_next;
            temp_awaddr_reg <= temp_awaddr_next;
        end
    end

    always_comb begin
        aw_state_next    = aw_state;
        AWVALID          = 1'b0;
        AWADDR           = temp_awaddr_reg;
        temp_awaddr_next = temp_awaddr_reg;
        case (aw_state)
            AW_IDLE: begin
                AWVALID = 1'b0;
                if (transfer & write) begin
                    aw_state_next = AW_VALID;
                    temp_awaddr_next = addr;
                end
            end
            AW_VALID: begin
                AWVALID = 1'b1;
                AWADDR  = temp_awaddr_reg;
                if (AWREADY) begin
                    aw_state_next = AW_IDLE;
                end
            end
        endcase
    end


    // WRITE Transaction, W Channel transfer
    typedef enum {
        W_IDLE,
        W_VALID
    } w_state_e;

    w_state_e w_state, w_state_next;
    logic [31:0] temp_wdata_reg, temp_wdata_next;

    always_ff @(posedge ACLK, negedge ARESETn) begin
        if (!ARESETn) begin
            w_state        <= W_IDLE;
            temp_wdata_reg <= 0;
        end else begin
            w_state        <= w_state_next;
            temp_wdata_reg <= temp_wdata_next;
        end
    end

    always_comb begin
        w_state_next    = w_state;
        WVALID          = 1'b0;
        WDATA = temp_wdata_reg;
        temp_wdata_next = temp_wdata_reg;
        case (w_state)
            W_IDLE: begin
                WVALID = 1'b0;
                if (transfer & write) begin
                    w_state_next = W_VALID;
                    temp_wdata_next = wdata;
                end
            end
            W_VALID: begin
                WVALID = 1'b1;
                WDATA  = temp_wdata_reg;
                if (WREADY) begin
                    w_state_next = W_IDLE;
                end
            end
        endcase
    end

    // WRITE Transaction, B Channel transfer
    typedef enum {
        B_IDLE,
        B_READY
    } b_state_e;

    b_state_e b_state, b_state_next;

    always_ff @(posedge ACLK, negedge ARESETn) begin
        if (!ARESETn) begin
            b_state        <= B_IDLE;
        end else begin
            b_state        <= b_state_next;
        end
    end

    always_comb begin
        b_state_next    = b_state;
        BREADY          = 1'b0;
        w_ready = 1'b0;
        case (b_state)
            B_IDLE: begin
                BREADY = 1'b0;
                w_ready = 1'b0;
                if (WVALID) begin                    
                    b_state_next = B_READY;
                end
            end
            B_READY: begin
                BREADY = 1'b1;
                if (BVALID) begin
                    b_state_next = B_IDLE;
                    w_ready = 1'b1;
                end
            end
        endcase
    end

endmodule
