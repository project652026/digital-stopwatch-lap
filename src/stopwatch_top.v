`timescale 1ns / 1ps

module top (
    input wire clk,
    input wire btnd, // Start / Stop
    input wire btnu, // Reset
    input wire btnr, // Save lap
    input wire btnl, // Browse/display stored lap

    output wire [6:0] seg,
    output wire [7:0] an,
    output wire dp
);

    //------------------------------------------------------------
    // Button signals after debouncing
    //------------------------------------------------------------
    wire btnd_state;
    wire btnu_state;
    wire btnr_state;
    wire btnl_state;

    wire btnd_press;
    wire btnu_press;
    wire btnr_press;
    wire btnl_press;

    //------------------------------------------------------------
    // System reset
    // btnu_press is used as reset for the stopwatch logic
    //------------------------------------------------------------
    wire rst;
    assign rst = btnu_press;

    //------------------------------------------------------------
    // Debouncers
    // One debouncer is used for each physical button
    //------------------------------------------------------------
    debounce db_start_stop (
        .clk(clk),
        .rst(1'b0),
        .btn_in(btnd),
        .btn_state(btnd_state),
        .btn_press(btnd_press)
    );

    debounce db_reset (
        .clk(clk),
        .rst(1'b0),
        .btn_in(btnu),
        .btn_state(btnu_state),
        .btn_press(btnu_press)
    );

    debounce db_lap (
        .clk(clk),
        .rst(1'b0),
        .btn_in(btnr),
        .btn_state(btnr_state),
        .btn_press(btnr_press)
    );

    debounce db_display (
        .clk(clk),
        .rst(1'b0),
        .btn_in(btnl),
        .btn_state(btnl_state),
        .btn_press(btnl_press)
    );

    //------------------------------------------------------------
    // Stopwatch running state
    // btnd toggles running/paused
    //------------------------------------------------------------
    reg running = 1'b0;

    always @(posedge clk) begin
        if (rst) begin
            running <= 1'b0;
        end
        else if (btnd_press) begin
            running <= ~running;
        end
    end

    //------------------------------------------------------------
    // Clock enable for stopwatch timing
    // 100 MHz / 1,000,000 = 100 Hz -> 10 ms tick
    //------------------------------------------------------------
    wire tick_10ms;

    clk_en #(
        .MAX(1_000_000)
    ) stopwatch_tick (
        .clk(clk),
        .rst(rst),
        .ce(tick_10ms)
    );

    //------------------------------------------------------------
    // Stopwatch counter
    //------------------------------------------------------------
    wire [15:0] time_value;

    stopwatch_counter #(
        .N(16)
    ) counter_inst (
        .clk(clk),
        .rst(rst),
        .en(running),
        .tick(tick_10ms),
        .time_out(time_value)
    );

    //------------------------------------------------------------
    // Lap register: stores up to 3 lap values
    //------------------------------------------------------------
    wire [15:0] lap0;
    wire [15:0] lap1;
    wire [15:0] lap2;
    wire [1:0] lap_count;

    lap_register #(
        .N(16)
    ) lap_inst (
        .clk(clk),
        .rst(rst),
        .lap_btn(btnr_press),
        .time_in(time_value),
        .lap0(lap0),
        .lap1(lap1),
        .lap2(lap2),
        .lap_count(lap_count)
    );

    //------------------------------------------------------------
    // Display selection
    // Each btnl press cycles:
    // 0 = live time
    // 1 = lap0
    // 2 = lap1
    // 3 = lap2
    //------------------------------------------------------------
    reg [1:0] display_mode = 2'd0;

    always @(posedge clk) begin
        if (rst) begin
            display_mode <= 2'd0;
        end
        else if (btnl_press) begin
            if (display_mode == lap_count)
                display_mode <= 2'd0;
            else
                display_mode <= display_mode + 1'b1;
        end
    end

    reg [15:0] selected_value;

    always @(*) begin
        case (display_mode)
            2'd0: selected_value = time_value;
            2'd1: selected_value = lap0;
            2'd2: selected_value = lap1;
            2'd3: selected_value = lap2;
            default: selected_value = time_value;
        endcase
    end

    //------------------------------------------------------------
    // Display driver
    // Current driver expects 32-bit input, so extend 16-bit value
    //------------------------------------------------------------
    display_driver display_inst (
        .clk(clk),
        .rst(rst),
        .i_time({16'd0, selected_value}),
        .i_lap(32'd0),
        .i_sel(1'b0),
        .seg(seg),
        .an(an),
        .dp(dp)
    );

endmodule
