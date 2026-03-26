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
  input                       clk_i,
  input                       clk_x2_i,
  input                       rst_ni,
  input [BitDepth-1:0]		  data_i,
  input                       hsync_ni,
  input                       hblank_ni,
  input                       vsync_ni,
  input                       vblank_ni,
  output [BitDepth-1:0] x2_data_o,
  output           	    x2_hsync_no,
  output           	    x2_hblank_no,
  output           	    x2_vsync_no,
  output           	    x2_vblank_no,
  output           	    x2_valid_o
);
  
  localparam BufferCounterWidth = 9;//$clog2(LineWidth);
  // use a single memory region for both buffers
  localparam MemAddrWidth = 10;//$clog2(LineWidth) + 1;  // +1 for buffer select

  wire                          write_buffer_select;
  wire [BufferCounterWidth-1:0] h_ctr_in_q;
  
  wire                          read_buffer_select;
  wire [BufferCounterWidth-1:0] h_ctr_out_q;

  // timing capture
  wire [BufferCounterWidth-1:0] hsync_start_q;
  wire [BufferCounterWidth-1:0] hsync_end_q;
  wire [BufferCounterWidth-1:0] hblank_start_q;
  wire [BufferCounterWidth-1:0] hblank_end_q;
  wire                          hsync_captured_q;
  wire                          hblank_captured_q;
  wire                          hsync_in_falling_q;
  wire                          hsync_in_rising_q;
  wire                          hblank_in_falling_q;
  wire                          hblank_in_rising_q;
  
  // timing generation
  wire x2_hsync_valid;
  wire x2_hblank_valid;
  wire x2_hreset;
  
  assign x2_hreset = h_ctr_out_q === hsync_start_q;
  
  assign x2_valid_o = hsync_captured_q && 
                      hblank_captured_q && 
                      x2_hsync_valid && 
                      x2_hblank_valid;
  
  assign read_buffer_select  = ~write_buffer_select;
  
  //
  // input pre-processing
  
  edge_detector
    u_hsync_in_edge_detector (
    .clk_i     (clk_i),
    .rst_ni    (rst_ni),
    .d_i       (hsync_ni),
    .falling_o (hsync_in_falling_q),
    .rising_o  (hsync_in_rising_q)
  );
  
  edge_detector
    u_hblank_in_edge_detector (
    .clk_i     (clk_i),
    .rst_ni    (rst_ni),
    .d_i       (hblank_ni),
    .falling_o (hblank_in_falling_q),
    .rising_o  (hblank_in_rising_q)
  );
  
  //
  // write buffer signals
  
  timing_counter #(
    .CounterWidth(BufferCounterWidth)
  ) u_horiz_in_counter (
    .clk_i     (clk_i),
    .rst_ni    (rst_ni),
    .reset_i   (hsync_in_falling_q), // pulse at start of input scanline
    .counter_o (h_ctr_in_q)
  );
  
  pulse_toggle
    u_write_buf_sel (
    .clk_i  (clk_i),
    .rst_ni (rst_ni),
    .d_i    (hsync_in_falling_q),
    .q_o    (write_buffer_select)
  );
  
  //
  // capture input timings
  
  edge_timing_capture #(
    .CounterWidth(BufferCounterWidth)
  ) u_horiz_sync_capture (
    .clk_i        (clk_i),
    .rst_ni       (rst_ni),
    .counter_i    (h_ctr_in_q),
    .falling_i    (hsync_in_falling_q),
    .rising_i     (hsync_in_rising_q),
    .falling_at_o (hsync_start_q),
    .rising_at_o  (hsync_end_q),
    .is_valid_o   (hsync_captured_q)
  );
  
  edge_timing_capture #(
    .CounterWidth(BufferCounterWidth)
  ) u_horiz_blank_capture (
    .clk_i        (clk_i),
    .rst_ni       (rst_ni),
    .counter_i    (h_ctr_in_q),
    .falling_i    (hblank_in_falling_q),
    .rising_i     (hblank_in_rising_q),
    .falling_at_o (hblank_start_q),
    .rising_at_o  (hblank_end_q),
    .is_valid_o   (hblank_captured_q)
  );
  
  //
  // read buffer signals
  
  timing_counter #(
    .CounterWidth(BufferCounterWidth)
  ) u_horiz_out_counter (
    .clk_i     (clk_x2_i),
    .rst_ni    (rst_ni),
    .reset_i   (x2_hreset),  // pulse at start of input frame
    .counter_o (h_ctr_out_q)
  );
  
  //
  // generate output timings
  
  pulse_generator #(
    .CounterWidth(BufferCounterWidth)
  ) u_hsync_generator (
    .clk_i        (clk_x2_i),
    .rst_ni       (rst_ni),
    .counter_i    (h_ctr_out_q),
    .falling_at_i (hsync_start_q),
    .rising_at_i  (hsync_end_q),
    .q_o          (x2_hsync_no),
    .is_valid_o   (x2_hsync_valid)
  );
  
  pulse_generator #(
    .CounterWidth(BufferCounterWidth)
  ) u_hblank_generator (
    .clk_i        (clk_x2_i),
    .rst_ni       (rst_ni),
    .counter_i    (h_ctr_out_q),
    .falling_at_i (hblank_start_q),
    .rising_at_i  (hblank_end_q),
    .q_o          (x2_hblank_no),
    .is_valid_o   (x2_hblank_valid)
  );
  
  pulse_delay 
    u_vsync_generator (
    .clk_i        (clk_x2_i),
    .rst_ni       (rst_ni),
    .d_i          (vsync_ni),
    .q_o          (x2_vsync_no)
  );
  
  pulse_delay 
    u_vblank_generator (
    .clk_i        (clk_x2_i),
    .rst_ni       (rst_ni),
    .d_i          (vblank_ni),
    .q_o          (x2_vblank_no)
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
    .addr_a_i ({write_buffer_select, h_ctr_in_q}),
    .wdata_a_i(data_i),
    // x2 read
    .clk_b_i  (clk_x2_i),
    .oe_b_i   (x2_hblank_no),
    .addr_b_i ({read_buffer_select, h_ctr_out_q}),
    .rdata_b_o(x2_data_o)
  );
  
endmodule
