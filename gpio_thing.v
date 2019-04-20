// --------------------------------------------------------------------
// Copyright (c) 2019 by Tyler Camp
// --------------------------------------------------------------------
//
// he make display go BPOIEPEPROIJ
//
//

module gpio_thing	(
							clk,	
							gpio,
							gpio_en,
							motor_signal
						);
					
input						clk;
inout 					gpio;
inout						gpio_en;
input						motor_signal; 					

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [31:0]	counter_max = 500000;
wire [32:0] motor_signal;
parameter counter_max2 = 50000000;
reg 			clk_stb = 0;
reg [31:0]	counter = 0;
reg gpio = 0;
reg gpio_en = 1;

reg motor_turning = 0; // set HIGH when motor is turning
reg [31:0] num_steps = 20; // number of steps taken by the motor
//=======================================================
//  Structural coding
//=======================================================

always @(posedge clk)
	clk_stb <= (counter == counter_max - 1'b1);
	
always @(posedge clk)
	gpio_en <= 1'b1;

always @(posedge clk)
begin
	if (counter == counter_max)
		counter <= 0;
	else 
		counter <= counter + 1'b1;
end


always @(posedge clk)
begin
if (motor_signal)
	num_steps <= 0;
else
	begin	
		if (clk_stb && num_steps < 20)
		begin
			gpio = !gpio; 
			num_steps = num_steps + 1'b1;	
		end

	end
end

endmodule
