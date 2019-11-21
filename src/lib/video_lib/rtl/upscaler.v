module upscaler
#
(
	parameter C_COMPONENT_DEPTH = 8,
	parameter C_LINE_BUFFER_SIZE = 1024,
	parameter C_LINE_BUFFER_COUNT = 3,
	parameter C_DELTA_WIDTH_PRECISION = 8,
	parameter C_DELTA_HEIGHT_PRECISION = 8
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

reg [C_COMPONENT_DEPTH-1:0] line_buffer_red[0:C_LINE_BUFFER_COUNT-1][0:C_LINE_BUFFER_SIZE-1];
reg [C_COMPONENT_DEPTH-1:0] line_buffer_green[0:C_LINE_BUFFER_COUNT-1][0:C_LINE_BUFFER_SIZE-1];
reg [C_COMPONENT_DEPTH-1:0] line_buffer_blue[0:C_LINE_BUFFER_COUNT-1][0:C_LINE_BUFFER_SIZE-1];

// horizontal
reg [10:0] pixel_count_a = 0;
reg [10:0] active_width_a = 0;
wire [10:0] write_pos_a;
reg hsync_a_latched = 0;
// vertical
reg [10:0] line_count_a = 0;
reg [10:0] active_height_a = 0;
reg [3:0] write_buffer_index_a = 0;
reg [3:0] sof_line_buffer_index_a = 0;
reg vsync_a_latched = 0;

assign active_a = hblank_a === 0;
assign write_pos_a = pixel_count_a;

// horizontal
reg [10:0] pixel_count_b = 0;
reg [10:0] active_width_b = 0;
wire [10:0] read_pos_b;
reg [C_DELTA_WIDTH_PRECISION+9:0] hpos_acc = 0;
reg [C_DELTA_WIDTH_PRECISION:0] hpos_delta = 0;
reg hsync_b_latched = 0;
// vertical
reg [10:0] line_count_b = 0;
reg [10:0] active_height_b = 0;
reg [C_DELTA_HEIGHT_PRECISION+C_LINE_BUFFER_COUNT-1:0] vpos_acc = 0;
reg [C_DELTA_HEIGHT_PRECISION:0] vpos_delta = 0;
reg [3:0] read_buffer_index_b;
reg [3:0] sof_line_buffer_index_b = 0;
reg vsync_b_latched = 0;

assign active_b = hblank_b === 0;
assign read_pos_b = hpos_acc[C_DELTA_WIDTH_PRECISION+9:C_DELTA_WIDTH_PRECISION];

integer delta_width = (1 << C_DELTA_WIDTH_PRECISION);
integer delta_height = (1 << C_DELTA_HEIGHT_PRECISION);

always @(posedge pixel_clk_a) begin
	if (rst) begin
		pixel_count_a <= 0;
		line_count_a <= 0;
		active_width_a <= 0;	
		active_height_a <= 0;
		write_buffer_index_a <= 0;
	end else begin
		if (hsync_a_latched && ~hsync_a) begin
			// cache active width
			active_width_a = pixel_count_a;
			
			// return to start of next line
			pixel_count_a = 0;
			
			// next line in the buffer
			//if (write_buffer_index_a == C_LINE_BUFFER_COUNT) write_buffer_index_a = 0;
			//else write_buffer_index_a = write_buffer_index_a + 1;
			write_buffer_index_a = (write_buffer_index_a + 1) % C_LINE_BUFFER_COUNT;
			//if (write_buffer_index_a == C_LINE_BUFFER_COUNT) write_buffer_index_a = 0;
			
			line_count_a <= line_count_a + 1;
		end
		
		if (vsync_a_latched && ~vsync_a) begin
			// cache active height
			active_height_a <= line_count_a;
			
			// return to start of next frame
			line_count_a <= 0;
			
			sof_line_buffer_index_a <= write_buffer_index_a;
		end
		
		if (active_a) begin
			line_buffer_red[write_buffer_index_a][write_pos_a] <= red_a;
			line_buffer_green[write_buffer_index_a][write_pos_a] <= green_a;
			line_buffer_blue[write_buffer_index_a][write_pos_a] <= blue_a;
			pixel_count_a <= pixel_count_a + 1;
		end
	end
	
	hsync_a_latched <= hsync_a;
	vsync_a_latched <= vsync_a;
end

always @(posedge pixel_clk_b) begin
	if (rst) begin
		pixel_count_b <= 0;
		active_width_b <= 0;
		//read_buffer_index_b <= 0;
		hpos_delta <= 0;
		hpos_acc <= 0;
	end else begin
		if (vsync_b_latched && ~vsync_b) begin
			// cache active height
			active_height_b <= line_count_b;
			
			// return to start of next frame
			line_count_b <= 0;
			
			// calculate scaling factor
			if (active_height_a != 0) vpos_delta <= (delta_height * active_height_a) / active_height_b;
			
			// reset line accumulator 
			vpos_acc = 0;
			
			sof_line_buffer_index_b = sof_line_buffer_index_a;
			read_buffer_index_b = sof_line_buffer_index_b; // % C_LINE_BUFFER_COUNT;
		end
		
		if (hsync_b_latched && ~hsync_b) begin
			// cache active line width
			active_width_b = pixel_count_b;
			
			// return to start of next line
			pixel_count_b = 0;
			
			// reset line accumulator
			hpos_acc = 0;
			
			// calculate scaling factor
			if (active_width_a != 0) hpos_delta <= (delta_width * active_width_a) / active_width_b;
			
			line_count_b = line_count_b + 1;
			
			vpos_acc = vpos_acc + vpos_delta;	

			read_buffer_index_b = (sof_line_buffer_index_b + vpos_acc[C_DELTA_HEIGHT_PRECISION+C_LINE_BUFFER_COUNT-1:C_DELTA_HEIGHT_PRECISION]) % C_LINE_BUFFER_COUNT;
			//if (read_buffer_index_b == C_LINE_BUFFER_COUNT) read_buffer_index_b = 0;
		end
		
		if (active_b) begin
			red_b <= line_buffer_red[read_buffer_index_b][read_pos_b];
			green_b <= line_buffer_green[read_buffer_index_b][read_pos_b];
			blue_b <= line_buffer_blue[read_buffer_index_b][read_pos_b];
			pixel_count_b <= pixel_count_b + 1;
			hpos_acc <= hpos_acc + hpos_delta;
		end else begin
			red_b <= 0;
			green_b <= 0;
			blue_b <= 0;
		end
	end
	
	hsync_b_latched <= hsync_b;
	vsync_b_latched <= vsync_b;
end





endmodule
