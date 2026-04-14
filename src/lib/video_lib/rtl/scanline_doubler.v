`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    scanline_doubler
// Module Name:    scanline_doubler.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Scanline doubler
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module scanline_doubler #(
  parameter integer LineWidth = 364, 
  parameter integer BitDepth = 8
)(
  input                 clk_i,
  input                 clk_x2_i,
  input                 rst_ni,
  input [BitDepth-1:0]	data_i,
  input                 hsync_ni,
  input                 hblank_ni,
  input                 vsync_ni,
  input                 vblank_ni,
  output [BitDepth-1:0] x2_data_o,
  output           	    x2_hsync_no,
  output           	    x2_hblank_no,
  output           	    x2_vsync_no,
  output           	    x2_vblank_no,
  output           	    x2_valid_o
);
  
  localparam MasterCounterWidth = 10;//$clog2(LineWidth);
  localparam PixelCounterWidth = 9;//$clog2(LineWidth);
  // use a single memory region for both buffers
  localparam MemAddrWidth = 10;//$clog2(LineWidth) + 1;  // +1 for buffer select

  
  wire [MasterCounterWidth-1:0] master_counter;
  wire                          master_counter_valid;
  wire                          buffer_select;
 
  wire [PixelCounterWidth-1:0]  counter_d; 
  wire [PixelCounterWidth-1:0]  x2_counter_d;
  wire                          x2_buffer_select;
  wire [PixelCounterWidth-1:0]  x2_hsync_start_d;
  wire [PixelCounterWidth-1:0]  x2_hsync_end_d;
  wire [PixelCounterWidth-1:0]  x2_hblank_start_d;
  wire [PixelCounterWidth-1:0]  x2_hblank_end_d;
  
  // timing capture
  wire [MasterCounterWidth-1:0] hsync_start_q;
  wire [MasterCounterWidth-1:0] hsync_end_q;
  wire [MasterCounterWidth-1:0] hblank_start_q;
  wire [MasterCounterWidth-1:0] hblank_end_q;
  wire                          hsync_captured_q;
  wire                          hblank_captured_q;
  wire                          hsync_in_falling_q;
  wire                          hsync_in_rising_q;
  wire                          hblank_in_falling_q;
  wire                          hblank_in_rising_q;
  wire                          hreset_d;
  
  // timing generation
  wire x2_hsync_valid;
  wire x2_hblank_valid;
  wire x2_vsync_valid;
  wire x2_vblank_valid;
  wire x2_hsync_n;
  wire x2_valid;
  //wire x2_hsync_falling_q;
  //wire x2_hsync_rising_q;
  //wire x2_hreset_d;
  
  assign counter_d = master_counter[MasterCounterWidth-1:1];
  assign x2_counter_d = master_counter % LineWidth;
  
  assign hreset_d = hsync_in_falling_q;
  //assign x2_hreset_d = hsync_in_falling_q || x2_hsync_falling_q; 
  //assign x2_hreset = hsync_captured_q && (h_ctr_out_q === hsync_start_q);
  //assign x2_hreset = x2_hsync_valid && (h_ctr_out_q === hsync_start_q);
  
  assign x2_valid = hsync_captured_q;
  /*assign x2_valid = x2_hsync_valid && 
                    x2_hblank_valid &&
					x2_vsync_valid &&
					x2_vblank_valid;*/
  
  assign x2_buffer_select  = ~buffer_select;
  
  assign x2_hsync_start_d = hsync_start_q[MasterCounterWidth-1:1];
  assign x2_hsync_end_d = hsync_end_q[MasterCounterWidth-1:1];
  assign x2_hblank_start_d = hblank_start_q[MasterCounterWidth-1:1];
  assign x2_hblank_end_d = hblank_end_q[MasterCounterWidth-1:1];
  
  assign x2_valid_o = x2_valid;
  assign x2_hsync_no = x2_hsync_n;
  
  //
  // input pre-processing
  
  timing_counter #(
    .CounterWidth(MasterCounterWidth)
  ) u_horiz_counter (
    .clk_i      (clk_x2_i),
    .rst_ni     (rst_ni),
    .reset_i    (hreset_d), // pulse at start of input scanline
    .counter_o  (master_counter),
	.is_valid_o (master_counter_valid)
  );
  
  edge_detector
    u_hsync_in_edge_detector (
    .clk_i     (clk_x2_i),
    .rst_ni    (rst_ni),
    .d_i       (hsync_ni),
    .falling_o (hsync_in_falling_q),
    .rising_o  (hsync_in_rising_q)
  );
  
  edge_detector
    u_hblank_in_edge_detector (
    .clk_i     (clk_x2_i),
    .rst_ni    (rst_ni),
    .d_i       (hblank_ni),
    .falling_o (hblank_in_falling_q),
    .rising_o  (hblank_in_rising_q)
  );
  
  //
  // write buffer signals
  
  pulse_toggle
    u_write_buf_sel (
    .clk_i  (clk_x2_i),
    .rst_ni (rst_ni),
    .d_i    (hsync_in_falling_q),
    .q_o    (buffer_select)
  );
  
  //
  // capture input timings
  
  edge_timing_capture #(
    .CounterWidth(MasterCounterWidth)
  ) u_horiz_sync_capture (
    .clk_i        (clk_x2_i),
    .rst_ni       (rst_ni),
	.enable_i     (master_counter_valid),
    .counter_i    (master_counter),
    .falling_i    (hsync_in_falling_q),
    .rising_i     (hsync_in_rising_q),
    .falling_at_o (hsync_start_q),
    .rising_at_o  (hsync_end_q),
    .is_valid_o   (hsync_captured_q)
  );
  
  edge_timing_capture #(
    .CounterWidth(MasterCounterWidth)
  ) u_horiz_blank_capture (
    .clk_i        (clk_x2_i),
    .rst_ni       (rst_ni),
	.enable_i     (master_counter_valid),
    .counter_i    (master_counter),
    .falling_i    (hblank_in_falling_q),
    .rising_i     (hblank_in_rising_q),
    .falling_at_o (hblank_start_q),
    .rising_at_o  (hblank_end_q),
    .is_valid_o   (hblank_captured_q)
  );
  
  //
  // read buffer signals
  
  /*edge_detector
    u_hsync_out_edge_detector (
    .clk_i     (clk_x2_i),
    .rst_ni    (rst_ni),
    .d_i       (x2_hsync_n),
    .falling_o (x2_hsync_falling_q),
    .rising_o  (x2_hsync_rising_q)
  );*/
  
  //
  // generate output timings
  
  pulse_generator #(
    .CounterWidth(MasterCounterWidth)
  ) u_hsync_generator (
    .clk_i        (clk_x2_i),
    .rst_ni       (rst_ni),
	.enable_i     (hsync_captured_q),
    .counter_i    (x2_counter_d),
    .falling_at_i (x2_hsync_start_d),
    .rising_at_i  (x2_hsync_end_d),
    .q_o          (x2_hsync_n),
    .is_valid_o   (x2_hsync_valid)
  );
  
  pulse_generator #(
    .CounterWidth(MasterCounterWidth)
  ) u_hblank_generator (
    .clk_i        (clk_x2_i),
    .rst_ni       (rst_ni),
	.enable_i     (hblank_captured_q),
    .counter_i    (x2_counter_d),
    .falling_at_i (x2_hblank_start_d),
    .rising_at_i  (x2_hblank_end_d),
    .q_o          (x2_hblank_no),
    .is_valid_o   (x2_hblank_valid)
  );
  
  pulse_delay 
    u_vsync_generator (
    .clk_i        (~x2_hsync_n),
    .rst_ni       (rst_ni),
	.enable_i     (1'b1),
    .d_i          (vsync_ni),
    .q_o          (x2_vsync_no),
	.is_valid_o   (x2_vsync_valid)
  );
  
  pulse_delay 
    u_vblank_generator (
    .clk_i        (~x2_hsync_n),
    .rst_ni       (rst_ni),
	.enable_i     (1'b1),
    .d_i          (vblank_ni),
    .q_o          (x2_vblank_no),
	.is_valid_o   (x2_vblank_valid)
  );
  
  //
  // Dual-port Buffer
  
  line_buffer_dp_ram #(
    .AddrWidth(MemAddrWidth),
    .DataWidth(BitDepth)
  ) u_line_buf (
    // x1 write
    .clk_a_i  (clk_i),
    .we_a_i   (hblank_ni),
    .addr_a_i ({buffer_select, counter_d}),
    .wdata_a_i(data_i),
    // x2 read
    .clk_b_i  (clk_x2_i),
    .oe_b_i   (x2_hblank_no),
    .addr_b_i ({x2_buffer_select, x2_counter_d}),
    .rdata_b_o(x2_data_o)
  );
  
endmodule
