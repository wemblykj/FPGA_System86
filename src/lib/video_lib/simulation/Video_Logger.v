`timescale 1ns/1ps

module Video_Logger
#
(
	parameter C_COMPONENT_DEPTH = 8,
	parameter C_FILE_NAME = "vga.txt"	
)
(
   input wire i_nRst,
	input wire i_Clk,
	input wire i_OutputEnable,
	input wire [C_COMPONENT_DEPTH-1:0] i_Red,
	input wire [C_COMPONENT_DEPTH-1:0] i_Green,
	input wire [C_COMPONENT_DEPTH-1:0] i_Blue,
	input wire i_nHSync,
	input wire i_nVSync
);

integer rgb_fd = -1;
initial begin
	rgb_fd = $fopen(C_FILE_NAME, "w");
end

always @(posedge i_Clk or i_nRst) begin
	if (~i_nRst) begin
		if (rgb_fd !== -1) begin
			$fclose(rgb_fd);
			rgb_fd = -1;
		end
	end else begin
		if (i_OutputEnable) begin
			if (rgb_fd !== -1)
				rgb_fd = $fopen(C_FILE_NAME, "w");
			
			$fwrite(rgb_fd, "%0d ns: %b %b %b %b %b\n", $time, i_nHSync, i_nVSync, i_Red, i_Green, i_Blue);
		end
	end
end

endmodule
