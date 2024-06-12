`include "counter.v"

`timescale 1ns/100ps

module counter_tb();

reg clr;
reg clk;
reg ce;


wire [3:0] data_o;
wire [3:0] data_1;
wire cout;

counter UUT(clr, clk, ce, data_o, count);

counter UUT1(clr, clk, count, data_1, x);

initial 
    begin
    #0 clr = 1'b1; clk = 1'b0; ce = 1'b0;
    #10 ce = 1'b1;
    #10 clr = 1'b0;
    #4 ce = 1'b0;
    #18 ce = 1'b1;
    #300 $finish;
    end

initial
    begin
        forever begin
            #5 clk = ~clk;
        end
    end

initial
    begin
        $dumpfile("counter.vcd");
        $dumpvars;
        $dumpon;
    end


endmodule
