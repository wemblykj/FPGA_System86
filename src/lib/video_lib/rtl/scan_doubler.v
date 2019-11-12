module scan_doubler
#
(
	parameter C_COMPONENT_DEPTH = 8,
	parameter C_LINE_BUFFER_WIDTH = 1024
)
(
	input wire pixel_clk_in,
	input wire pixel_clk_out_ref,
	input wire [C_COMPONENT_DEPTH-1:0] red_in,
	input wire [C_COMPONENT_DEPTH-1:0] green_in,
	input wire [C_COMPONENT_DEPTH-1:0] blue_in,
	input wire hsync_in,
	input wire vsync_in,
	output reg [C_COMPONENT_DEPTH-1:0] red_out,
	output reg [C_COMPONENT_DEPTH-1:0] green_out,
	output reg [C_COMPONENT_DEPTH-1:0] blue_out,
	output reg hsync_out,
	output reg vsync_out
);

reg [C_COMPONENT_DEPTH-1:0] line_buffer[0:2][0:C_LINE_BUFFER_WIDTH-1][0:1];
reg write_buffer_select = 0;
reg read_buffer_select = 0;

reg [10:0] write_pos = 0;
reg [10:0] line_width = 0;
reg [10:0] read_pos = 0;
reg [10:0] hsync_width = 0;

reg hsync_in_latched = 1;

assign adjusted_read_pos = read_pos[(C_LINE_BUFFER_WIDTH>>7)-1:1];
assign line_pos = read_pos[(C_LINE_BUFFER_WIDTH>>8)-1:0];

always @(posedge pixel_clk_in) begin
	if (hsync_in_latched === 1 && hsync_in === 0) begin
		// get the width of the line just written
		line_width = write_pos;
		// swap write buffers
		write_buffer_select = ~write_buffer_select;
		// reset the write position
		write_pos = 0;
	end else if (hsync_in_latched === 0 && hsync_in === 1) begin
		// gives us the width in pixels of the hsync pulse
		hsync_width = write_pos;
	end
	
	hsync_in_latched <= hsync_in;
	
	line_buffer[0][write_pos][write_buffer_select] <= red_in;
	line_buffer[1][write_pos][write_buffer_select] <= green_in;
	line_buffer[2][write_pos][write_buffer_select] <= blue_in;
	write_pos <= write_pos + 1;
end

always @(posedge pixel_clk_out_ref) begin
	if (hsync_in_latched === 0 && hsync_in === 1) begin
		// swap read buffers
		read_buffer_select = ~read_buffer_select;
		read_pos = 0;
	end
	
	hsync_out <= line_pos < hsync_width;
	
	red_out <= line_buffer[0][adjusted_read_pos][read_buffer_select];
	green_out <= line_buffer[1][adjusted_read_pos][read_buffer_select];
	blue_out <= line_buffer[2][adjusted_read_pos][read_buffer_select];
	read_pos <= read_pos + 1;
end





endmodule
