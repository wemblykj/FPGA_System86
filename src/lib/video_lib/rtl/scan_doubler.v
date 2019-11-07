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

reg [C_COMPONENT_DEPTH-1:0] line_buffer[3][C_LINE_BUFFER_WIDTH][2];
reg write_buffer_select = 0;
reg read_buffer_select = 0;

reg [(C_LINE_BUFFER_WIDTH>>8)-1:0] write_pos = 0;
reg [(C_LINE_BUFFER_WIDTH>>8)-1:0] write_width = 0;
reg [(C_LINE_BUFFER_WIDTH>>7)-1:0] read_pos = 0;

assign adjusted_read_pos = read_pos[(C_LINE_BUFFER_WIDTH>>7)-1:1];

always @(posedge pixel_clk_in) begin
	line_buffer[0][write_pos][write_buffer_select] <= red_in;
	line_buffer[1][write_pos][write_buffer_select] <= green_in;
	line_buffer[2][write_pos][write_buffer_select] <= blue_in;
	write_pos = write_pos + 1;
end

always @(posedge pixel_clk_out) begin
	red_out <= line_buffer[0][adjusted_read_pos][read_buffer_select];
	green_out <= line_buffer[1][adjusted_read_pos][read_buffer_select];
	blue_out <= line_buffer[2][adjusted_read_pos][read_buffer_select];
	read_pos = read_pos + 1;
		
	if (read_pos === read_count) begin
		
	else begin
		red_out <= 0;
		green_out <= 0;
		blue_out <= 0;
		read_pos <= 0;
	end
end

always @(posedge hsync_in) begin
	// swap buffers
	read_buffer_select <= write_buffer_select;
	write_buffer_select = ~write_buffer_select;
	read_count <= write_pos + 1;
	write_pos <= 0;
end

always @(posedge hsync_out) begin
	if (read_count) begin
	else
	end
	// swap buffers
	read_buffer_select <= write_buffer_select;
	write_buffer_select = ~write_buffer_select;
	read_count <= write_pos + 1;
	write_pos <= 0;
end


endmodule
