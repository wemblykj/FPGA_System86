module Upscaler
#
(
	parameter C_COMPONENT_DEPTH = 8,
	parameter C_USE_BLANKING_A = 0,
	parameter C_USE_BLANKING_B = 0,
	parameter C_LINE_BUFFER_SIZE = 1024,
	parameter C_LINE_BUFFER_COUNT = 3,
	parameter C_VERTICAL_SYNC_DELAY = 2,
	parameter C_DELTA_WIDTH_PRECISION = 12,
	parameter C_DELTA_HEIGHT_PRECISION = 12
)
(
	input wire i_Rst,
	
	// input timings
	input wire i_ClkA,
	input wire i_HSyncA,
	input wire i_VSyncA,
	input wire i_HBlankA,
	input wire i_VBlankA,
	
	// input data
	input wire [C_COMPONENT_DEPTH-1:0] i_RedA,
	input wire [C_COMPONENT_DEPTH-1:0] i_GreenA,
	input wire [C_COMPONENT_DEPTH-1:0] i_BlueA,
	
	// output reference timings
	input wire i_ClkB,
	input wire i_HSyncB,
	input wire i_VSyncB,
	input wire i_HBlankB,
	input wire i_VBlankB,
	
	// output stability
	output reg o_Locked,
	
	// output timings
	output reg o_HSyncB,
	output reg o_VSyncB,
	output reg o_HBlankB,
	output reg o_VBlankB,
	
	// output data
	output reg [C_COMPONENT_DEPTH-1:0] o_RedB,
	output reg [C_COMPONENT_DEPTH-1:0] o_GreenB,
	output reg [C_COMPONENT_DEPTH-1:0] o_BlueB
);

//
// line buffers
reg [C_COMPONENT_DEPTH-1:0] line_buffer_red[0:C_LINE_BUFFER_COUNT-1][0:C_LINE_BUFFER_SIZE-1];
reg [C_COMPONENT_DEPTH-1:0] line_buffer_green[0:C_LINE_BUFFER_COUNT-1][0:C_LINE_BUFFER_SIZE-1];
reg [C_COMPONENT_DEPTH-1:0] line_buffer_blue[0:C_LINE_BUFFER_COUNT-1][0:C_LINE_BUFFER_SIZE-1];

//
// input processing
//

// horizontal
reg [10:0] w_A_HActivePixelCount = 0;
reg [10:0] w_A_HActiveWidth = 0;
wire [10:0] w_A_HBufferPixelIndex;
wire w_A_HActivePixelTrigger;					// start of active active pixel trigger
wire w_A_HActivePixel;									// active video (horizontal)

reg w_A_HActivePixelTrigger_latched = 0;

// vertical
reg [10:0] w_A_VActiveLineCount = 0;
reg [10:0] w_A_VActiveHeight = 0;
reg [4:0] w_A_VBufferLineIndex = 0;
reg [4:0] w_A_VSoFBufferIndex = 0;
wire w_A_VActiveLineTrigger;									// start of active active line trigger
wire w_A_VActiveLine;									// active video (vertical)

reg w_A_VActiveLineTrigger_latched = 0;

assign w_A_HBufferPixelIndex = w_A_HActivePixelCount;		// map write position to active pixel counter

//
// output processing
//

// horizontal
reg [10:0] w_B_HActivePixelCount = 0;
reg [10:0] w_B_HActiveWidth = 0;
wire [10:0] w_B_HBufferPixelIndex;
reg [C_DELTA_WIDTH_PRECISION+9:0] w_B_HPixelPosAccumulator = 0;
reg [C_DELTA_WIDTH_PRECISION:0] w_B_HPixelPosDelta = 0;
// vertical
reg [10:0] w_B_VActiveLineCount = 0;
reg [10:0] w_B_VActiveHeight = 0;
reg [C_DELTA_HEIGHT_PRECISION+9:0] w_B_VLinePosAccumulator = 0;
reg [C_DELTA_HEIGHT_PRECISION:0] w_B_VLinePosDelta = 0;
reg [4:0] w_B_VBufferLineIndex;
reg [4:0] w_B_VSoFBufferLineIndex = 0;

assign w_B_HBufferPixelIndex = w_B_HPixelPosAccumulator[C_DELTA_WIDTH_PRECISION+9:C_DELTA_WIDTH_PRECISION];

wire w_B_HActivePixelTrigger;	
wire w_B_VActiveLineTrigger;
wire w_B_HActivePixelB;	
wire w_B_VActiveLine;	

reg w_B_HActivePixelTrigger_latched = 0;
reg w_B_VActiveLineTrigger_latched = 0;

reg w_B_FrameLocked = 0;
reg w_B_HSync = 1;
reg w_B_VSync = 1;
reg w_B_HBlank = 0;
reg w_B_VBlank = 0;
reg [C_VERTICAL_SYNC_DELAY-1:0] w_B_VSync_delay = {C_VERTICAL_SYNC_DELAY{1'b1}};
reg [C_VERTICAL_SYNC_DELAY-1:0] w_B_VBlank_delay = 0;

reg [C_COMPONENT_DEPTH-1:0] w_B_Red = 0;
reg [C_COMPONENT_DEPTH-1:0] w_B_Green = 0;
reg [C_COMPONENT_DEPTH-1:0] w_B_Blue = 0;

generate
	if (C_USE_BLANKING_A == 1) begin
		assign w_A_HActivePixelTrigger = ~i_HBlankA;
		assign w_A_VActiveLineTrigger = ~i_VBlankA;
		assign w_A_HActivePixel = ~i_HBlankA;
		assign w_A_VActiveLine = ~i_VBlankA;
	end else begin
		assign w_A_HActivePixelTrigger = ~i_HSyncA;
		assign w_A_VActiveLineTrigger = ~i_VSyncA;
		assign w_A_HActivePixel = 1;
		assign w_A_VActiveLine = 1;
	end

	if (C_USE_BLANKING_B == 1) begin
		assign w_B_HActivePixelTrigger = ~i_HBlankB;
		assign w_B_VActiveLineTrigger = ~w_B_VBlank_delay[C_VERTICAL_SYNC_DELAY-1];
		assign w_B_HActivePixelB = ~i_HBlankB;
		assign w_B_VActiveLine = ~w_B_VBlank_delay[C_VERTICAL_SYNC_DELAY-1];
	end else begin
		assign w_B_HActivePixelTrigger = ~i_HSyncB;
		assign w_B_VActiveLineTrigger = ~w_B_VSync_delay[C_VERTICAL_SYNC_DELAY-1];
		assign w_B_HActivePixelB = 1;
		assign w_B_VActiveLine = 1;
	end
endgenerate

localparam delta_width = (1 << C_DELTA_WIDTH_PRECISION);
localparam delta_height = (1 << C_DELTA_HEIGHT_PRECISION);

always @(negedge i_ClkA) begin
	if (i_Rst) begin
		w_A_HActivePixelCount <= 0;
		w_A_VActiveLineCount <= 0;
		w_A_HActiveWidth <= 0;	
		w_A_VActiveHeight <= 0;
		w_A_VBufferLineIndex <= 0;
		w_A_VSoFBufferIndex <= 0;
		w_A_HActivePixelTrigger_latched <= 0;		
		w_A_VActiveLineTrigger_latched <= 0;		
	end else begin
		// next line ?
		if (w_A_HActivePixelTrigger && ~w_A_HActivePixelTrigger_latched) begin
			// cache active width
			w_A_HActiveWidth = w_A_HActivePixelCount + 1;
			
			// return to start of next line
			w_A_HActivePixelCount = 0;
			
			// increment active line
			if (w_A_VActiveLine) begin
				w_A_VActiveLineCount = w_A_VActiveLineCount + 1;
				
				// next line in the buffer
				w_A_VBufferLineIndex = (w_A_VBufferLineIndex + 1) % C_LINE_BUFFER_COUNT;
			end
		end else if (w_A_HActivePixel) begin
			// next pixel
			w_A_HActivePixelCount = w_A_HActivePixelCount + 1;
		end
	end
	
	// next frame?
	if (w_A_VActiveLineTrigger && ~w_A_VActiveLineTrigger_latched) begin
		// cache active height
		w_A_VActiveHeight = w_A_VActiveLineCount;
	
		// return to start of next frame
		w_A_VActiveLineCount = 0;
		
		w_A_VSoFBufferIndex = w_A_VBufferLineIndex;
	end
	
	// buffer active video data
	if (w_A_VActiveLine && w_A_HActivePixel) begin
		line_buffer_red[w_A_VBufferLineIndex][w_A_HBufferPixelIndex] <= i_RedA;
		line_buffer_green[w_A_VBufferLineIndex][w_A_HBufferPixelIndex] <= i_GreenA;
		line_buffer_blue[w_A_VBufferLineIndex][w_A_HBufferPixelIndex] <= i_BlueA;
	end;
						
	// update latches
	w_A_HActivePixelTrigger_latched <= w_A_HActivePixelTrigger;
	w_A_VActiveLineTrigger_latched <= w_A_VActiveLineTrigger;
end

always @(negedge i_HSyncB) begin
	if (i_Rst) begin
		w_B_VSync_delay <= {C_VERTICAL_SYNC_DELAY{1'b1}};
		w_B_VBlank_delay <= 0;
	end else begin
		w_B_VSync_delay = w_B_VSync_delay << 1;
		w_B_VSync_delay[0] = i_VSyncB;
		
		w_B_VBlank_delay = w_B_VBlank_delay << 1;
		w_B_VBlank_delay[0] = i_VBlankB;
	end
end

always @(posedge i_ClkB) begin
	// sync'd outputs
	o_Locked <= w_B_FrameLocked;
	o_HSyncB <= w_B_HSync;
	o_VSyncB <= w_B_VSync;
	o_HBlankB <= w_B_HBlank;
	o_VBlankB <= w_B_VBlank;
	o_RedB <= w_B_Red;
	o_GreenB <= w_B_Green;
	o_BlueB <= w_B_Blue;
end

always @(negedge i_ClkB) begin
	if (i_Rst) begin
		w_B_HActivePixelCount <= 0;
		w_B_VActiveLineCount <= 0;
		w_B_HActiveWidth <= 0;	
		w_B_VActiveHeight <= 0;
		w_B_VBufferLineIndex <= 0;
		w_B_HPixelPosDelta <= 0;
		w_B_HPixelPosAccumulator <= 0;
		w_B_HActivePixelTrigger_latched <= 0;		
		w_B_VActiveLineTrigger_latched <= 0;		
		
		// outputs
		w_B_FrameLocked <= 0;
		w_B_HSync <= 1;
		w_B_VSync <= 1;
		w_B_HBlank <= 0;
		w_B_VBlank <= 0;
		w_B_Red <= 0;
		w_B_Green <= 0;
		w_B_Blue <= 0;
	end else begin
		// next line ?
		if (w_B_HActivePixelTrigger && ~w_B_HActivePixelTrigger_latched) begin
			// cache active width
			w_B_HActiveWidth = w_B_HActivePixelCount + 1;
			
			// return to start of next line
			w_B_HActivePixelCount = 0;
			
			// reset line accumulator
			w_B_HPixelPosAccumulator = 0;
			
			// calculate scaling factor
			if (w_A_HActiveWidth != 0) w_B_HPixelPosDelta = (delta_width * w_A_HActiveWidth) / w_B_HActiveWidth;
			
			// increment active line
			if (w_B_VActiveLine) begin
				w_B_VActiveLineCount = w_B_VActiveLineCount + 1;
				
				// increment line accumulator
				w_B_VLinePosAccumulator = w_B_VLinePosAccumulator + w_B_VLinePosDelta;
				
				// next line in the buffer
				w_B_VBufferLineIndex = (w_B_VSoFBufferLineIndex + w_B_VLinePosAccumulator[C_DELTA_HEIGHT_PRECISION+9:C_DELTA_HEIGHT_PRECISION]) % C_LINE_BUFFER_COUNT;
			end
		end else if (w_B_HActivePixelB) begin
			// next pixel
			w_B_HActivePixelCount = w_B_HActivePixelCount + 1;
			
			// increment pixel position accumulator
			w_B_HPixelPosAccumulator <= w_B_HPixelPosAccumulator + w_B_HPixelPosDelta;
		end
	end
	
	// next frame?
	if (w_B_VActiveLineTrigger && ~w_B_VActiveLineTrigger_latched) begin
		// cache active height
		w_B_VActiveHeight = w_B_VActiveLineCount;
	
		// return to start of next frame
		w_B_VActiveLineCount = 0;
		
		// reset line accumulator 
		w_B_VLinePosAccumulator = 0;
		
		w_B_VSoFBufferLineIndex = w_A_VSoFBufferIndex;
		w_B_VBufferLineIndex = w_A_VSoFBufferIndex;
		
		// calculate vertical scaling factor
		if (w_A_VActiveHeight != 0) begin
			w_B_VLinePosDelta <= (delta_height * w_A_VActiveHeight) / w_B_VActiveHeight;
			w_B_FrameLocked <= 1;
		end
	end
			
	// assign output data
	if (w_B_VActiveLine && w_B_HActivePixelB) begin
		// map active input data to active output data
		w_B_Red <= line_buffer_red[w_B_VBufferLineIndex][w_B_HBufferPixelIndex];
		w_B_Green <= line_buffer_green[w_B_VBufferLineIndex][w_B_HBufferPixelIndex];
		w_B_Blue <= line_buffer_blue[w_B_VBufferLineIndex][w_B_HBufferPixelIndex];
	end else begin
		w_B_Red <= 0;
		w_B_Green <= 0;
		w_B_Blue <= 0;
	end
	
	// assign output timings
	w_B_HSync <= i_HSyncB;
	w_B_VSync <= w_B_VSync_delay[C_VERTICAL_SYNC_DELAY-1];
	w_B_HBlank <= i_HBlankB;
	w_B_VBlank <= w_B_VBlank_delay[C_VERTICAL_SYNC_DELAY-1];
		
	// update latches
	w_B_HActivePixelTrigger_latched <= w_B_HActivePixelTrigger;
	w_B_VActiveLineTrigger_latched <= w_B_VActiveLineTrigger;
end

endmodule
