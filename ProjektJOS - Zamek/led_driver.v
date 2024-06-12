module led_driver(
input [2:0] command,
input clk,
input blink,
input alarm,
output reg alarm_led,
output [3:0] led 
);

reg [3:0] internal_led;

always @(posedge clk)   begin
	if(alarm)
		  alarm_led <= 1'b1;
		  else
        alarm_led <= 1'b0;
		  
    case(command) 
        3'b000 : internal_led <= 4'b0000;
        3'b001 : internal_led <= 4'b0001;
        3'b010 : internal_led <= 4'b0011;
        3'b011 : internal_led <= 4'b0111;
        3'b100 : internal_led <= 4'b1111;
        default : begin
            internal_led <= 4'b0000;
            alarm_led <= 1'b0; 
				end
    endcase
end

 assign led = {4{blink}} & internal_led;
endmodule