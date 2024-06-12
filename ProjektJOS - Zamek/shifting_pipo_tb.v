`include "shifting_pipo.v"

module shifting_pipo_tb();

reg clr;
reg clk;
reg ce;
reg [3:0] data_i;
wire [15:0] data_o;

shifting_pipo UUT(clr, clk, ce, data_i, data_o);

initial 
    begin
    #0 clr = 1'b1; clk = 1'b0; ce = 1'b0; data_i = 4'd0;
    #10 ce = 1'b1;
    #10 clr = 1'b0;
    #10 data_i = 4'd1;
    #10 data_i = 4'd2;
    #4 ce = 1'b0;
    #18 ce = 1'b1;
    #10 data_i = 4'd3;
    #10 data_i = 4'd4;
    #20 clr = 1'b1;
    #10 $finish;
    end

initial
    begin
        forever begin
            #5 clk = ~clk;
        end
    end

initial
    begin
        $dumpfile("shifting_pipo.vcd");
        $dumpvars;
        $dumpon;
    end


endmodule

