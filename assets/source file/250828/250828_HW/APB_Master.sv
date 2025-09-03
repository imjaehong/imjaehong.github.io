`timescale 1ns / 1ps

module APB_Master (
    // global signals
    input  logic        PCLK,
    input  logic        PRESET,
    // APB Interface Signals
    output logic [31:0] PADDR,
    output logic        PWRITE,
    output logic        PENABLE,
    output logic [31:0] PWDATA,
    output logic        PSEL0,
    output logic        PSEL1,
    output logic        PSEL2,
    output logic        PSEL3,
    output logic        PSEL4,
    input  logic [31:0] PRDATA0,
    input  logic [31:0] PRDATA1,
    input  logic [31:0] PRDATA2,
    input  logic [31:0] PRDATA3,
    input  logic [31:0] PRDATA4,
    input  logic        PREADY0,
    input  logic        PREADY1,
    input  logic        PREADY2,
    input  logic        PREADY3,
    input  logic        PREADY4,
    // Internal Interface Signals
    input  logic        transfer,
    output logic        ready,
    input  logic        write,
    input  logic [31:0] addr,
    input  logic [31:0] wdata,
    output logic [31:0] rdata
);
    logic [4:0] pselx;
    logic [2:0] mux_sel;
    logic decoder_en;
    logic [31:0] temp_addr_reg, temp_wdata_reg;
    logic temp_write_reg;
    logic [31:0] temp_addr_next, temp_wdata_next;
    logic temp_write_next;

    assign PSEL0 = pselx[0];
    assign PSEL1 = pselx[1];
    assign PSEL2 = pselx[2];
    assign PSEL3 = pselx[3];
    assign PSEL4 = pselx[4];

    typedef enum {
        IDLE,
        SETUP,
        ACCESS
    } apb_state_e;

    apb_state_e state, state_next;

    always_ff @(posedge PCLK, posedge PRESET) begin
        if (PRESET) begin
            state          <= IDLE;
            temp_addr_reg  <= 0;
            temp_wdata_reg <= 0;
            temp_write_reg <= 0;
        end else begin
            state          <= state_next;
            temp_addr_reg  <= temp_addr_next;
            temp_wdata_reg <= temp_wdata_next;
            temp_write_reg <= temp_write_next;
        end
    end

    always_comb begin
        state_next      = state;
        decoder_en      = 1'b0;
        PENABLE         = 1'b0;
        temp_addr_next  = temp_addr_reg;
        temp_wdata_next = temp_wdata_reg;
        temp_write_next = temp_write_reg;
        PADDR           = temp_addr_reg;
        PWRITE          = temp_write_reg;
        PWDATA          = temp_wdata_reg;
        case (state)
            IDLE: begin
                decoder_en = 1'b0;
                if (transfer) begin
                    state_next = SETUP;
                    temp_addr_next = addr;
                    temp_wdata_next = wdata;
                    temp_write_next = write;
                end
            end
            SETUP: begin
                decoder_en = 1'b1;
                PENABLE    = 1'b0;
                PADDR      = temp_addr_reg;
                PWRITE     = temp_write_reg;
                state_next = ACCESS;
                if (temp_write_reg) begin
                    PWDATA = temp_wdata_reg;
                end
            end
            ACCESS: begin
                decoder_en = 1'b1;
                PENABLE    = 1'b1;
                if (ready) begin
                    state_next = IDLE;
                end
            end
        endcase
    end

    APB_Decoder U_APB_Decoder (
        .en     (decoder_en),
        .sel    (temp_addr_reg),
        .y      (pselx),
        .mux_sel(mux_sel)
    );

    APB_Mux U_APB_Mux (
        .sel   (mux_sel),
        .rdata0(PRDATA0),
        .rdata1(PRDATA1),
        .rdata2(PRDATA2),
        .rdata3(PRDATA3),
        .rdata4(PRDATA4),
        .ready0(PREADY0),
        .ready1(PREADY1),
        .ready2(PREADY2),
        .ready3(PREADY3),
        .ready4(PREADY4),
        .rdata (rdata),
        .ready (ready)
    );
endmodule

module APB_Decoder (
    input  logic        en,
    input  logic [31:0] sel,
    output logic [ 4:0] y,
    output logic [ 2:0] mux_sel
);
    always_comb begin
        y = 5'b00000;
        if (en) begin
            casex (sel)
                32'h1000_0xxx: y = 5'b00001;
                32'h1000_1xxx: y = 5'b00010;
                32'h1000_2xxx: y = 5'b00100;
                32'h1000_3xxx: y = 5'b01000;
                32'h1000_4xxx: y = 5'b10000;
            endcase
        end
    end

    always_comb begin
        mux_sel = 3'bxx;
        if (en) begin
            casex (sel)
                32'h1000_0xxx: mux_sel = 3'b000;
                32'h1000_1xxx: mux_sel = 3'b001;
                32'h1000_2xxx: mux_sel = 3'b010;
                32'h1000_3xxx: mux_sel = 3'b011;
                32'h1000_4xxx: mux_sel = 3'b100;
            endcase
        end
    end
endmodule

module APB_Mux (
    input  logic [ 2:0] sel,
    input  logic [31:0] rdata0,
    input  logic [31:0] rdata1,
    input  logic [31:0] rdata2,
    input  logic [31:0] rdata3,
    input  logic [31:0] rdata4,
    input  logic        ready0,
    input  logic        ready1,
    input  logic        ready2,
    input  logic        ready3,
    input  logic        ready4,
    output logic [31:0] rdata,
    output logic        ready
);
    always_comb begin
        rdata = 32'd0;
        case (sel)
            3'b000: rdata = rdata0;
            3'b001: rdata = rdata1;
            3'b010: rdata = rdata2;
            3'b011: rdata = rdata3;
            3'b100: rdata = rdata4;
        endcase
    end

    always_comb begin
        ready = 1'b0;
        case (sel)
            3'b000: ready = ready0;
            3'b001: ready = ready1;
            3'b010: ready = ready2;
            3'b011: ready = ready3;
            3'b100: ready = ready4;
        endcase
    end
endmodule
