// --------------------------------------------------------------------
// Copyright (c) 2019 by Tyler Camp
// --------------------------------------------------------------------
//
// he make display go BPOIEPEPROIJ
//
//

module gpio_thing	(
							clk,	
							gpio
						);
					
input						clk;
inout 					gpio;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [15:0]	counter_max = 56818; // approx 440Hz
parameter counter_max2 = 50000000;
parameter slide_rate = 1250; //how often to change frequency
reg 			clk_stb = 0;
reg			clk_stb2 = 0;
reg			clk_stb3 = 0;
reg [16:0]	counter = 0;
reg [26:0] counter2 = 0;
reg [15:0] counter3 = 0;
reg gpio = 0;
reg flip = 1; // strobe the signal every second
//=======================================================
//  Structural coding
//=======================================================
always @(posedge clk)
	clk_stb <= (counter == counter_max - 1'b1);
	
always @(posedge clk)
	clk_stb2 <= (counter2 == counter_max2 - 1'b1);
	
always @(posedge clk)
	clk_stb3 <= (counter3 == slide_rate - 1'b1);

always @(posedge clk)
begin
	if (counter == counter_max)
		counter <= 0;
	else 
		counter <= counter + 1'b1;
end

always @(posedge clk)
begin
	if (counter2 == counter_max2)
		counter2 <= 0;
	else
		counter2 <= counter2 + 1'b1;
	
end

always @(posedge clk)
begin
	if (counter3 == slide_rate)
		counter3 <= 0;
	else
		counter3 <= counter3 + 1'b1;
end


always @(posedge clk)
if (clk_stb && flip)
	gpio <= !gpio; 
		
// strobe
/*
always @(posedge clk)
	if (clk_stb2)
		flip <= !flip;
*/
	
always @(posedge clk)
	if (clk_stb3)
		if (counter_max < 10000)
			counter_max <= 113636;
		else
			counter_max <= counter_max - 1'b1;
endmodule
