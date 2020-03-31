// This module is designed for 640x480 with a 25 MHz input clock.

module VGA_Sync_Pulses 
 #(parameter TOTAL_COLS  = 800, 
   parameter TOTAL_ROWS  = 525,
   parameter SYNC_PULSE_HORZ = 96,
	parameter SYNC_PULSE_VERT = 2)
  (input            i_Clk, 
   input            i_Rst, 
	output reg       o_Locked = 0,
   output reg       o_nHSync = 1,
   output reg       o_nVSync = 1,
   output reg [9:0] o_Col_Count = 0, 
   output reg [9:0] o_Row_Count = 0
  );  

reg w_Locked;
reg w_nHSync;
reg w_nVSync;
reg [9:0] w_Col_Count;
reg [9:0] w_Row_Count;
  
always @(posedge i_Clk) begin
	o_Locked <= w_Locked;
	o_nHSync <= w_nHSync;
	o_nVSync <= w_nVSync;
	o_Col_Count <= w_Col_Count;
	o_Row_Count <= w_Row_Count;
end

always @(negedge i_Clk) begin
	if (i_Rst) begin
		w_Locked <= 0;
		w_nHSync <= 1'b1;
		w_nVSync <= 1'b1;
		w_Col_Count <= 0;
		w_Row_Count <= 0;
	end else begin
		if (w_Col_Count == TOTAL_COLS-1) begin
			w_Col_Count <= 0;
			if (w_Row_Count == TOTAL_ROWS-1)
				w_Row_Count <= 0;
			else
				w_Row_Count <= w_Row_Count + 1;
			end
		else
			w_Col_Count <= w_Col_Count + 1;

		if ((w_Col_Count < TOTAL_COLS) && 
			(w_Col_Count > SYNC_PULSE_HORZ - 1))
			w_nHSync <= 1'b1;
		else begin
			w_nHSync <= 1'b0;
		end
		
		if ((w_Row_Count < TOTAL_ROWS) && 
			(w_Row_Count > SYNC_PULSE_VERT - 1))
			w_nVSync <= 1'b1;
		else begin
			w_nVSync <= 1'b0;
			w_Locked <= 1;
		end
	end
end
	  
  //assign o_HSync = (o_Col_Count < TOTAL_COLS) && (o_Col_Count > SYNC_PULSE_HORZ - 1) ? 1'b1 : 1'b0;
  //assign o_VSync = (o_Row_Count < TOTAL_ROWS) && (o_Row_Count > SYNC_PULSE_VERT - 1) ? 1'b1 : 1'b0;
  
endmodule
