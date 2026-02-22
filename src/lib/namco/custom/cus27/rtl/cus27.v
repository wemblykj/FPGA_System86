//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    cus27
// Module Name:    system86\src\custom\cus27.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - System timings generator
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module cus27
(
	// simulation control
	input wire _rst_ni,
	
	// input clocks
	input wire pin_48M_i,
	input wire pin_6M_i,
	
	// generated clocks
	output reg pin_24M_o,
	output reg pin_12M_o,
	output reg pin_6M_o,
	
	// video synchronisation
	output reg pin_bVSYNC,
	output reg pin_bHSYNC,
	output reg pin_bVBLANK,
	output reg pin_bHBLANK,
	output reg pin_bVRESET,
	output reg pin_bHRESET,
	
	// pixel clock signals
	output wire pin_8V_o,
	output wire pin_4V_o,
	output wire pin_1V_o,
	output wire pin_4H_o,
	output wire pin_2H_o,
	output wire pin_1H_o,
	output wire pin_S2H_o,
	output wire pin_S1H_o,
	
	output wire [10:0] pin_A_o
);

	reg [8:0] horizontal_counter;
	reg [8:0] vertical_counter;
	
	
	//reg pin_bHSYNCON = 0;
	//reg nHBLON = 0;	
	reg VRESETH = 0;	// vreset from horizonatal
	reg VRESET = 0;	// vreset from vertical
	
	reg [2:0] master_counter;

	always @(posedge pin_48M_i or negedge _rst_n) begin
		if (!_rst_n)
			master_counter <= 0;
		else
			master_counter <= master_counter + 1'b1;
			
		//pin_S1H_o <= pin_1H_o;	// is this in phase?
		//pin_S2H_o <= pin_2H_o;	// is this in phase?
	end

	always @(master_counter) begin
		pin_24M_o <= master_counter[0];
		pin_12M_o <= master_counter[1];
		pin_6M_o <= master_counter[2];	
	end
	//assign pin_24M_o = master_counter[0];
	//assign pin_12M_o = master_counter[1];
	//assign pin_6M_o = master_counter[2];	

	always @(VRESETH or VRESET) begin
		pin_bVRESET <= ~(VRESETH && VRESET); 
	end
	
	// in order for CPU timing to match information gleaned from http://www.ukvac.com/forum/namco-cus27-in-fpga-cus130-wip_topic362440_page2.html
	// it would appear that the counter is clocked on the falling edge of 6M
	// this would make sense as CUS27 is wired up with 6M output as a feedback into the chip's 6M input
	// which would only be stable in reality if the input was dealt with out of phase from the orinal output
	always @(negedge pin_6M_i or negedge _rst_n) begin
		if (!_rst_n) begin
			horizontal_counter <= 1;	// need to start at one otherwise we end up counting 385 pixels!
		end else begin
			if (horizontal_counter[8:3] === 6'b110000) 	// ~384
				horizontal_counter <= 1;	// need to start at one otherwise we end up counting 385 pixels!
			else
				horizontal_counter <= horizontal_counter + 1'b1;
		end
	end
	
	always @(horizontal_counter or _rst_n) begin
		if (!_rst_n) begin
			pin_bHSYNC <= 1'b1;
			pin_bHBLANK <= 1'b1;
			pin_bHRESET <= 1'b1;
			VRESETH <= 1'b0;
			
			//pin_1H_o <= 1'b0;
			//pin_S1H_o <= 1'b0;
			//pin_2H_o <= 1'b0;
			//pin_S2H_o <= 1'b0;
			//pin_4H_o <= 1'b0;
		end else begin
			if (horizontal_counter[8:0] === 9'b100110000) begin // ~304
				pin_bHSYNC <= 1'b0;
				VRESETH <= 1;        
			end else if (horizontal_counter[8:3] === 6'b101010) begin // ~336
				pin_bHSYNC <= 1'b1;	
				VRESETH <= 0;
			end else begin
				pin_bHSYNC <= pin_bHSYNC;	
				VRESETH <= VRESETH;
			end
				
			// hblank
			if (horizontal_counter[8:3] === 6'b100010)
				pin_bHBLANK <= 1'b0;	// ~272
			else if (horizontal_counter[8:3] === 6'b101110) 
				pin_bHBLANK <= 1'b1;	// ~368
			else
				pin_bHBLANK <= pin_bHBLANK;
				
			// pin_bHRESET
			if (horizontal_counter[8:0] === 9'b000001111) // ~15
				pin_bHRESET <= 1'b1;	
			else
				pin_bHRESET <= 1'b0;

			//pin_1H_o <= horizontal_counter[0];	// 3.0 Mhz
			//pin_S1H_o <= horizontal_counter[0];	// is this in phase?
			//pin_2H_o <= horizontal_counter[1];	// 1.5 Mhz
			//pin_S2H_o <= horizontal_counter[1];	// is this in phase?
			//pin_4H_o <= horizontal_counter[2];	// 0.75 Mhz		
		end
	end
		
	assign pin_1H_o = horizontal_counter[0];	// 3.0 Mhz
	assign pin_S1H_o = horizontal_counter[0];	// is this in phase?
	assign pin_2H_o = horizontal_counter[1];	// 1.5 Mhz
	assign pin_S2H_o = horizontal_counter[1];	// is this in phase?
	assign pin_4H_o = horizontal_counter[2];	
	
	always @(negedge pin_bHSYNC or negedge _rst_n) begin	
		if (!_rst_n) begin
			vertical_counter <= 1;	// need to start at one otherwise we end up counting 265 lines!
		end else begin
			if (vertical_counter[8:3] === 6'b100001)	// ~264
				vertical_counter <= 1;	// need to start at one otherwise we end up counting 265 lines!
			else
				vertical_counter <= vertical_counter + 1'b1;
		end
	end
	
	always @(vertical_counter or _rst_n) begin
		if (!_rst_n) begin
			pin_bVSYNC <= 1'b1;
			pin_bVBLANK <= 1'b1;
			VRESET <= 1'b0;
			
			//pin_1V_o <= 1'b0;
			//pin_4V_o <= 1'b0;
			//pin_8V_o <= 1'b0;
		end else begin
			// pin_bVSYNC
			if (vertical_counter[8:3] === 6'b011111) //	~248
				pin_bVSYNC <= 1'b0;
			else if (vertical_counter[8:3] === 6'b000000) // ~336	
				pin_bVSYNC <= 1'b1;	
			else
				pin_bVSYNC <= pin_bVSYNC;	
			
			// vblank
			if (vertical_counter[8:3] === 6'b011110) //	~240
				pin_bVBLANK <= 1'b0;
			else if (vertical_counter[8:3] === 6'b000010) // ~16	
				pin_bVBLANK <= 1'b1;
			else
				pin_bVBLANK <= pin_bVBLANK;
		
			// pin_bVRESET when back to start of line 0
			VRESET <= (vertical_counter[8:0] === 9'b000000000) ? 1'b1 : 1'b0;
					
			//pin_1V_o <= vertical_counter[0];
			//pin_4V_o <= vertical_counter[3];
			//pin_8V_o <= vertical_counter[7];
		end
	end	
	
	assign pin_1V_o = vertical_counter[0];
	assign pin_4V_o = vertical_counter[3];
	assign pin_8V_o = vertical_counter[7];
endmodule

