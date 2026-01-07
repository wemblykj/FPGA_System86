//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    cus27_jkff
// Module Name:    system86\src\custom\cus27_jkff.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - JK flip-flop based on third-party reverse engineering of the CUS27 die
//
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.ti.com/lit/ds/symlink/sn5476.pdf
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
module cus27_jkff (
  input wire CLK,
  input wire bJ,
  input wire K,
  input wire bSET,
  input wire bRES,
  output wire Q,
  output wire bQ,
);

  reg        q;

  assign Q = q;
  assign bQ = ~q;
  
  // non-inverted J input so conventional, and more readable, truth-table logic can be applied [^3]
  assign j = ~bJ;   

  always @(posedge CLK or posedge bSET or posedge bRES)
  begin
    if (~bSET && ~bRES) begin
      // [^3] suggests that both Q and bQ would go high until either SET or RES go inactive
      // most JK FF datasheets concur with this behaviour
      // this is not a scenario possible in the CUS27 according to [^2]
      // so we'll just ignore and leave the state unchanged
      q <= q;
    end else if (~bSET) begin
      q <= 1'b1;
    end else if (~bRES) begin
      q <= 1'b0;
    end else begin
        case({jK})
          00: q <= q;       // do  nothing
          01: q <= 1'b0;    // reset
          10: q <= 1'b1;    // set
          11: q <= ~q;      // toggle
        endcase
    end
  end
endmodule