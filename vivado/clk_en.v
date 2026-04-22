
module clk_en #(
    // #() after a module name introduces a parameter list
    parameter MAX = 1_000_000  //! Number of clock cycles between pulses
)(
    input  wire i_clk,  //! Main clock
    input  wire i_rst,  //! High-active synchronous reset
    output reg  o_ce    //! One-clock-cycle enable pulse
);

    // Internal counter
    reg [$clog2(MAX)-1:0] cnt;
    // $clog2(MAX) -- Ceiling of log2(x) returns the minimum
    // number of bits required

    //! Clocked, sequential process, triggered when `i_clk`
    //! rises from 0 to 1 (positive edge of a signal)
    always @(posedge i_clk) begin
        if (i_rst) begin
            o_ce <= 1'b0;  // Reset output
            cnt  <= 0;     // Reset internal counter
        end
        else if (cnt == MAX-1) begin
            o_ce <= 1'b1;  // Generate one-cycle pulse
            cnt  <= 0;     // Reset internal counter
        end
        else begin
            o_ce <= 1'b0;  // Clear output
            cnt  <= cnt + 1'b1;  // Increment internal counter
        end
    end

endmodule

