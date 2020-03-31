// This module will take incoming horizontal and veritcal blank signals and
// create Row and Column counters based on the active pixel area.
// It will align the Row/Col counters to the output blank signals.
// Useful for any module that needs to keep track of which Row/Col position we
// are on in the active portion of a frame
module Blanking_To_Count 
 #(parameter ACTIVE_COLS = 640,
   parameter ACTIVE_ROWS = 480)
  (input            i_Rst,
   input            i_Clk,
	input       	  i_nHSync,
   input            i_nVSync,
   input            i_HBlank,
   input            i_VBlank, 
	output reg       o_Locked = 0,
	output reg       o_nHSync = 1,
   output reg       o_nVSync = 1,
   output reg       o_HBlank = 0,
   output reg       o_VBlank = 0,
	output reg       o_Active = 0,
   output reg [9:0] o_Col_Count = 0,
   output reg [9:0] o_Row_Count = 0
	);
   
   wire w_Frame_Start;
	wire w_Line_Start;
	reg [9:0] w_Col_Count;
   reg [9:0] w_Row_Count;
	reg w_Locked;
	reg w_nHSync;
	reg w_nVSync;
	reg w_HBlank;
	reg w_VBlank;
	
  // Register syncs to align with output data.
always @(posedge i_Clk) begin
	o_nHSync <= w_nHSync;
	o_nVSync <= w_nVSync;
	o_VBlank <= w_VBlank;
	o_HBlank <= w_HBlank;
	o_Active <= ~i_VBlank & ~i_HBlank;
	o_Col_Count <= ~i_VBlank & ~i_HBlank ? w_Col_Count : 10'bX;
	o_Row_Count <= ~i_VBlank & ~i_HBlank ? w_Row_Count : 10'bX; 
	o_Locked <= w_Locked;
end

// Keep track of Row/Column counters.
always @(negedge i_Clk) begin
	if (i_Rst) begin
		w_Locked <= 0;
		w_nHSync <= 1;
		w_nVSync <= 1;
		w_VBlank <= 0;
		w_HBlank <= 0;
		w_Col_Count <= 0;
		w_Row_Count <= 0;
	end else begin
		if (w_Frame_Start == 1'b1) begin
			w_Locked <= 1;
			w_Col_Count <= 0;
			w_Row_Count <= 0;
		end else if (w_Line_Start == 1'b1) begin
			w_Col_Count <= 0;
		end else if (w_Col_Count == ACTIVE_COLS-1) begin
			if (w_Row_Count == ACTIVE_ROWS-1) begin
				w_Row_Count <= 0;
			end else begin
				w_Row_Count <= w_Row_Count + 1;
			end
			w_Col_Count <= 0;
		end else begin
		w_Col_Count <= w_Col_Count + 1;
		end
		
		w_nHSync <= i_nHSync;
		w_nVSync <= i_nVSync;
		w_VBlank <= i_VBlank;
		w_HBlank <= i_HBlank;
	end
end
    
// Look for rising edge on Vertical Sync to reset the counters
assign w_Frame_Start = (w_VBlank & ~i_VBlank);
assign w_Line_Start = (w_HBlank & ~i_HBlank);

endmodule
