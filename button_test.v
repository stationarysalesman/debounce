// --------------------------------------------------------------------
// Copyright (c) 2019 by Tyler Camp
// --------------------------------------------------------------------
//
// he make display go BPOIEPEPROIJ
//
//

module button_test	(
							clk,	
							button,
							ledg
						);
					
input						clk;
input 					button;
output					ledg;		

//=======================================================
//  REG/WIRE declarations
//=======================================================
wire button;
reg ledg;

//=======================================================
//  Structural coding
//=======================================================
always @(posedge clk)
	ledg <= button;

endmodule
