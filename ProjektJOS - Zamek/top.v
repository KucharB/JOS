module top(
    input [3:0] data,
    input key,
    input clk,
    output [3:0] led,
    output alarm,
    output lock,
    output led9
);

wire [15:0] password_user;
wire [15:0] password_valid;
wire password_comparation_valid;
wire  key_push;
wire shift_shift_pipo;
wire reset_shift_pipo;
wire load_pipo;
wire alarm_on;
wire led_command;
wire blink_en;

shifting_pipo input_reg
(
    .clr(reset_shift_pipo),
    .clk(clk),
    .load(shift_shift_pipo),
    .data_in(data),
    data_o(password_user)
);

pipo internal_reg
    (
    .clr(1'b0),
    .clk(clk),
    .load(load_pipo),        
    .data_i(password_user),
    .data_o(password_valid)
);

comparator password_comparator(
    .clk(clk),
    .a_i(password_valid),
    .b_i(password_user),
    .eq(password_comparation_valid)
);

debouncer deb
(
	.clk(clk),
	clr(1'b0),
	.ce(1'b1),
	.s_in(key),
	.key_en(key_push)
);

machine_state fsm1(
    .clk(clk),
    .key(key_push),
    .pass_check(password_comparation_valid),
    .clr(1'b0),

    .LED_sterring(led_command),       
    .pipo_shift(shift_shift_pipo),
    .pipo_reset(reset_shift_pipo),
    .alarm(alarm_on),
	.output blink(blink_en),
    .pipo_load(load_pipo),
    .lock(lock)
);

led_driver 4led_driver(
.command(led_command),
.clk(clk),
.blink(blinker),
.alarm(alarm_on),
.alarm_led(alarm),
.led(led)
);

prescaler blinker_source(
    .ce(blink_en),
    .clk(clk),
    .clr(1'b0),
    .co(blinker)
);



endmodule

/*
set_location_assignment PIN_W17 -to alarm
set_location_assignment PIN_V16 -to led[0]
set_location_assignment PIN_W16 -to led[1]
set_location_assignment PIN_V17 -to led[2]
set_location_assignment PIN_V18 -to led[3]
set_location_assignment PIN_AF14 -to clk
set_location_assignment PIN_W19 -to lock
set_location_assignment PIN_AA14 -to clr
set_location_assignment PIN_AA15 -to key
set_location_assignment PIN_AB12 -to data[0]
set_location_assignment PIN_AC12 -to data[1]
set_location_assignment PIN_AF9 -to data[2]
set_location_assignment PIN_AF10 -to data[3]
set_location_assignment PIN_Y21 -to led9
*/