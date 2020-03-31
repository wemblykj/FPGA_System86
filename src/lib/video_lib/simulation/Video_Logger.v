`timescale 1ns/1ps

module Video_Logger
#
(
	parameter C_COMPONENT_DEPTH = 8,
	parameter C_FILE_NAME = "vga.txt"	
)
(
   input wire i_Rst,
	input wire i_Clk,
	input wire i_OutputEnable,
	input wire [C_COMPONENT_DEPTH-1:0] i_Red,
	input wire [C_COMPONENT_DEPTH-1:0] i_Green,
	input wire [C_COMPONENT_DEPTH-1:0] i_Blue,
	input wire i_nHSync,
	input wire i_nVSync
);

reg i_Rst_latched;

integer rgb_fd = -1;
initial begin
	rgb_fd = $fopen(C_FILE_NAME, "w");
	i_Rst_latched = i_Rst;
end

always @(posedge i_Clk) begin
	if (i_Rst) begin
		if (~i_Rst_latched) begin
			if (rgb_fd !== -1) $fclose(rgb_fd);
			rgb_fd = $fopen(C_FILE_NAME, "w");
		end
	end else begin
		if ((rgb_fd !== -1) & i_OutputEnable) begin
			$fwrite(rgb_fd, "%0d ns: %b %b %b %b %b\n", $time, i_nHSync, i_nVSync, i_Red, i_Green, i_Blue);
		end
	end
	
	i_Rst_latched <= i_Rst;
end

endmodule
