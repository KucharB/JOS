module comparator(
    input clk,
    input [15:0] a_i,
    input [15:0] b_i,
    output reg eq
);

always @(posedge clk)

eq <= (a_i == b_i);

endmodule