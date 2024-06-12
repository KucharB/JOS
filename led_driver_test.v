module led_driver_test(
    input clk,
    input [3:0] command,
	 input al,
    output [3:0] led,
    output alarm
);

wire co;

led_driver dri1(.alarm(al), .command(command), .clk(clk), .blink(co), .alarm_led(alarm), .led(led));
prescaler pres1(.ce(command[3]), .clk(clk), .clr(1'b0), .co(co));


endmodule