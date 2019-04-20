// --------------------------------------------------------------------
// Copyright (c) 2019 by Tyler Camp
// --------------------------------------------------------------------
//
// he make display go BPOIEPEPROIJ
//
//

module timer_thing	(
							clk,	
							start,
							time_vec1,
							time_vec2,
							time_vec3,
							time_vec4,
							time_vec5,
							fraction_tens,
							fraction_ones,
							motor_signal
						);
					
input						clk;
input 					start;
output					time_vec1;
output					time_vec2;
output					time_vec3;
output					time_vec4;
output					time_vec5;
output					fraction_tens;
output					fraction_ones;	
output					motor_signal;

//=======================================================
//  REG/WIRE declarations
//=======================================================
parameter	preset_val 	= 0;
parameter 	counter_max = 50000000; 

reg 			[7:0] 	time_vec1;
reg 			[7:0] 	time_vec2;
reg 			[7:0] 	time_vec3;
reg 			[7:0] 	time_vec4;
reg 			[7:0] 	time_vec5;
reg 			clk_stb = 0;
reg 			[31:0] elapsed_time = 32'b0;
reg 			[26:0] counter = 0;
reg 			start_counting = 0; // flag goes to high when collection starts
reg [4:0] minutes;
reg [5:0] seconds;

// each digit is set separately
reg [3:0] minutes_tens = 0;
reg [3:0] minutes_ones = 0;
reg [3:0] seconds_tens = 0;
reg [3:0] seconds_ones = 0;

// the fraction number
reg [7:0] fraction_tens = 0;
reg [7:0] fraction_ones = 0;

// signal to turn motor_signal
reg motor_signal = 0;
//=======================================================
//  Structural coding
//=======================================================
always @(posedge clk)
	if (start) start_counting <= 1;
	
always @(posedge clk)
	clk_stb <= (counter == counter_max - 1'b1);
	
always @(posedge clk)
begin
	if (counter == counter_max)
		counter <= 0;
	else 
		counter <= counter + 1'b1;
end
			
always @(posedge clk)
begin
	minutes <= elapsed_time / 60;
	seconds <= elapsed_time % 60;
	
	// each digit is set separately
	minutes_tens <= minutes / 10;
	minutes_ones <= minutes % 10;
	seconds_tens <= seconds / 10;
	seconds_ones <= seconds % 10;
	fraction_tens <= 8'h30 | ((elapsed_time / 30) / 10);
	fraction_ones <= 8'h30 | ((elapsed_time / 30) % 10);
end

always @(posedge clk)
begin
	if (start_counting && clk_stb)
	begin
		elapsed_time <= elapsed_time + 1'b1;
		motor_signal <= (elapsed_time != 0) & (elapsed_time % 30 == 0);
	end
	else
		motor_signal <= 0;
end

always @(posedge clk)
begin	
		// assign values to the vector based on table
		time_vec1 <= 8'h30 | minutes_tens;
		time_vec2 <= 8'h30 | minutes_ones;
		time_vec3 <= 8'h3a; // :
		time_vec4 <= 8'h30 | seconds_tens;
		time_vec5 <= 8'h30 | seconds_ones;
end
		

endmodule
