//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    cus27_dff
// Module Name:    system86\src\custom\cus27_dff.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - D-type flip-flop based on third-party reverse engineering of the CUS27 die
//
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.ti.com/lit/ds/symlink/sn74lvc2g74-ep.pdf
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
module cus27_dff (
  input wire _rst_ni,
  input wire CLK,
  input wire D,
  output wire Q,
  output wire bQ,
  input wire bSET,
  input wire bRES
);

  reg        q;

  assign d = (D !== 1'bz) ? D : 1'b0;
  
  assign set = (bSET !== 1'bz) ? ~bSET : 1'b0;
  assign res = (bRES !== 1'bz) ? ~bRES : 1'b0;
  
  assign Q = (set && res) ? 1'b1 : q;     // Unstable state when both bSET and bRES are low
  assign bQ = (set && res) ? 1'b1 : ~q;   // Unstable state when both bSET and bRES are low

  always @(negedge _rst_ni or posedge CLK or posedge set or posedge res)
  begin
    if (!_rst_ni) begin
	   q <= 1'b0;
    end else if (set && res) begin
      // most commerial D-type FF seem to have a preload or a reset but not both
      // [^3] suggests that both Q and bQ would go high until either SET or RES go inactive
      // this is not a scenario possible in the CUS27 according to [^2]
      // so we'll just ignore and leave the state unchanged
      q <= q;
    end else if (set) begin
      q <= 1'b1;
    end else if (res) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end
endmodule