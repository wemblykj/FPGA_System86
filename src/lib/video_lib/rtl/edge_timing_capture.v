`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    edge_timing_capture
// Module Name:    edge_timing_capture.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Capture timings for a rising and/or falling event
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module edge_timing_capture #(
  parameter CounterWidth = 12
) (
  input                     clk_i,
  input                     rst_ni,
  input  [CounterWidth-1:0] counter_i,
  input                     falling_i,
  input                     rising_i,
  output [CounterWidth-1:0] falling_at_o,
  output [CounterWidth-1:0] rising_at_o,
  output                    is_valid_o
);

  reg [CounterWidth-1:0] falling_at_q, rising_at_q;
  reg                    have_rising_q, have_falling_q;
  
  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      falling_at_q   <= 1'b0;
      rising_at_q    <= 1'b0;
      have_falling_q <= 1'b0;
      have_rising_q  <= 1'b0;
    end else begin
      if (falling_i) begin
        falling_at_q  <= counter_i;
        have_falling_q <= 1'b1;
      end  
      if (rising_i) begin
        rising_at_q   <= counter_i;
        have_rising_q <= 1'b1;
      end
    end
  end

  assign falling_at_o = falling_at_q;
  assign rising_at_o  = rising_at_q;
  assign is_valid_o = have_falling_q && have_rising_q;
  
endmodule
