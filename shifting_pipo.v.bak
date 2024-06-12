`include "pipo.v"

module shifting_pipo
(
    input clr,
    input clk,
    input load,
    input [3:0] data_in,
    output [15:0] data_o
);

pipo reg0(.clr(clr), .clk(clk), .load(load), .data_i(data_o[7:4]), .data_o(data_o[3:0]));
pipo reg1(.clr(clr), .clk(clk), .load(load), .data_i(data_o[11:8]), .data_o(data_o[7:4]));
pipo reg2(.clr(clr), .clk(clk), .load(load), .data_i(data_o[15:12]), .data_o(data_o[11:8]));
pipo reg3(.clr(clr), .clk(clk), .load(load), .data_i(data_in), .data_o(data_o[15:12]));



endmodule

