// --------------------------------------------------------------------
// Copyright (c) 2019 by Tyler Camp
// --------------------------------------------------------------------
//
// he make display go BPOIEPEPROIJ
//
//

module lcd_thing	(
							clk,	
							fraction,
							start,
							time_vec1,
							time_vec2,
							time_vec3,
							time_vec4,
							time_vec5,
							data_out_en,
							data_out_on,
							data_out_rs,
							data_out_rw,
							data_out
						);
					
input						clk;
input					fraction;
input					start;
input 				time_vec1;
input 				time_vec2;
input 				time_vec3;
input 				time_vec4;
input 				time_vec5;
output					data_out_en;
output						data_out_on;
output						data_out_rs;
output						data_out_rw;
inout						data_out;
									

//=======================================================
//  REG/WIRE declarations
//=======================================================
parameter	preset_val 	= 0;
parameter 	counter_max = 50000000;

wire			[7:0] 	fraction;
wire						start;
wire 			[7:0]		time_vec1;
wire 			[7:0]		time_vec2;
wire 			[7:0]		time_vec3;
wire 			[7:0]		time_vec4;
wire 			[7:0]		time_vec5;
reg						data_out_en;
reg						data_out_on = 1;
reg						data_out_rs;
reg 						data_out_rw;
reg			[7:0]			data_out;									


integer i = 0;
integer j = 1;

integer m = 0;
integer n = 23;

reg [7:0] Datas [1:38];
reg flag = 0;

//=======================================================
//  Structural coding
//=======================================================


initial
begin
Datas[1]   =  8'h38;   	//-- control instruction : configure - 2 lines, 5x7 matrix --
Datas[2]   =  8'h0C;   	//-- control instruction : Display on, cursor off --
Datas[3]   =  8'h06;   	//-- control instruction : Increment cursor : shift cursor to right --
Datas[4]   =  8'h01;   	//-- control instruction : clear display screen --
Datas[5]   =  8'h80;   	//-- control instruction : force cursor to begin at first line --

Datas[6]   =  8'h46;   	//-- F --
Datas[7]   =  8'h72;   	//-- r --
Datas[8]   =  8'h61;   	//-- a --
Datas[9]   =  8'h63;   	//-- c --
Datas[10]  =  8'h74;   	//-- t --
Datas[11]  =  8'h69;   	//-- i --
Datas[12]  =  8'h6F;   	//-- o --
Datas[13]  =  8'h6E;   	//-- n --
Datas[14]  =  8'h3A;   	//-- : --
Datas[15]  =  8'h20;   	//--   --

Datas[16]  =  8'h30;   	//-- 1 --
Datas[17]  =  8'h20;   	//--   --
Datas[18]  =  8'h20;   	//--   --

Datas[19]  =  8'h20;   	//--   --
Datas[20]  =  8'h20;   	//--   --
Datas[21]  =  8'h20;   	//--   --
Datas[22]  =  8'hC0;   	//-- control instruction : force cursor to move to 2nd Line --
Datas[23]  =  8'h52;   	//-- R --
Datas[24]  =  8'h65;   	//-- e --
Datas[25]  =  8'h61;   	//-- a --
Datas[26] =	8'h64;		//-- d --
Datas[27] = 8'h79;		//-- y --
Datas[28] = 8'h20;
Datas[29] = 8'h20;
Datas[30] = 8'h20;
Datas[31] = 8'h20;
Datas[31] = 8'h20;
Datas[32] = 8'h20;
Datas[33] = 8'h20;
Datas[34] = 8'h20;
Datas[35] = 8'h20;
Datas[36] = 8'h20;
Datas[37] = 8'h20;
Datas[38] = 8'h20;
end	


always @(posedge clk)
begin
	//Datas[16] <= fraction;
	
	if (flag)
	begin
		Datas[16] <= time_vec5;
		Datas[23] <= time_vec1;
		Datas[24] <= time_vec2;
		Datas[25] <= time_vec3;
		Datas[26] <= time_vec4;
		Datas[27] <= time_vec5;
	end
end
always @(posedge clk)
begin
if (start) flag <= 1;
end
	
always @(posedge clk)
begin
	//if (!flag)
	//begin
	//-- Delay for writing data
		
	  if (i <= 750000) begin
	  i = i + 1; data_out_en = 1;
	  data_out = Datas[j];
	  end
	  
	  else if (i > 750000 & i < 1500000) begin
	  i = i + 1; data_out_en = 0;
	  end
	  
	  else if (i == 1500000) begin
	  j = j + 1; i = 0;
	  end
	  else i = 0;
	  
	 //-- data_out_rs signal should be set to 0 for writing commands and to 1 for writing data

	  if (j <= 5 ) data_out_rs = 0;  
	  else if (j > 5 & j< 22) data_out_rs = 1;   
	  else if (j == 22) data_out_rs = 0;
	  else if (j > 22 & j < 27) data_out_rs = 1;
	  else if (j > 38) begin 
	  data_out_rs = 1; j = 5;
	  end
	 
	//end
	/*
	else if (flag)
	begin
	if (m <= 1000000) begin
		m = m + 1; data_out_en = 1;
		data_out = Datas[n];
	end
  
	else if (m > 1000000 & m < 2000000) begin
		m = m + 1; data_out_en = 0;
	end
  
	else if (m == 2000000) begin
		n = n + 1; m = 0;
	end
	else m = 0;
  
 //-- data_out_rs signal should be set to 0 for writing commands and to 1 for writing data

  if (n < 27) data_out_rs = 1;
  else if (n > 27) begin 
  data_out_rs = 1; n = 23;
  end
  
  end
	*/
	
	end
 
 
 
 
 
endmodule
