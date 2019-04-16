// This module will take incoming horizontal and veritcal blank signals and
// create Row and Column counters based on the active pixel area.
// It will align the Row/Col counters to the output blank signals.
// Useful for any module that needs to keep track of which Row/Col position we
// are on in the active portion of a frame
module Blank_To_Count 
 #(parameter ACTIVE_COLS = 640,
   parameter ACTIVE_ROWS = 480)
  (input            i_Clk,
   input            i_HBlank,
   input            i_VBlank, 
	output reg       o_Active = 0,
   output reg       o_HBlank = 0,
   output reg       o_VBlank = 0,
   output reg [9:0] o_Col_Count = 0,
   output reg [9:0] o_Row_Count = 0);
   
   wire w_Frame_Start;
	wire w_Line_Start;
	
  // Register syncs to align with output data.
  always @(posedge i_Clk)
  begin
    o_VBlank <= i_VBlank;
    o_HBlank <= i_HBlank;
	 o_Active <= ~i_VBlank & ~i_HBlank;
  end

  // Keep track of Row/Column counters.
  always @(posedge i_Clk)
  begin
    if (w_Frame_Start == 1'b1)
    begin
      o_Col_Count <= 0;
      o_Row_Count <= 0;
    end
	 else if (w_Line_Start == 1'b1)
    begin
      o_Col_Count <= 0;
    end
    else
    begin
      if (o_Col_Count == ACTIVE_COLS-1)
      begin
        if (o_Row_Count == ACTIVE_ROWS-1)
        begin
          o_Row_Count <= 0;
        end
        else
        begin
          o_Row_Count <= o_Row_Count + 1;
        end
        o_Col_Count <= 0;
      end
      else
      begin
        o_Col_Count <= o_Col_Count + 1;
      end
    end
  end
    
  // Look for rising edge on Vertical Sync to reset the counters
  assign w_Frame_Start = (o_VBlank & ~i_VBlank);
  assign w_Line_Start = (o_HBlank & ~i_HBlank);

endmodule
