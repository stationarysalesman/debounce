// --------------------------------------------------------------------
// Copyright (c) 2019 by Tyler Camp
// --------------------------------------------------------------------
//
// he make display go BPOIEPEPROIJ
//
//

module led_thing	(
							clk,	
							data_out
						);
					
input						clk;
output						data_out;
									

//=======================================================
//  REG/WIRE declarations
//=======================================================
parameter	preset_val 	= 0;
parameter 	counter_max = 25000000; 


reg						data_out;									
reg			[26:0]		counter = 0;
reg						val = 0;
reg						ck_stb = 0;
//=======================================================
//  Structural coding
//=======================================================

always @(posedge clk)
	ck_stb <= (counter == counter_max-1'b1);

always @(posedge clk)
begin
		if (counter == counter_max)
		begin
			counter <= 0;
		end
		else
		begin
			counter <= counter + 1'b1;
		end
		
end

always	@(posedge clk)
begin
	if (ck_stb)
	begin
		val <= !val;
	end
	
	data_out		<=	val;
	
end
			
				

endmodule
