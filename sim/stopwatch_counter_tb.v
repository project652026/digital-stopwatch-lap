`timescale 1ns / 1ps

module tb_stopwatch_counter;

    reg clk;
    reg rst;
    reg en;
    reg tick;
    wire [15:0] time_out;

    // DUT
    stopwatch_counter #(
        .N(16)
    ) uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .tick(tick),
        .time_out(time_out)
    );

    // clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        en = 0;
        tick = 0;

        // Hold reset
        #20;
        rst = 0;

        // Test 1: enable counting
        en = 1;

        // 3 tick pulses
        #10 tick = 1;
        #10 tick = 0;

        #20 tick = 1;
        #10 tick = 0;

        #20 tick = 1;
        #10 tick = 0;

        // Test 2: stop counting
        #20;
        en = 0;

        #10 tick = 1;
        #10 tick = 0;

        // Test 3: resume counting
        #20;
        en = 1;

        #10 tick = 1;
        #10 tick = 0;

        // Test 4: reset while running
        #20;
        rst = 1;
        #10;
        rst = 0;

        // Test 5: count again after reset
        #20 tick = 1;
        #10 tick = 0;

        #40;
        $finish;
    end

endmodule
