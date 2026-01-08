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
  input  wire CLK,
  input  wire bJ,
  input  wire K,
  input  wire bSET,
  input  wire bRES,
  output wire Q,
  output wire bQ
);

  // Internal storage for state
  reg q;

  // Assign outputs
  assign Q = (bSET == 1'b0 && bRES == 1'b0) ? 1'b1 : q;     // Unstable state when both bSET and bRES are low
  assign bQ = (bSET == 1'b0 && bRES == 1'b0) ? 1'b1 : ~q;   // Unstable state when both bSET and bRES are low

  // Sequential always block
  always @(posedge CLK or negedge bSET or negedge bRES) begin
    // Handle asynchronous active-low set and reset with unstable condition
    if (!bSET && !bRES) begin
      // Both active-low: enter unstable state (do nothing as assign handles this)
      q <= q; // Keep `q` in its prior state for recovery
    end else if (!bSET) begin
      // Set condition
      q <= 1'b1;
    end else if (!bRES) begin
      // Reset condition
      q <= 1'b0;
    end else begin
      // Handle normal JK flip-flop behavior
      case ({~bJ, K}) // {J, K} concatenation (interpreting bJ as active-low J)
        2'b00: q <= q;       // No change
        2'b01: q <= 1'b0;    // Reset
        2'b10: q <= 1'b1;    // Set
        2'b11: q <= ~q;      // Toggle
      endcase
    end
  end

endmodule