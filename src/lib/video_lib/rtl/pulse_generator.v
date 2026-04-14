`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    pulse_generator
// Module Name:    pulse_generator.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Generate a pulse from incoming timing information
// 
// Port A: write on clk_i (input pixel clock)
// Port B: read on clk_x2_i (doubled pixel clock)
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module pulse_generator #(
  parameter CounterWidth = 12
) (
  input                    clk_i,
  input                    rst_ni,
  input                    enable_i,
  input [CounterWidth-1:0] counter_i,
  input [CounterWidth-1:0] rising_at_i,
  input [CounterWidth-1:0] falling_at_i,
  output                   q_o,
  output                   is_valid_o
);
  
  reg q;
  wire rising_edge_d, faling_edge_d;
  reg have_rising_q, have_falling_q;
  
  assign rising_edge_d = counter_i === rising_at_i;
  assign faling_edge_d = counter_i === falling_at_i;
  
  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      q              <= 1'b0;
      have_rising_q  <= 1'b0;
      have_falling_q <= 1'b0;
    end else begin
      q <= q;
	  if (enable_i) begin
        if (rising_edge_d) begin
          q             <= 1'b1;
          have_rising_q <= 1'b1;
        end
        if (faling_edge_d) begin
          q              <= 1'b0;
          have_falling_q <= 1'b1;
		end
      end
    end
  end
  
  assign q_o = q;
  assign is_valid_o = have_rising_q && have_falling_q;
  
endmodule
