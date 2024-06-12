module pipo#(parameter width = 16)
    (
    input clr,
    input clk,
    input load,
    input [width - 1:0] data_i,
    output reg [width - 1:0] data_o
);

always @(posedge clk or posedge clr) 
begin
    if (clr)  begin
            data_o <= {width{1'b0}};
        end
    else if (clk)  begin
            if (load) begin
                data_o <= data_i;
                end
        end
end
endmodule