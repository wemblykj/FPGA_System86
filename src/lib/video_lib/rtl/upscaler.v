module Upscaler
#
(
	parameter C_COMPONENT_DEPTH = 8,
	parameter C_USE_BLANKING_A = 1,
	parameter C_USE_BLANKING_B = 1,
	parameter C_LINE_BUFFER_SIZE = 1024,
	parameter C_LINE_BUFFER_COUNT = 3,
	parameter C_VERTICAL_SYNC_DELAY = 2,
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
reg [10:0] w_HCountA = 0;
reg [10:0] w_WidthA = 0;
wire [10:0] w_HPosA;
// vertical
reg [10:0] w_VCountA = 0;
reg [10:0] w_HeightA = 0;
reg [4:0] w_VBufferIndexA = 0;
reg [4:0] w_SoFVBufferIndexA = 0;

wire w_HTriggerA;	
wire w_VTriggerA;
wire w_HActiveA;	
wire w_VActiveA;	

reg w_HTriggerA_latched = 0;
reg w_VTriggerA_latched = 0;

assign w_HPosA = w_HCountA;

// horizontal
reg [10:0] w_HCountB = 0;
reg [10:0] w_WidthB = 0;
wire [10:0] w_HPosB;
reg [C_DELTA_WIDTH_PRECISION+9:0] hpos_acc = 0;
reg [C_DELTA_WIDTH_PRECISION:0] hpos_delta = 0;
// vertical
reg [10:0] w_VCountB = 0;
reg [10:0] w_HeightB = 0;
reg [C_DELTA_HEIGHT_PRECISION+9:0] vpos_acc = 0;
reg [C_DELTA_HEIGHT_PRECISION:0] vpos_delta = 0;
reg [4:0] w_VBufferIndexB;
reg [4:0] w_SoFVBufferIndexB = 0;

assign w_HPosB = hpos_acc[C_DELTA_WIDTH_PRECISION+9:C_DELTA_WIDTH_PRECISION];

wire w_HTriggerB;	
wire w_VTriggerB;
wire w_HActiveB;	
wire w_VActiveB;	

reg w_HTriggerB_latched = 0;
reg w_VTriggerB_latched = 0;

reg w_LockedB = 0;
reg w_HSyncB = 1;
reg w_VSyncB = 1;
reg w_HBlankB = 0;
reg w_VBlankB = 0;
reg [C_VERTICAL_SYNC_DELAY-1:0] w_VSyncB_Delay = {C_VERTICAL_SYNC_DELAY{1'b1}};
reg [C_VERTICAL_SYNC_DELAY-1:0] w_VBlankB_Delay = 0;

reg [C_COMPONENT_DEPTH-1:0] w_RedB = 0;
reg [C_COMPONENT_DEPTH-1:0] w_GreenB = 0;
reg [C_COMPONENT_DEPTH-1:0] w_BlueB = 0;

generate
	if (C_USE_BLANKING_A == 1) begin
		assign w_HTriggerA = ~i_HBlankA;
		assign w_VTriggerA = ~i_VBlankA;
		assign w_HActiveA = ~i_HBlankA;
		assign w_VActiveA = ~i_VBlankA;
	end else begin
		assign w_HTriggerA = ~i_HSyncA;
		assign w_VTriggerA = ~i_VSyncA;
		assign w_HActiveA = 1;
		assign w_VActiveA = 1;
	end

	if (C_USE_BLANKING_B == 1) begin
		assign w_HTriggerB = ~i_HBlankB;
		assign w_VTriggerB = ~w_VBlankB_Delay[C_VERTICAL_SYNC_DELAY-1];
		assign w_HActiveB = ~i_HBlankB;
		assign w_VActiveB = ~w_VBlankB_Delay[C_VERTICAL_SYNC_DELAY-1];
	end else begin
		assign w_HTriggerB = ~i_HSyncB;
		assign w_VTriggerB = ~w_VSyncB_Delay[C_VERTICAL_SYNC_DELAY-1];
		assign w_HActiveB = 1;
		assign w_VActiveB = 1;
	end
endgenerate

integer delta_width = (1 << C_DELTA_WIDTH_PRECISION);
integer delta_height = (1 << C_DELTA_HEIGHT_PRECISION);

always @(negedge i_ClkA) begin
	if (i_Rst) begin
		w_HCountA <= 0;
		w_VCountA <= 0;
		w_WidthA <= 0;	
		w_HeightA <= 0;
		w_VBufferIndexA <= 0;
		w_SoFVBufferIndexA <= 0;
		w_HTriggerA_latched <= 0;		
		w_VTriggerA_latched <= 0;		
	end else begin
		// next line ?
		if (w_HTriggerA && ~w_HTriggerA_latched) begin
			// cache active width
			w_WidthA = w_HCountA + 1;
			
			// return to start of next line
			w_HCountA = 0;
			
			// increment active line
			if (w_VActiveA) begin
				w_VCountA = w_VCountA + 1;
				
				// next line in the buffer
				w_VBufferIndexA = (w_VBufferIndexA + 1) % C_LINE_BUFFER_COUNT;
			end
		end else if (w_HActiveA) begin
			// next pixel
			w_HCountA = w_HCountA + 1;
		end
	end
	
	// next frame?
	if (w_VTriggerA && ~w_VTriggerA_latched) begin
		// cache active height
		w_HeightA = w_VCountA;
	
		// return to start of next frame
		w_VCountA = 0;
		
		w_SoFVBufferIndexA = w_VBufferIndexA;
	end
	
	if (w_VActiveA && w_HActiveA) begin
		line_buffer_red[w_VBufferIndexA][w_HPosA] <= i_RedA;
		line_buffer_green[w_VBufferIndexA][w_HPosA] <= i_GreenA;
		line_buffer_blue[w_VBufferIndexA][w_HPosA] <= i_BlueA;
	end;
						
	w_HTriggerA_latched <= w_HTriggerA;
	w_VTriggerA_latched <= w_VTriggerA;
end

always @(negedge i_HSyncB) begin
	if (i_Rst) begin
		w_VSyncB_Delay <= {C_VERTICAL_SYNC_DELAY{1'b1}};
		w_VBlankB_Delay <= 0;
	end else begin
		w_VSyncB_Delay = w_VSyncB_Delay << 1;//[C_LINE_BUFFER_COUNT-1:1] = w_VSyncB_Delay[C_LINE_BUFFER_COUNT-2:0];
		w_VSyncB_Delay[0] = i_VSyncB;
		
		w_VBlankB_Delay = w_VBlankB_Delay << 1; //[C_LINE_BUFFER_COUNT-1:1] = w_VBlankB_Delay[C_LINE_BUFFER_COUNT-2:0];
		w_VBlankB_Delay[0] = i_VBlankB;
	end
end

always @(posedge i_ClkB) begin
	// sync'd outputs
	o_Locked <= w_LockedB;
	o_HSyncB <= w_HSyncB;
	o_VSyncB <= w_VSyncB;
	o_HBlankB <= w_HBlankB;
	o_VBlankB <= w_VBlankB;
	o_RedB <= w_RedB;
	o_GreenB <= w_GreenB;
	o_BlueB <= w_BlueB;
end

always @(negedge i_ClkB) begin
	if (i_Rst) begin
		w_HCountB <= 0;
		w_VCountB <= 0;
		w_WidthB <= 0;	
		w_HeightB <= 0;
		w_VBufferIndexB <= 0;
		hpos_delta <= 0;
		hpos_acc <= 0;
		w_HTriggerB_latched <= 0;		
		w_VTriggerB_latched <= 0;		
		
		// outputs
		w_LockedB <= 0;
		w_HSyncB <= 1;
		w_VSyncB <= 1;
		w_HBlankB <= 0;
		w_VBlankB <= 0;
		w_RedB <= 0;
		w_GreenB <= 0;
		w_BlueB <= 0;
	end else begin
		// next line ?
		if (w_HTriggerB && ~w_HTriggerB_latched) begin
			// cache active width
			w_WidthB = w_HCountB + 1;
			
			// return to start of next line
			w_HCountB = 0;
			
			// reset line accumulator
			hpos_acc = 0;
			
			// calculate scaling factor
			if (w_WidthA != 0) hpos_delta = (delta_width * w_WidthA) / w_WidthB;
			
			// increment active line
			if (w_VActiveB) begin
				w_VCountB = w_VCountB + 1;
				
				// increment line accumulator
				vpos_acc = vpos_acc + vpos_delta;
				
				// next line in the buffer
				w_VBufferIndexB = (w_SoFVBufferIndexB + vpos_acc[C_DELTA_HEIGHT_PRECISION+9:C_DELTA_HEIGHT_PRECISION]) % C_LINE_BUFFER_COUNT;
			end
		end else if (w_HActiveB) begin
			// next pixel
			w_HCountB = w_HCountB + 1;
			
			// increment pixel position accumulator
			hpos_acc <= hpos_acc + hpos_delta;
		end
	end
	
	// next frame?
	if (w_VTriggerB && ~w_VTriggerB_latched) begin
		// cache active height
		w_HeightB = w_VCountB;
	
		// return to start of next frame
		w_VCountB = 0;
		
		// calculate scaling factor
		if (w_HeightA != 0) vpos_delta <= (delta_height * w_HeightA) / w_HeightB;
		
		// reset line accumulator 
		vpos_acc = 0;
		
		w_SoFVBufferIndexB = w_SoFVBufferIndexA;
		w_VBufferIndexB = w_SoFVBufferIndexA;
		
		w_LockedB <= 1;
	end
			
	if (w_VActiveB && w_HActiveB) begin
		w_RedB <= line_buffer_red[w_VBufferIndexB][w_HPosB];
		w_GreenB <= line_buffer_green[w_VBufferIndexB][w_HPosB];
		w_BlueB <= line_buffer_blue[w_VBufferIndexB][w_HPosB];
	end else begin
		w_RedB <= 0;
		w_GreenB <= 0;
		w_BlueB <= 0;
	end
	
	w_HSyncB <= i_HSyncB;
	w_VSyncB <= w_VSyncB_Delay[C_VERTICAL_SYNC_DELAY-1];
	w_HBlankB <= i_HBlankB;
	w_VBlankB <= w_VBlankB_Delay[C_VERTICAL_SYNC_DELAY-1];
		
	w_HTriggerB_latched <= w_HTriggerB;
	w_VTriggerB_latched <= w_VTriggerB;
end





endmodule
