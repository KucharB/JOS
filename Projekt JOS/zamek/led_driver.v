module led_driver(
input [2:0] command,
input clk,
input blink,
output reg alarm,
output [3:0] led 
);

reg [3:0] internal_led;

always @(posedge clk)   begin
    case(command) 
        3'b000 : internal_led <= 4'b0000;
        3'b001 : internal_led <= 4'b0001;
        3'b010 : internal_led <= 4'b0011;
        3'b011 : internal_led <= 4'b0111;
        3'b100 : internal_led <= 4'b1111;
        3'b101 : alarm <= 1'b1;
        3'b110 : alarm <= 1'b0;
        default : 
            internal_led <= 4'b0000;
            alarm <= 1'b0; 
    endcase

    assign led = blink & internal_led;
end
endmodule