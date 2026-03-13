`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    pulse_timing_capture
// Module Name:    pulse_timing_capture.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Capture the timings of a reoccurring pulse
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module pulse_timing_capture #(
  parameter CounterWidth = 12
) (
  input                           clk_i,
  input                           rst_ni,
  input [CounterWidth-1:0]        counter_i,
  input                           d_i,
  output logic [CounterWidth-1:0] rising_at_o,
  output logic [CounterWidth-1:0] falling_at_o,
  output logic                    is_valid_o
);
  
  logic d_q;
  logic rising_d, falling_d;

  edge_timing_capture #(
    .CounterWidth(CounterWidth)
  ) u_edge_timing_capture (
    .clk_i        (clk_i),
    .rst_ni       (rst_ni),
    .counter_i    (counter_i),
    .rising_i     (rising_d),
    .falling_i    (falling_d),
    .falling_at_o (falling_at_o),
    .rising_at_o  (rising_at_o),
    .is_valid_o   (is_valid_o)
  );

  assign rising_d = !d_q && d_i;
  assign falling_d = d_q && !d_i;
  
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      d_q    <= '0;
    end else begin
      d_q  <= d_i;
    end
  end
  
endmodule