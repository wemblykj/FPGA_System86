`timescale 1ns/1ns

module vga_logger
#
(
	parameter C_COMPONENT_DEPTH = 8,
	parameter C_FILE_NAME = "vga.txt"	
)
(
	input wire pixel_clk,
	input wire output_enable,
	input wire [C_COMPONENT_DEPTH-1:0] red,
	input wire [C_COMPONENT_DEPTH-1:0] green,
	input wire [C_COMPONENT_DEPTH-1:0] blue,
	input wire hsync,
	input wire vsync
);

integer rgb_fd = -1;
initial begin
	rgb_fd = $fopen(C_FILE_NAME, "w");
end

always @(posedge pixel_clk) begin
	if ((rgb_fd !== -1) & output_enable) begin
		$fwrite(rgb_fd, "%0t fs: %b %b %b %b %b\n", $time, hsync, vsync, red, green, blue);
	end
end

endmodule
