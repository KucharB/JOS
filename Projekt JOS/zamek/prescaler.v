module prescaler#(parameter width = 20)(
    input ce,
    input clk,
    input clr,
    output co
);

reg [width-1:0] count;

always @(posedge clk)  begin
        if(clr)
            begin
                count <= {l_bit{1'b0}};
            end
        else
            begin
                if (ce)  begin
                        count <= count + 1;
                    end
                else 
            end
    end

assign co = (ce & (&count)) | ~ce ;

endmodule