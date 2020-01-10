// This module is designed for 640x480 with a 25 MHz input clock.

module VGA_Sync_Pulses 
 #(parameter TOTAL_COLS  = 800, 
   parameter TOTAL_ROWS  = 525,
   parameter SYNC_PULSE_HORZ = 96,
	parameter SYNC_PULSE_VERT = 2)
  (input            i_Clk, 
   input            i_Rst, 
	output reg       o_Locked,
   output reg       o_HSync,
   output reg       o_VSync,
   output reg [9:0] o_Col_Count = 0, 
   output reg [9:0] o_Row_Count = 0
  );  
  
always @(posedge i_Clk) begin
	if (i_Rst) begin
		o_Locked <= 0;
		o_HSync <= 1'b1;
		o_VSync <= 1'b1;
		o_Col_Count <= 0;
		o_Row_Count <= 0;
	end else begin
		if (o_Col_Count == TOTAL_COLS-1) begin
			o_Col_Count <= 0;
			if (o_Row_Count == TOTAL_ROWS-1)
				o_Row_Count <= 0;
			else
				o_Row_Count <= o_Row_Count + 1;
			end
		else
			o_Col_Count <= o_Col_Count + 1;

		if ((o_Col_Count < TOTAL_COLS) && 
			(o_Col_Count > SYNC_PULSE_HORZ - 1))
			o_HSync <= 1'b1;
		else begin
			o_HSync <= 1'b0;
		end
		
		if ((o_Row_Count < TOTAL_ROWS) && 
			(o_Row_Count > SYNC_PULSE_VERT - 1))
			o_VSync <= 1'b1;
		else begin
			o_VSync <= 1'b0;
			o_Locked <= 1;
		end
	end
end
	  
  //assign o_HSync = (o_Col_Count < TOTAL_COLS) && (o_Col_Count > SYNC_PULSE_HORZ - 1) ? 1'b1 : 1'b0;
  //assign o_VSync = (o_Row_Count < TOTAL_ROWS) && (o_Row_Count > SYNC_PULSE_VERT - 1) ? 1'b1 : 1'b0;
  
endmodule
