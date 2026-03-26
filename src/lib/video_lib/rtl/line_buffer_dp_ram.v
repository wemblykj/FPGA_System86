`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    line_buffer_dp_ram
// Module Name:    line_buffer_dp_ram.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Dual-port RAM wrapper for line buffer
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
module line_buffer_dp_ram #(
  parameter AddrWidth = 9,
  parameter DataWidth = 8
) (
  // Write port (Port A)
  input                  clk_a_i,
  input                  we_a_i,
  input  [AddrWidth-1:0] addr_a_i,
  input  [DataWidth-1:0] wdata_a_i,

  // Read port (Port B)
  input                  clk_b_i,
  input                  oe_b_i,
  input  [AddrWidth-1:0] addr_b_i,
  output [DataWidth-1:0] rdata_b_o
);

  reg [DataWidth-1:0] mem[0:(1<<AddrWidth)-1];
  reg [DataWidth-1:0] rdata_raw;

  // Port A: synchronous write
  always @(posedge clk_a_i) begin
    if (we_a_i) begin
      mem[addr_a_i] <= wdata_a_i;
    end
  end

  assign rdata_b_o = oe_b_i ? mem[addr_b_i] : 1'b0;
  
endmodule
