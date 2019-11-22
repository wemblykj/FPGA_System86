// The purpose of this module is to modify the input HSync and VSync signals to
// include some time for what is called the Front and Back porch.  The front
// and back porch of a VGA interface used to have more meaning when a monitor
// actually used a Cathode Ray Tube (CRT) to draw an image on the screen.  You
// can read more about the details of how old VGA monitors worked.  These
// days, the notion of a front and back porch is maintained, due more to
// convention than to the physics of the monitor.
// New standards like DVI and HDMI which are meant for digital signals have
// removed this notion of the front and back porches.  Remember that VGA is an
// analog interface.
// This module is designed for 640x480 with a 25 MHz input clock.

module Sync_To_Blanking #(
                        parameter TOTAL_COLS  = 800,
                        parameter TOTAL_ROWS  = 525,
                        parameter ACTIVE_COLS = 640,
                        parameter ACTIVE_ROWS = 480,
								parameter SYNC_PULSE_HORZ = 96,
								parameter SYNC_PULSE_VERT = 2,
								parameter FRONT_PORCH_HORZ = 16,
								parameter BACK_PORCH_HORZ  = 48,
								parameter FRONT_PORCH_VERT = 10,
								parameter BACK_PORCH_VERT  = 33)
  (input i_Rst,
   input i_Clk,
   input i_HSync,
   input i_VSync,
	output reg o_Locked,
   output reg o_HSync,
   output reg o_VSync,
	output reg o_HBlank,
   output reg o_VBlank
   );

  wire w_Locked;
  wire w_HSync;
  wire w_VSync;
  
  
  wire [9:0] w_Col_Count;
  wire [9:0] w_Row_Count;
  
  Sync_To_Count #(.TOTAL_COLS(TOTAL_COLS),
                  .TOTAL_ROWS(TOTAL_ROWS)) UUT 
  (.i_Rst		(i_Rst),
   .i_Clk      (i_Clk),
   .i_HSync    (i_HSync),
   .i_VSync    (i_VSync),
	.o_Locked   (w_Locked),
   .o_HSync    (w_HSync),
   .o_VSync    (w_VSync),
   .o_Col_Count(w_Col_Count),
   .o_Row_Count(w_Row_Count)
  );
	  
  // Purpose: Modifies the HSync and VSync signals to include Front/Back Porch
  always @(posedge i_Clk)
  begin
    if ((w_Col_Count < FRONT_PORCH_HORZ + ACTIVE_COLS) || 
        (w_Col_Count > TOTAL_COLS - BACK_PORCH_HORZ - 1))
      o_HBlank <= 1'b1;
    else
      o_HBlank <= 1'b0;
    
	 o_HSync <= w_HSync;
	 
    if ((w_Row_Count < FRONT_PORCH_VERT + ACTIVE_ROWS) ||
        (w_Row_Count > TOTAL_ROWS - BACK_PORCH_VERT - 1))
      o_VBlank <= 1'b1;
    else
      o_VBlank <= 1'b0;
		
	 o_VSync <= w_VSync;
	 o_Locked <= w_Locked;
  end
  
  //assign o_HSync = w_HSync;
  //assign o_VSync = w_VSync;
  
  //assign o_HBlank = (w_Col_Count < SYNC_PULSE_HORZ + BACK_PORCH_HORZ) | (w_Col_Count > TOTAL_COLS - FRONT_PORCH_HORZ - 1) ? 1'b1 : 1'b0;
  //assign o_VBlank = (w_Row_Count < SYNC_PULSE_VERT + BACK_PORCH_VERT) | (w_Row_Count > TOTAL_ROWS - FRONT_PORCH_VERT - 1) ? 1'b1 : 1'b0;
  
endmodule

