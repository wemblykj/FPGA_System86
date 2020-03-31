// This module will take incoming horizontal and veritcal sync pulses and
// create Row and Column counters based on these syncs.
// It will align the Row/Col counters to the output Sync pulses.
// Useful for any module that needs to keep track of which Row/Col position we
// are on in the middle of a frame
module Sync_To_Count 
 #(parameter TOTAL_COLS = 800,
   parameter TOTAL_ROWS = 525)
  (input            i_Rst,
   input            i_Clk,
   input            i_nHSync,
   input            i_nVSync, 
	output reg       o_Locked = 0,
   output reg       o_nHSync = 1,
   output reg       o_nVSync = 1,
   output reg [9:0] o_Col_Count = 0,
   output reg [9:0] o_Row_Count = 0);
   
   wire w_Frame_Start;
	reg w_Locked;
	reg w_nHSync;
	reg w_nVSync;
   reg [9:0] w_Col_Count;
   reg [9:0] w_Row_Count;
	
  // Keep track of Row/Column counters, perform on negative edge so counter starts at zero for the first pulse.
  always @(negedge i_Clk)
  begin
    if (i_Rst) begin
			w_Col_Count <= 0;
			w_Row_Count <= 0;
			w_Locked <= 0;
			w_nHSync <= 1;
			w_nVSync <= 1;
	 end else begin
		 if (w_Frame_Start == 1'b1)
		 begin
			w_Col_Count <= 0;
			w_Row_Count <= 0;
			w_Locked <= 1;
		 end
		 else
		 begin
			if (o_Col_Count == TOTAL_COLS-1)
			begin
			  if (o_Row_Count == TOTAL_ROWS-1)
			  begin
				 w_Row_Count <= 0;
			  end
			  else
			  begin
				 w_Row_Count <= o_Row_Count + 1;
			  end
			  w_Col_Count <= 0;
			end
			else
			begin
			  w_Col_Count <= o_Col_Count + 1;
			end
		 end
		 
		 w_nVSync <= i_nVSync;
		 w_nHSync <= i_nHSync;
	 end
  end
  
  // Register counters and syncs to align with output data.
  always @(posedge i_Clk)
  begin
	 o_Locked <= w_Locked;
	 o_Col_Count <= w_Col_Count;
	 o_Row_Count <= w_Row_Count;
	 o_nVSync <= w_nVSync;
    o_nHSync <= w_nHSync;
  end
    
  // Look for falling edge on Vertical Sync to reset the counters
  assign w_Frame_Start = (w_nVSync & ~i_nVSync);

endmodule
