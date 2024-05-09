
module led_driver_test(
    input clk,
    input [3:0] command,
    output [3:0] led,
    output alarm
)

led_driver dri1(.command(command), .clk(clk), .blink(co), .alarm(alarm), .led(led));
prescaler pres1(.ce(command(3)), .clk(clk), .clr(1'b0), .co(co));


endmodule