module shifting_pipo
(
    input clr,
    input clk,
    input load,
    input [3:0] data_in,
    output [15:0] data_o
);

pipo #(.width(4)) reg0 (.clr(clr), .clk(clk), .load(load), .data_i(data_o[7:4]), .data_o(data_o[3:0]));
pipo #(.width(4)) reg1 (.clr(clr), .clk(clk), .load(load), .data_i(data_o[11:8]), .data_o(data_o[7:4]));
pipo #(.width(4)) reg2 (.clr(clr), .clk(clk), .load(load), .data_i(data_o[15:12]), .data_o(data_o[11:8]));
pipo #(.width(4)) reg3 (.clr(clr), .clk(clk), .load(load), .data_i(data_in), .data_o(data_o[15:12]));



endmodule

