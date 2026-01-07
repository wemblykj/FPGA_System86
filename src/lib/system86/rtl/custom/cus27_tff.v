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
  input wire CLK,
  output wire Q,
  output wire bQ,
  input wire bSET,
  input wire bRES,
);

  reg        q;

  assign Q = q;
  assign bQ = ~q;

  always @(posedge CLK or posedge bSET or posedge bRES)
  begin
    if (~bSET && ~bRES) begin
      // this is not a scenario possible in the CUS27 according to [^2]
      // so we'll just ignore and leave the state unchanged
      q <= q;
    end else if (~bSET) begin
      q <= 1'b1;
    end else if (~bRES) begin
      q <= 1'b0;
    end else begin
      // currently assuming that SET and RES are as per D-type FF and that when they are not active
      // the FF toggles on every clock tick and that there is no explicit enabling 'T' input [^3]
      q <= ~q;
    end
  end
endmodule