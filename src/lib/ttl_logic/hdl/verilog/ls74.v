`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    19:24:54 05/16/2018 
// Design Name:    LS47
// Module Name:    system86/ttl/ls74.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    LS74 - Dual D-Type Positive-Edge -Triggered Flip-Flops With Preset and Clear
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module ls74(
        input wire nCLR1,
        input wire nCLR2,
        input wire CLK1,
        input wire CLK2,
        input wire nPRE1,
        input wire nPRE2,
        input wire D1,
        input wire D2,
        output reg Q1,
        output reg Q2,
        output reg nQ1,
        output reg nQ2
    );

	always @(posedge CLK1 or nPRE1 or nCLR1) begin
		if (nPRE1 && nCLR1) begin
			Q1 <= D1;
			nQ1 <= ~D1;
		/*else if (!nPRE1 && nCLR1) begin
			Q1 <= 1;
			nQ1 <= 0;
		end else if (nPRE1 && !nCLR1) begin
			Q1 <= 0;
			nQ1 <= 1;
		end else if (!nPRE1 && !nCLR1) begin
			Q1 <= 1;
			nQ1 <= 1;*/
		end else begin
			Q1 <= ~nPRE1;
			nQ1 <= nPRE1 || !nCLR1;
		end
			
	end
	
	always @(posedge CLK2 or nPRE2 or nCLR2) begin
		if (nPRE2 && nCLR2) begin
			Q2 <= D2;
			nQ2 <= ~D2;
		/*end else if (!nPRE2 && nCLR2) begin
			Q2 <= 1;
			nQ2 <= 0;
		end else if (nPRE2 && !nCLR2) begin
			Q2 <= 0;
			nQ2 <= 1;
		end else if (!nPRE2 && !nCLR2) begin
			Q2 <= 1;
			nQ2 <= 1;*/
		end else begin
			Q2 <= ~nPRE2;
			nQ2 <= nPRE2 || !nCLR2;
		end			
	end
	
endmodule
