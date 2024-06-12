module prescaler_s#(parameter width = 29, parameter modulus = 50000000 )(
    input ce,
    input clk,
    input clr,
    output co
);

reg [width-1:0] count;

always @(posedge clk) begin
    if(clr) begin
        count <= {width{1'b0}};
    end else begin
        if (ce) begin
            if (count == (modulus - 1)) begin
                count <= {width{1'b0}};
            end else begin
                count <= count + 1;
            end
        end
    end
end

assign co = (count == (modulus - 1)) & ce;

endmodule