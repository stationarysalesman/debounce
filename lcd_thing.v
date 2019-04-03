// --------------------------------------------------------------------
// Copyright (c) 2019 by Tyler Camp
// --------------------------------------------------------------------
//
// he make display go BPOIEPEPROIJ
//
//

module lcd_thing	(
							clk,	
							data_out_en,
							data_out_on,
							data_out_rs,
							data_out_rw,
							data_out
						);
					
input						clk;
output					data_out_en;
output						data_out_on;
output						data_out_rs;
output						data_out_rw;
inout						data_out;
									

//=======================================================
//  REG/WIRE declarations
//=======================================================
parameter	preset_val 	= 0;
parameter 	counter_max = 500000000; 

reg						data_out_en = 1;
reg						data_out_on;
reg						data_out_rs;
reg 						data_out_rw;
reg			[7:0]			data_out;									
reg			[26:0]		counter = 0;
reg			[7:0]			val = 8'b10101010;
reg						ck_stb = 0;
reg 						busy = 0;
reg			[7:0]		check;
`timescale 1ns/100ps

initial
begin


// initialization
data_out_on = 1;
#5000000 data_out_rs = 0;
#5000000 data_out_rw = 0;
#5000000 data_out = 8'b00110000;

#5000000 data_out = 8'b00110000;
#5000000 data_out = 8'b00110000;
#5000000 data_out = 8'b00111100; //font and line num
#5000000 data_out = 8'b00001000; // display off
#5000000 data_out = 8'b00000001; // display clear
#5000000 data_out = 8'b00000100; // entry set 

// set memory location to write to 
#5000000 data_out_rs = 0;
#5000000 data_out_rw = 0;
#5000000 data_out = 8'b10000001;

// get ready to write data
#5000000 data_out_rs = 1;
#5000000 data_out = 8'b10000001;
end

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
		val <= ~val;
	end
	
	//data_out		<=	val;
	
end
			
				

endmodule
