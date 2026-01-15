//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    cus27_tff
// Module Name:    system86\src\custom\cus27_tff.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - toggle flip-flop based on third-party reverse engineering of the CUS27 die
//                 
//
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.electronics-tutorials.ws/sequential/toggle-flip-flop.html
//
//                 Kudos go to:
//                  Furrtek for reverse engineering: http://www.furrtek.org
//                  JohnDMcMaster for die photos: https://siliconprawn.org/
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module cus27_tff (
  input wire _rst_ni,
  input wire CLK,
  input wire T,
  input wire bSET,
  input wire bRES,
  output wire Q,
  output wire bQ
);

  reg        q;

  //assign t = (T !== 1'bz) ? T : 1'b0;

  assign set = (bSET !== 1'bz) ? ~bSET : 1'b0;
  assign res = (bRES !== 1'bz) ? ~bRES : 1'b0;
  
  assign Q = (set && res) ? 1'b1 : q;     // Unstable state when both bSET and bRES are low
  assign bQ = (set && res) ? 1'b1 : ~q;   // Unstable state when both bSET and bRES are low

  always @(negedge _rst_ni or posedge CLK or posedge set or posedge res)
  begin
    if (!_rst_ni) begin
	   q <= 1'b0;
    end else if (set && res) begin
      // this is not a scenario possible in the CUS27 according to [^2]
      // so we'll just ignore and leave the state unchanged
      q <= q;
    end else if (set) begin
      q <= 1'b1;
    end else if (res) begin
      q <= 1'b0;
    end else begin
      // currently assuming that SET and RES are as per D-type FF and that when they are not active
      // the FF toggles on every clock tick and that there is no explicit enabling 'T' input [^3]
      q <= ~q;
    end
  end
endmodule