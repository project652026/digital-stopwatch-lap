`timescale 1ns / 1ps

module lap_register #(
    parameter N = 16
)(
    input wire clk,
    input wire rst,
    input wire lap_btn,
    input wire [N-1:0] time_in,

    output reg [N-1:0] lap0,
    output reg [N-1:0] lap1,
    output reg [N-1:0] lap2,
    output reg [1:0] lap_count
);

    reg [1:0] write_ptr;

    always @(posedge clk) begin
        if (rst) begin
            lap0 <= 0;
            lap1 <= 0;
            lap2 <= 0;
            lap_count <= 0;
            write_ptr <= 0;
        end
        else if (lap_btn) begin
            case (write_ptr)
                2'd0: lap0 <= time_in;
                2'd1: lap1 <= time_in;
                2'd2: lap2 <= time_in;
                default: lap0 <= time_in;
            endcase

            if (lap_count < 3)
                lap_count <= lap_count + 1'b1;

            if (write_ptr == 2'd2)
                write_ptr <= 0;
            else
                write_ptr <= write_ptr + 1'b1;
        end
    end

endmodule
