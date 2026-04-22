`timescale 1ns / 1ps

module tb_lap_register;

    reg clk;
    reg rst;
    reg lap_btn;
    reg [15:0] time_in;

    wire [15:0] lap0;
    wire [15:0] lap1;
    wire [15:0] lap2;
    wire [1:0] lap_count;

    // Instantiate DUT
    lap_register #(
        .N(16)
    ) uut (
        .clk(clk),
        .rst(rst),
        .lap_btn(lap_btn),
        .time_in(time_in),
        .lap0(lap0),
        .lap1(lap1),
        .lap2(lap2),
        .lap_count(lap_count)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        lap_btn = 0;
        time_in = 0;

        // Release reset
        #20;
        rst = 0;

        // ---- LAP 1 ----
        time_in = 16'd100;
        #10 lap_btn = 1;
        #10 lap_btn = 0;

        // ---- LAP 2 ----
        #20;
        time_in = 16'd200;
        #10 lap_btn = 1;
        #10 lap_btn = 0;

        // ---- LAP 3 ----
        #20;
        time_in = 16'd300;
        #10 lap_btn = 1;
        #10 lap_btn = 0;

        // ---- LAP 4 (overwrite lap0) ----
        #20;
        time_in = 16'd400;
        #10 lap_btn = 1;
        #10 lap_btn = 0;

        #50;
        $finish;
    end

endmodule
