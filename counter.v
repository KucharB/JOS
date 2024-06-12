module counter#(parameter width = 4, parameter modulus = 10)(
    input clr,
    input clk,
    input ce,
    output reg [width-1:0] data,
    output cout
);

//reg [width - 1:0] data;

    always @(posedge clk or posedge clr)    begin
        if (clr)
            begin
                data <= {width{1'b0}};
            end
        else
            begin
                if(ce)  begin
                        if(data != (modulus))  begin
                                data <= data + 1;
                            end
                      
                    end
            end
    end
    assign cout = ce & (data != (modulus-1));
endmodule