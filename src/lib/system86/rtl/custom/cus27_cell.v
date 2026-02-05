module cus27_cell
(
	input  wire D1,
	input  wire D2,
	input  wire D3,
	input  wire D4,
	input  wire Q_IN,
	output wire Q,
	output wire bQ
);
	assign d1 = resolve_input(D1);
	assign d2 = resolve_input(D2);
	assign d3 = resolve_input(D3);
	assign d4 = resolve_input(D4);
	
	// logic high if not connected otherwise acts as a pull-down when logic low
	assign q_in = (Q_IN !== 1'bx && Q_IN !== 1'bz) ? Q_IN : 1'b1;
	
	assign Q = q;
	assign bQ = ~q;
	
	// output of input stage - logic high if all inputs are low (or disconnected)
	assign x = d1 | d2 | d3 | d4;
	
	// q is logic high when x is logic high and not pulled-low by Q_IN
	// FIXME: this works but is not intuitive
	assign #1 q = q_in & x;
	
	

	// Function to resolve high-impedance inputs - logic low if not connected
	function resolve_input(input sig);
		begin
			resolve_input = (sig !== 1'bx && sig !== 1'bz) ? sig : 1'b0;
		end
		
	endfunction
	
endmodule