module Upscaler
#
(
	parameter C_COMPONENT_DEPTH = 8,
	parameter C_LINE_BUFFER_SIZE = 1024,
	parameter C_LINE_BUFFER_COUNT = 3,
	parameter C_DELTA_WIDTH_PRECISION = 12,
	parameter C_DELTA_HEIGHT_PRECISION = 12
)
(
	input wire i_Rst,
	
	input wire i_ClkA,
	input wire i_HSyncA,
	input wire i_VSyncA,
	input wire i_HBlankA,
	input wire i_VBlankA,
	
	input wire [C_COMPONENT_DEPTH-1:0] i_RedA,
	input wire [C_COMPONENT_DEPTH-1:0] i_GreenA,
	input wire [C_COMPONENT_DEPTH-1:0] i_BlueA,
	
	input wire i_ClkB,
	input wire i_HSyncB,
	input wire i_VSyncB,
	input wire i_HBlankB,
	input wire i_VBlankB,
	
	output reg o_Locked,
	output reg o_HSyncB,
	output reg o_VSyncB,
	output reg o_HBlankB,
	output reg o_VBlankB,
	output reg [C_COMPONENT_DEPTH-1:0] o_RedB,
	output reg [C_COMPONENT_DEPTH-1:0] o_GreenB,
	output reg [C_COMPONENT_DEPTH-1:0] o_BlueB
);

reg [C_COMPONENT_DEPTH-1:0] line_buffer_red[0:C_LINE_BUFFER_COUNT-1][0:C_LINE_BUFFER_SIZE-1];
reg [C_COMPONENT_DEPTH-1:0] line_buffer_green[0:C_LINE_BUFFER_COUNT-1][0:C_LINE_BUFFER_SIZE-1];
reg [C_COMPONENT_DEPTH-1:0] line_buffer_blue[0:C_LINE_BUFFER_COUNT-1][0:C_LINE_BUFFER_SIZE-1];

// horizontal
reg [10:0] pixel_count_a = 0;
reg [10:0] active_width_a = 0;
wire [10:0] write_pos_a;
reg i_HSyncA_latched = 0;
reg i_HBlankA_latched = 0;
// vertical
reg [10:0] line_count_a = 0;
reg [10:0] active_height_a = 0;
reg [4:0] write_buffer_index_a = 0;
reg [4:0] sof_line_buffer_index_a = 0;
reg i_VSyncA_latched = 0;
reg i_VBlankA_latched = 0;

assign active_a = i_HBlankA === 0 && i_VBlankA === 0;
assign write_pos_a = pixel_count_a;

// horizontal
reg [10:0] pixel_count_b = 0;
reg [10:0] active_width_b = 0;
wire [10:0] read_pos_b;
reg [C_DELTA_WIDTH_PRECISION+9:0] hpos_acc = 0;
reg [C_DELTA_WIDTH_PRECISION:0] hpos_delta = 0;
// vertical
reg [10:0] line_count_b = 0;
reg [10:0] active_height_b = 0;
reg [C_DELTA_HEIGHT_PRECISION+9:0] vpos_acc = 0;
reg [C_DELTA_HEIGHT_PRECISION:0] vpos_delta = 0;
reg [4:0] read_buffer_index_b;
reg [4:0] sof_line_buffer_index_b = 0;

//assign active_b = i_HBlankB === 0 && w_VBlankB === 0;
assign read_pos_b = hpos_acc[C_DELTA_WIDTH_PRECISION+9:C_DELTA_WIDTH_PRECISION];

integer delta_width = (1 << C_DELTA_WIDTH_PRECISION);
integer delta_height = (1 << C_DELTA_HEIGHT_PRECISION);

reg w_LockedB = 0;
reg w_HSyncB = 1;
reg w_VSyncB = 1;
reg w_HBlankB = 0;
reg w_VBlankB = 0;
    
always @(posedge i_ClkA) begin
	if (i_Rst) begin
		pixel_count_a <= 0;
		line_count_a <= 0;
		active_width_a <= 0;	
		active_height_a <= 0;
		write_buffer_index_a <= 0;
		i_HSyncA_latched <= 0;
		i_VSyncA_latched <= 0;
		i_VBlankA_latched <= 0;
	end else begin
		if (i_HSyncA_latched && ~i_HSyncA) begin
			// cache active width
			active_width_a = pixel_count_a;
			
			// return to start of next line
			pixel_count_a = 0;
			
			if (i_VBlankA_latched === 0) begin			
				line_count_a <= line_count_a + 1;
				
				// next line in the buffer
				write_buffer_index_a <= (write_buffer_index_a + 1) % C_LINE_BUFFER_COUNT;
			end
		end
		
		if (i_VSyncA_latched && ~i_VSyncA) begin
			// cache active height
			active_height_a <= line_count_a;
			
			// return to start of next frame
			line_count_a <= 0;
			
			sof_line_buffer_index_a <= write_buffer_index_a;
		end
		
		if (i_HBlankA === 0) begin
			pixel_count_a <= pixel_count_a + 1;
			
			if (i_VBlankA === 0) begin
				line_buffer_red[write_buffer_index_a][write_pos_a] <= i_RedA;
				line_buffer_green[write_buffer_index_a][write_pos_a] <= i_GreenA;
				line_buffer_blue[write_buffer_index_a][write_pos_a] <= i_BlueA;
			end
		end
	end
	
	i_HSyncA_latched <= i_HSyncA;
	i_VSyncA_latched <= i_VSyncA;
	i_VBlankA_latched <= i_VBlankA;
end

always @(posedge i_ClkB) begin
	o_Locked <= w_LockedB;
	o_HSyncB <= w_HSyncB;
	o_VSyncB <= w_VSyncB;
	o_HBlankB <= w_HBlankB;
	o_VBlankB <= w_VBlankB;
	
	if (w_HBlankB === 0 && w_VBlankB === 0) begin
		o_RedB <= line_buffer_red[read_buffer_index_b][read_pos_b];
		o_GreenB <= line_buffer_green[read_buffer_index_b][read_pos_b];
		o_BlueB <= line_buffer_blue[read_buffer_index_b][read_pos_b];
	end else begin
		o_RedB <= 0;
		o_GreenB <= 0;
		o_BlueB <= 0;
	end
end

always @(negedge i_ClkB) begin
	if (i_Rst) begin
		pixel_count_b <= 0;
		active_width_b <= 0;
		hpos_delta <= 0;
		hpos_acc <= 0;
		w_LockedB <= 0;
		w_HSyncB <= 1;
		w_VSyncB <= 1;
		w_HBlankB <= 0;
		w_VBlankB <= 0;
	end else begin
		if (w_HSyncB && ~i_HSyncB) begin
			// cache active line width
			active_width_b = pixel_count_b;
			
			// return to start of next line
			pixel_count_b = 0;
			
			// reset line accumulator
			hpos_acc = 0;
			
			// calculate scaling factor
			if (active_width_a != 0) hpos_delta <= (delta_width * active_width_a) / active_width_b;
			
			//if (i_VBlankB === 0) begin
				line_count_b <= line_count_b + 1;
				vpos_acc <= vpos_acc + vpos_delta;
				read_buffer_index_b <= (sof_line_buffer_index_b + vpos_acc[C_DELTA_HEIGHT_PRECISION+9:C_DELTA_HEIGHT_PRECISION]) % C_LINE_BUFFER_COUNT;
			//end
			
		end else if (i_HBlankB === 0) begin
			pixel_count_b <= pixel_count_b + 1;
			hpos_acc <= hpos_acc + hpos_delta;
			
		end
		
		if (w_VSyncB && ~i_VSyncB) begin
			// cache active height
			active_height_b <= line_count_b;
			
			// return to start of next frame
			line_count_b <= 0;
			
			// calculate scaling factor
			if (active_height_a != 0) vpos_delta <= (delta_height * active_height_a) / active_height_b;
			
			// reset line accumulator 
			vpos_acc = 0;
			
			sof_line_buffer_index_b <= sof_line_buffer_index_a;
			read_buffer_index_b <= sof_line_buffer_index_b;
			
			w_LockedB <= 1;
		end
	end
	
	w_HSyncB <= i_HSyncB;
	w_VSyncB <= i_VSyncB;
	w_HBlankB <= i_HBlankB;
	w_VBlankB <= i_VBlankB;
end





endmodule
