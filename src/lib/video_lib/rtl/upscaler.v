module upscaler
#
(
	parameter C_COMPONENT_DEPTH = 8,
	parameter C_LINE_BUFFER_SIZE = 1024,
	parameter C_LINE_BUFFER_COUNT = 8,
	parameter C_DELTA_WIDTH = 8
)
(
	input wire rst,
	
	input wire pixel_clk_a,
	input wire hsync_a,
	input wire vsync_a,
	input wire hblank_a,
	input wire vblank_a,
	
	input wire [C_COMPONENT_DEPTH-1:0] red_a,
	input wire [C_COMPONENT_DEPTH-1:0] green_a,
	input wire [C_COMPONENT_DEPTH-1:0] blue_a,
	
	input wire pixel_clk_b,
	input wire hsync_b,
	input wire vsync_b,
	input wire hblank_b,
	input wire vblank_b,
	
	output reg [C_COMPONENT_DEPTH-1:0] red_b,
	output reg [C_COMPONENT_DEPTH-1:0] green_b,
	output reg [C_COMPONENT_DEPTH-1:0] blue_b
);

reg [C_COMPONENT_DEPTH-1:0] line_buffer[0:2][0:C_LINE_BUFFER_SIZE-1][0:C_LINE_BUFFER_COUNT-1];

reg [10:0] pixel_count_a = 0;
reg [10:0] line_width_a = 0;
wire [10:0] write_pos_a;
reg [C_LINE_BUFFER_COUNT-1:0] write_buffer_index_a = 0;
reg hsync_a_latched = 0;

assign active_a = hblank_a !== 0;
assign write_pos_a = pixel_count_a;

reg [10:0] pixel_count_b = 0;
reg [10:0] line_width_b = 0;
wire [10:0] read_pos_b;
reg [C_DELTA_WIDTH+9:0] line_acc = 0;
reg [C_DELTA_WIDTH:0] line_delta = 0;
reg [C_LINE_BUFFER_COUNT-1:0] read_buffer_index_b = 0;
reg hsync_b_latched = 0;

assign active_b = hblank_b !== 1;
assign read_pos_b = line_acc[C_DELTA_WIDTH+9:C_DELTA_WIDTH];

integer delta_width = (1<<C_DELTA_WIDTH);

always @(posedge pixel_clk_a) begin
	if (rst) begin
		pixel_count_a <= 0;
		line_width_a <= 0;
		write_buffer_index_a <= 0;
	end else begin
		if (hsync_a_latched && ~hsync_a) begin
			// cache active line width
			line_width_a = pixel_count_a;
			
			// return to start of next line
			pixel_count_a = 0;
			
			// next line in the buffer
			if (write_buffer_index_a == C_LINE_BUFFER_COUNT) write_buffer_index_a <= 0;
			else write_buffer_index_a <= write_buffer_index_a + 1;
		end
		
		if (active_a) begin
			line_buffer[0][write_pos_a][write_buffer_index_a] <= red_a;
			line_buffer[1][write_pos_a][write_buffer_index_a] <= green_a;
			line_buffer[2][write_pos_a][write_buffer_index_a] <= blue_a;
			pixel_count_a <= pixel_count_a + 1;
		end
	end
	
	hsync_a_latched <= hsync_a;
end

always @(posedge pixel_clk_b) begin
	if (rst) begin
		pixel_count_b <= 0;
		line_width_b <= 0;
		read_buffer_index_b <= 0;
		line_delta <= 0;
		line_acc <= 0;
	end else begin
		if (hsync_b_latched && ~hsync_b) begin
			// cache active line width
			line_width_b = pixel_count_b;
			
			// return to start of next line
			pixel_count_b = 0;
			
			// reset line accumulator
			line_acc = 0;
			
			// calculate scaling factor
			if (line_width_a != 0) line_delta <= (delta_width * line_width_a) / line_width_b;
			
			// next line in the buffer
			//if (read_buffer_index_a = C_LINE_BUFFER_COUNT) read_buffer_index_a <= 0;
			//else read_buffer_index_a <= read_buffer_index_a + 1;
		end
		
		if (active_b) begin
			red_b <= line_buffer[0][read_pos_b][read_buffer_index_b];
			green_b <= line_buffer[1][read_pos_b][read_buffer_index_b];
			blue_b <= line_buffer[2][read_pos_b][read_buffer_index_b];
			pixel_count_b <= pixel_count_b + 1;
			line_acc <= line_acc + line_delta;
		end else begin
			red_b <= 0;
			green_b <= 0;
			blue_b <= 0;
		end
	end
	
	hsync_b_latched <= hsync_b;
end





endmodule
