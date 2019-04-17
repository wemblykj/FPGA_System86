`timescale 1ns/1ps

// Testbench for VGA_Sync_Pulses module
//`include "VGA_Sync_Pulses.v"
//`include "Test_Pattern_Gen.v"
//`include "VGA_Sync_Porch.v"

module VGA_Test_Pattterns_TB;
  
  parameter c_USE_SYSTEM86 = 1;
  
  parameter c_VIDEO_WIDTH = 3; // 3 bits per pixel
  parameter c_USE_BLANKING = 1;
  
  // VGA 640x480 standard timings (800x525) 25.145Mhz pixel clock
  //parameter c_TOTAL_COLS  = 800;
  //parameter c_TOTAL_ROWS  = 525;
  //parameter c_ACTIVE_COLS = 640;
  //parameter c_ACTIVE_ROWS = 480;
  
  //parameter c_SYNC_PULSE_HORZ = 96;
  //parameter c_SYNC_PULSE_VERT = 2;
  
  //parameter c_FRONT_PORCH_HORZ = 16;
  //parameter c_BACK_PORCH_HORZ  = 48;
  //parameter c_FRONT_PORCH_VERT = 10;
  //parameter c_BACK_PORCH_VERT  = 33;
  
  //parameter c_PERIOD = 39.7219464/2.0;
  
  // Namco System86 timings 288x224 (384x264) 6Mhz pixel clock
  parameter c_TOTAL_COLS = 384;
  parameter c_TOTAL_ROWS  = 264;
  parameter c_ACTIVE_COLS = 288;
  parameter c_ACTIVE_ROWS = 224;
  
  
  parameter c_SYNC_PULSE_HORZ = 32;
  parameter c_SYNC_PULSE_VERT = 8;
  
  parameter c_FRONT_PORCH_HORZ = 32;
  parameter c_BACK_PORCH_HORZ  = 32;
  parameter c_FRONT_PORCH_VERT = 8;
  parameter c_BACK_PORCH_VERT  = 24;
  
  parameter c_PERIOD = 81.3802;
  
  reg r_Clk = 1'b0;
  
  wire w_HSync_TP;
  wire w_VSync_TP;
  wire w_HBlank_TP;
  wire w_VBlank_TP;
  wire [c_VIDEO_WIDTH-1:0] w_Red_Video_TP;
  wire [c_VIDEO_WIDTH-1:0] w_Grn_Video_TP;
  wire [c_VIDEO_WIDTH-1:0] w_Blu_Video_TP;
    
  always #c_PERIOD r_Clk <= ~r_Clk;
  //always #(39.7219464/2.0) r_Clk <= ~r_Clk;
  //always #81.3802 r_Clk <= ~r_Clk;
  
  // Generates Sync Pulses to run VGA
  VGA_Sync_Pulses #(.TOTAL_COLS(c_TOTAL_COLS),
                    .TOTAL_ROWS(c_TOTAL_ROWS),
                    .ACTIVE_COLS(c_ACTIVE_COLS),
                    .ACTIVE_ROWS(c_ACTIVE_ROWS),
						  .SYNC_PULSE_HORZ(c_SYNC_PULSE_HORZ),
						  .SYNC_PULSE_VERT(c_SYNC_PULSE_VERT)) 
						  
  VGA_Sync_Pulses_Inst(.i_Clk(r_Clk),
   .o_HSync(w_HSync_Start),
   .o_VSync(w_VSync_Start),
   .o_Col_Count(),
   .o_Row_Count()
  );
  
  
  // Drives Red/Grn/Blue video - Test Pattern 5 (Color Bars)
  Test_Pattern_Gen  #(.VIDEO_WIDTH(c_VIDEO_WIDTH),
                      .TOTAL_COLS(c_TOTAL_COLS),
                      .TOTAL_ROWS(c_TOTAL_ROWS),
                      .ACTIVE_COLS(c_ACTIVE_COLS),
                      .ACTIVE_ROWS(c_ACTIVE_ROWS),
							 .USE_BLANKING(c_USE_BLANKING),
							 .SYNC_PULSE_HORZ(c_SYNC_PULSE_HORZ),
							 .SYNC_PULSE_VERT(c_SYNC_PULSE_VERT),
							 .FRONT_PORCH_HORZ(c_FRONT_PORCH_HORZ),
							 .BACK_PORCH_HORZ(c_BACK_PORCH_HORZ),
							 .FRONT_PORCH_VERT(c_FRONT_PORCH_VERT),
							 .BACK_PORCH_VERT(c_BACK_PORCH_VERT))
							 
  Test_Pattern_Gen_Inst
   (.i_Clk(r_Clk),
    .i_Pattern(4'b0110), // 0101 = color bars
    .i_HSync(w_HSync_Start),
    .i_VSync(w_VSync_Start),
    .o_HSync(w_HSync_TP),
    .o_VSync(w_VSync_TP),
	 .o_HBlank(w_HBlank_TP),
    .o_VBlank(w_VBlank_TP),
    .o_Red_Video(w_Red_Video_TP),
    .o_Grn_Video(w_Grn_Video_TP),
    .o_Blu_Video(w_Blu_Video_TP));
  
  vga_logger #( .C_COMPONENT_DEPTH(c_VIDEO_WIDTH) )
		vga_logger
		(
			.pixel_clk(r_Clk),
			.output_enable(1'b1),
			.red(w_Red_Video_TP),
			.green(w_Grn_Video_TP),
			.blue(w_Blu_Video_TP),
			.hsync(w_HSync_TP),
			.vsync(w_VSync_TP)
		);
		
  initial
  begin
    #36000000;
    $finish();
  end
    
  initial 
  begin 
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  
endmodule 
