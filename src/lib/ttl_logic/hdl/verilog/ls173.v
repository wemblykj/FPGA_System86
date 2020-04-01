`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:51:32 05/14/2018 
// Design Name:    LS173
// Module Name:    system86/ttl/ls173.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description: 	 LS173 4-Bit D-Type Registers With 3-State Outputs
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module ls173(
        input wire CLK,
        input wire CLR,
		  input wire nG1,
		  input wire nG2,
		  input wire M,
		  input wire N,
        input wire [3:0] D,
        inout wire [3:0] Q
    );

	reg [3:0] QLatched = 0;
	reg [3:0] QOut = 0;
	
	always @(posedge CLK) begin
		if (!CLR && !(nG1 || nG2))
			QLatched <= D;
	end
	
	always @(CLR or QLatched) begin
		if (CLR)
			QOut <= 4'b0;
		else
			QOut <= QLatched;
	end
	
	// handle high impedence state if M or N are high - does not affect latching logic, only output
	assign Q = (M || N) ? 4'bZ : QOut;
	
endmodule
