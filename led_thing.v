// --------------------------------------------------------------------
// Copyright (c) 2019 by Tyler Camp
// --------------------------------------------------------------------
//
// he make display go BPOIEPEPROIJ
//
//

module led_thing	(
							clk,	
							switches,
							led_out,
							fraction
						);
					
input						clk;
input						switches;
output					led_out;
output					fraction;		

//=======================================================
//  REG/WIRE declarations
//=======================================================
parameter	preset_val 	= 0;
parameter 	counter_max = 50000000; 

wire			[9:0]		switches;
reg			[9:0]		led_out;
reg 			[7:0] 	fraction;
//=======================================================
//  Structural coding
//=======================================================

always @(posedge clk)
begin
	if (switches[5]) fraction <= 8'h35;
	else if (switches[4]) fraction <= 8'h34;
	else if (switches[3]) fraction <= 8'h33;
	else if (switches[2]) fraction <= 8'h32;
	else if (switches[1]) fraction <= 8'h31;
	else fraction <= 8'h30;
end
			
				

endmodule
