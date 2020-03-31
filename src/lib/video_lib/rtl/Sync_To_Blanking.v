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
  (input i_Clk,
   input i_Rst,
   input i_nHSync,
   input i_nVSync,
	output reg o_Locked = 0,
   output reg o_nHSync = 1,
   output reg o_nVSync = 1,
	output reg o_HBlank = 0,
   output reg o_VBlank = 0,
	output reg [9:0] o_Col_Count = 0, 
   output reg [9:0] o_Row_Count = 0
   );

  wire w_Locked;
  wire w_nHSync;
  wire w_nVSync;
  wire [9:0] w_Col_Count;
  wire [9:0] w_Row_Count;
  
  reg w_HBlank;
  reg w_VBlank;
  
  Sync_To_Count 
	#(
		.TOTAL_COLS(TOTAL_COLS),
      .TOTAL_ROWS(TOTAL_ROWS))
		Sync_To_Count 
	(
		.i_Rst		(i_Rst),
		.i_Clk      (i_Clk),
		.i_nHSync    (i_nHSync),
		.i_nVSync    (i_nVSync),
		.o_Locked   (w_Locked),
		.o_nHSync    (w_nHSync),
		.o_nVSync    (w_nVSync),
		.o_Col_Count(w_Col_Count),
		.o_Row_Count(w_Row_Count)
  );
	  
  always @(posedge i_Clk) begin
  	 o_Locked <= w_Locked;
	 o_nHSync <= w_nHSync;
	 o_nVSync <= w_nVSync;
	 o_HBlank <= w_HBlank;
	 o_VBlank <= w_VBlank;
	 o_Col_Count <= w_Col_Count;
	 o_Row_Count <= w_Row_Count;
  end	 
  
  // Purpose: Modifies the HSync and VSync signals to include Front/Back Porch
  always @(negedge i_Clk)
  begin
	 if (i_Rst) begin
		/*w_Locked <= 0;
		w_nHSync <= 1'b1;
		w_nVSync <= 1'b1;
		w_Col_Count <= 0;
		w_Row_Count <= 0;*/
	 end else begin
      if ((w_Col_Count < SYNC_PULSE_HORZ + BACK_PORCH_HORZ) || 
          (w_Col_Count > TOTAL_COLS - FRONT_PORCH_HORZ - 1))
        w_HBlank <= 1'b1;
      else
        w_HBlank <= 1'b0;
    
	   //w_nHSync <= i_nHSync;
	 
      if ((w_Row_Count < SYNC_PULSE_VERT + BACK_PORCH_VERT) ||
          (w_Row_Count > TOTAL_ROWS - FRONT_PORCH_VERT - 1))
        w_VBlank <= 1'b1;
      else
        w_VBlank <= 1'b0;
		
	   //w_nVSync <= i_nVSync;
	   //w_Locked <= i_Locked;
	 end
  end
  
  //assign o_HSync = w_HSync;
  //assign o_VSync = w_VSync;
  
  //assign o_HBlank = (w_Col_Count < SYNC_PULSE_HORZ + BACK_PORCH_HORZ) | (w_Col_Count > TOTAL_COLS - FRONT_PORCH_HORZ - 1) ? 1'b1 : 1'b0;
  //assign o_VBlank = (w_Row_Count < SYNC_PULSE_VERT + BACK_PORCH_VERT) | (w_Row_Count > TOTAL_ROWS - FRONT_PORCH_VERT - 1) ? 1'b1 : 1'b0;
  
endmodule

