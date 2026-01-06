`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:23:35 11/17/2020
// Design Name:   cus41
// Module Name:   C:/Users/paulw/Development/Arcade/FPGA_System86/src/lib/system86/simulation/custom/cus41_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus41
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`include "../address_decode_defs.vh"
	
module cus41_tb;

	reg _rst_n;
	reg cus41_6M_i;

	// CUS27 outputs
	wire cus41_CLK0_i;
	//wire cus41_6M_i;
	wire cus41_bVBLA;
	
	// Inputs
	reg [15:11] MA;
	reg cus41_MRbW_i;
	//reg bVBLA;
	//reg CLK_0;
	reg cus41_CLK1_i;
	//reg cus41_6M_i;
	reg bSWE;
	reg SA15;
	reg SA14;
	reg SA13;
	reg SA12;
	reg SA11;

	// Outputs
	wire bMRESET;
	wire bSINT;
	wire bMINT;
	wire SROM;
	wire SCS4;
	wire SCS3;
	wire SCS2;
	wire SCS1;
	wire SCS0;
	wire Q;
	wire bLTH0;
	wire bLTH1;
	wire bSND;
	wire bMCS0;
	wire bMCS1;
	wire bMCS2;
	wire bMCS3;
	wire bMCS4;
	wire bMROM;

	// Instantiate the Unit Under Test (UUT)
	cus41 uut (
		._rst_n(_rst_n), 
		.MA(MA), 
		.pin_MRbW_i(cus41_MRbW_i), 
		.pin_bVBLA_i(cus41_bVBLA), 
		.CLK_0(~clk_S2H), 
		.pin_CLK1_i(cus41_CLK1_i), 
		.pin_6M_i(cus41_6M_i), 
		.bSWE(bSWE), 
		.SA15(SA15), 
		.SA14(SA14), 
		.SA13(SA13), 
		.SA12(SA12), 
		.SA11(SA11), 
		.bMRESET(bMRESET), 
		.bSINT(bSINT), 
		.bMINT(bMINT), 
		.SROM(SROM), 
		.SCS4(SCS4), 
		.SCS3(SCS3), 
		.SCS2(SCS2), 
		.SCS1(SCS1), 
		.SCS0(SCS0), 
		.Q(Q), 
		.bLTH0(bLTH0), 
		.bLTH1(bLTH1), 
		.bSND(bSND), 
		.bMCS0(bMCS0), 
		.bMCS1(bMCS1), 
		.bMCS2(bMCS2), 
		.bMCS3(bMCS3), 
		.bMCS4(bMCS4), 
		.bMROM(bMROM)
	);

	// CUS27 - CLOCK DIVIDER
	cus27 
		cus27_9p_clock_divider(
			._rst_n(_rst_n),
			.cus41_6M_i_IN(cus41_6M_i),
			//.CLK_24M(CLK_24M),
			//.cus41_CLK1_i2M(cus41_CLK1_i2M),
			//.cus41_6M_i(cus41_6M_i),
			//.bVSYNC(bVSYNC),
			//.bHSYNC(bHSYNC),
			//.bHBLANK(bHBLANK),
			.cus41_bVBLA(cus41_bVBLA),
			//.nHRESET(nHRESET),
			//.nVRESET(nVRESET),
			//.CLK_8V(CLK_8V),
			//.CLK_4V(CLK_4V),
			//.cus41_CLK1_iV(cus41_CLK1_iV),
			//.CLK_4H(CLK_4H),
			//.s86_2H(s86_2H),
			//.s86_1H(s86_1H),
			.cus41_CLK0_i(cus41_CLK0_i)
			//.s86_S1H(s86_S1H)
		);
	
	integer address_msb;
	integer address_low;
	integer address_high;
		
	initial begin
		_rst_n = 0;
		cus41_6M_i = 0;
		
		// Initialize Inputs
		
		MA = 0;
		cus41_MRbW_i = 0;
		//bVBLA = 0;
		//CLK_0 = 0;
		cus41_CLK1_i = 0;
		//cus41_6M_i = 0;
		bSWE = 0;
		SA15 = 0;
		SA14 = 0;
		SA13 = 0;
		SA12 = 0;
		SA11 = 0;

		// Wait 100 ns for global reset to finish
		#100;
      _rst_n = 1;
		
		// Add stimulus here
		
		// 0000h - 1FFFh R/W	(sprite ram)
		$display ("0000h - 1FFFh R/W	(sprite ram)");
		cus41_MRbW_i = 1;
		`test_address_decode_range(1'b0, bMCS2, MA, 'h0000, 'h2000, 15, 11)
		`test_address_decode_range(1'b1, bMCS2, MA, 'h2000, 'he000, 15, 11)
		cus41_MRbW_i = 0;
		`test_address_decode_range(1'b0, bMCS2, MA, 'h0000, 'h2000, 15, 11)
		`test_address_decode_range(1'b1, bMCS2, MA, 'h2000, 'he000, 15, 11)
		cus41_MRbW_i = 1;
	
		// 2000h - 3FFFh R/W 	(videoram 1)
		$display ("2000h - 3FFFh R/W 	(videoram 1)");
		cus41_MRbW_i = 1;
		`test_address_decode_range(1'b1, bMCS0, MA, 'h0000, 'h2000, 15, 11)
		`test_address_decode_range(1'b0, bMCS0, MA, 'h2000, 'h2000, 15, 11)
		`test_address_decode_range(1'b1, bMCS0, MA, 'h4000, 'hc000, 15, 11)
		cus41_MRbW_i = 0;
		`test_address_decode_range(1'b1, bMCS0, MA, 'h0000, 'h2000, 15, 11)
		`test_address_decode_range(1'b0, bMCS0, MA, 'h2000, 'h2000, 15, 11)
		`test_address_decode_range(1'b1, bMCS0, MA, 'h4000, 'hc000, 15, 11)
		cus41_MRbW_i = 1;
		
		// 4000h - 5FFFh R/W		(videoram 2)
		$display ("4000h - 5FFFh R/W		(videoram 2)");
		cus41_MRbW_i = 1;
		`test_address_decode_range(1'b1, bMCS1, MA, 'h0000, 'h4000, 15, 11)
		`test_address_decode_range(1'b0, bMCS1, MA, 'h4000, 'h2000, 15, 11)
		`test_address_decode_range(1'b1, bMCS1, MA, 'h6000, 'ha000, 15, 11)
		cus41_MRbW_i = 0;
		`test_address_decode_range(1'b1, bMCS1, MA, 'h0000, 'h4000, 15, 11)
		`test_address_decode_range(1'b0, bMCS1, MA, 'h4000, 'h2000, 15, 11)
		`test_address_decode_range(1'b1, bMCS1, MA, 'h6000, 'ha000, 15, 11)
		cus41_MRbW_i = 1;
		
		// 6000h - 7FFFh R	(EEPROM 12D)
		$display ("6000h - 7FFFh R	(EEPROM 12D)");
		cus41_MRbW_i = 1;
		`test_address_decode_range(1'b1, bMCS4, MA, 'h0000, 'h6000, 15, 11)
		`test_address_decode_range(1'b0, bMCS4, MA, 'h6000, 'h2000, 15, 11)
		`test_address_decode_range(1'b1, bMCS4, MA, 'h8000, 'h8000, 15, 11)
		cus41_MRbW_i = 0;
		`test_address_decode_range(1'b1, bMCS4, MA, 'h0000, 'h6000, 15, 11)
		`test_address_decode_range(1'b0, bMCS4, MA, 'h6000, 'h2000, 15, 11)
		`test_address_decode_range(1'b1, bMCS4, MA, 'h8000, 'h8000, 15, 11)
		cus41_MRbW_i = 1;
		
		// 8000h - FFFFh R	(EEPROM 12C)
		$display ("8000h - FFFFh R	(EEPROM 12C)");
		cus41_MRbW_i = 1;
		`test_address_decode_range(1'b1, bMROM, MA, 'h0000, 'h8000, 15, 11)
		`test_address_decode_range(1'b0, bMROM, MA, 'h8000, 'h8000, 15, 11)
		cus41_MRbW_i = 0;
		`test_address_decode_range(1'b1, bMROM, MA, 'h0000, 'h8000, 15, 11)
		`test_address_decode_range(1'b1, bMROM, MA, 'h8000, 'h8000, 15, 11)
		cus41_MRbW_i = 1;
		// 0x8800 - 0x8800 W  (INT ACK)
		//assign main_int_ack = ~cus41_MRbW_i && MA[15:11] === 'b10001;
	
		// 0x8800 - 0x8800 W  (INT ACK)
		//assign sound_int_ack = ~bSWE && MA[15:11] === 'b10011;
	
		// D000h - D002h W	(scroll + priority)
		// D003h - D003h W 	(ROM 9D bank select)
		// D004h - D006h W	(scroll + priority)
		`test_address_decode_range(1'b1, bLTH0, MA, 'h0000, 'hd000, 15, 11)
		`test_address_decode_range(1'b0, bLTH0, MA, 'hd000, 'h0800, 15, 11)
		`test_address_decode_range(1'b1, bLTH0, MA, 'hd800, 'h2800, 15, 11)
	
		// D800h - D802h W	(scroll + priority)
		// D803h - D803h W 	(ROM 12D bank select)
		// D8004h - D806h W	(scroll + priority)
		`test_address_decode_range(1'b1, bLTH1, MA, 'h0000, 'hd800, 15, 11)
		`test_address_decode_range(1'b0, bLTH1, MA, 'hd800, 'h0800, 15, 11)
		`test_address_decode_range(1'b1, bLTH1, MA, 'he000, 'h2000, 15, 11)
		
		#100
		
		$finish();
	end

	// generate our 6.14025Mhz input clock
	always #81.4299 cus41_6M_i = ~cus41_6M_i;
      
endmodule

