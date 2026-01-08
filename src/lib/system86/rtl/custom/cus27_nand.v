//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    cus27_nand
// Module Name:    system86\src\custom\cus27_nand.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - 4 input NAND gate based on third-party reverse engineering of the CUS27 die
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
module cus27_nand (
  input wire A,
  input wire B,
  input wire C,
  input wire D,
  output wire Y
);

  // Internal wires for resolved inputs
  wire a, b, c, d;

  // Resolve each input (replace high-impedance with 1)
  assign a = resolve_input(A);
  assign b = resolve_input(B);
  assign c = resolve_input(C);
  assign d = resolve_input(D);
  
  // NAND operation on the resolved inputs
  assign Y = ~(a & b & c & d);
  
  // Function to resolve high-impedance inputs
  function resolve_input(input sig);
    begin
      resolve_input = (sig !== 1'bz) ? sig : 1'b1;
    end
  endfunction
  
endmodule