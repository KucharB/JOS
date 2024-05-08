module comparator(
    input [15:0] a_i,
    input [15:0] b_i,
    output eq
);

assign eq = (a_i == b_i);

endmodule