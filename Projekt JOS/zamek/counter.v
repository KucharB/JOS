module counter#(parameter width = 4, parameter modulus = 10)(
    input clr,
    input clk,
    input ce,
    output reg [width - 1:0] data,
    output cout
);

    always @(posedge clk)
        if (clr)
            begin
                data <= {width{1'b0}};
            end
        else
            begin
                if(ce)
                    begin
                        if(data != (modulus - 1))
                            begin
                                data = data + 1;
                            end
                        else
                            begin
                                data = {width{1'b0}};
                            end
                    end
            end

    assign cout = ce & (data == (modulus - 1));
endmodule