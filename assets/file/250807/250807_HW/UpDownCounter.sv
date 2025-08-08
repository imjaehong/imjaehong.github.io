`timescale 1ns / 1ps

module UpDownCounter (
    input  logic        clk,
    input  logic        reset,
    input  logic        sw_mode,
    input  logic        btn_L,
    input  logic        btn_R,
    output logic [ 3:0] led,
    output logic [13:0] count
);

    logic tick_10hz;
    logic runstop, clear;
    logic state;

    clk_div_10hz U_CLK_DIV_10HZ (
        .clk      (clk),
        .reset    (reset),
        .tick_10hz(tick_10hz)
    );

    up_down_counter U_UP_DOWN_COUNTER (
        .clk  (clk),
        .reset(reset),
        .tick (tick_10hz & runstop),
        .mode (sw_mode),
        .clear(clear),
        .toggle_state(state),
        .count(count)
    );

    cu U_CU (
        .clk    (clk),
        .reset  (reset),
        .btn_L  (btn_L),
        .btn_R  (btn_R),
        .runstop(runstop),
        .clear  (clear)
    );

    state_led U_state_led (
        .runstop(runstop),
        .clear(clear),
        .mode(state),
        .led(led)
    );

endmodule


module clk_div_10hz (
    input  logic clk,
    input  logic reset,
    output logic tick_10hz
);

    //logic [23:0] div_counter;
    logic [$clog2(10_000_000)-1:0] div_counter;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            div_counter <= 0;
            tick_10hz   <= 1'b0;
        end else begin
            if (div_counter == 10_000_000 - 1) begin
                div_counter <= 0;
                tick_10hz   <= 1'b1;
            end else begin
                div_counter <= div_counter + 1;
                tick_10hz   <= 1'b0;
            end
        end
    end

endmodule


module up_down_counter (
    input  logic        clk,
    input  logic        reset,
    input  logic        tick,
    input  logic        mode,
    input  logic        clear,
    output logic        toggle_state,
    output logic [13:0] count
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            toggle_state <= 0;
        end else begin
            if (mode) begin
                toggle_state <= ~toggle_state;
            end
        end
    end

    always_ff @(posedge clk, posedge reset) begin
        if (reset | clear) begin
            count <= 0;
        end else begin
            if (toggle_state == 1'b0) begin  // up counter
                if (tick) begin
                    if (count == 9999) begin
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end
            end else begin  // down counter
                if (tick) begin
                    if (count == 0) begin
                        count <= 9999;
                    end else begin
                        count <= count - 1;
                    end
                end
            end
        end
    end

endmodule


module cu (
    input  logic clk,
    input  logic reset,
    input  logic btn_L,
    input  logic btn_R,
    output logic runstop,
    output logic clear
);

    typedef enum {
        STOP,
        RUN,
        CLEAR
    } state_e;

    state_e state, next_state;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= STOP;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        runstop = 0;
        clear = 0;

        case (state)
            STOP: begin
                runstop = 0;
                clear   = 0;
                if (btn_L) begin
                    next_state = CLEAR;
                end else if (btn_R) begin
                    next_state = RUN;
                end
            end
            CLEAR: begin
                clear = 1;
                if (btn_L) begin
                    next_state = STOP;
                end
            end
            RUN: begin
                runstop = 1;
                if (btn_R) begin
                    next_state = STOP;
                end
            end
        endcase
    end

endmodule


module state_led (
    input  logic       runstop,
    input  logic       clear,
    input  logic       mode,
    output logic [3:0] led
);  // (condition) ? true : false
    assign led[1:0] = mode ? 2'b10 : 2'b01;
    assign led[3:2] = runstop ? 2'b10 : 2'b01;

endmodule
