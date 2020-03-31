module Upscaler
#
(
	parameter COMPONENT_DEPTH = 8,
	parameter USE_BLANKING_A = 0,
	parameter USE_BLANKING_B = 0,
	parameter LINE_BUFFER_SIZE = 1024,
	parameter LINE_BUFFER_COUNT = 12,
	parameter VERTICAL_SYNC_DELAY = 2,
	parameter SCALE_PRECISION_WIDTH = 6,
	parameter SCALE_PRECISION_HEIGHT = 6,
	parameter HORIZONTAL_COUNTER_DEPTH_A = 12,
	parameter VERTICAL_COUNTER_DEPTH_A = 12,
	parameter HORIZONTAL_COUNTER_DEPTH_B = 12,
	parameter VERTICAL_COUNTER_DEPTH_B = 12
)
(
	input wire i_Rst,
	
	// input timings
	input wire i_ClkA,
	input wire i_nHSyncA,
	input wire i_nVSyncA,
	input wire i_HBlankA,
	input wire i_VBlankA,
	
	// input data
	input wire [COMPONENT_DEPTH-1:0] i_RedA,
	input wire [COMPONENT_DEPTH-1:0] i_GreenA,
	input wire [COMPONENT_DEPTH-1:0] i_BlueA,
	
	// output reference timings
	input wire i_ClkB,
	input wire i_nHSyncB,
	input wire i_nVSyncB,
	input wire i_HBlankB,
	input wire i_VBlankB,
	
	// output lock stats
	output wire o_LockedA,
	output reg [HORIZONTAL_COUNTER_DEPTH_A-1:0] o_WidthA,
	output reg [VERTICAL_COUNTER_DEPTH_A-1:0] o_HeightA,
	output wire o_LockedB,
	output reg [HORIZONTAL_COUNTER_DEPTH_B-1:0] o_WidthB,
	output reg [VERTICAL_COUNTER_DEPTH_B-1:0] o_HeightB,
	
	// output timings
	output reg o_nHSyncB,
	output reg o_nVSyncB,
	output reg o_HBlankB,
	output reg o_VBlankB,
	
	// output data
	output reg [COMPONENT_DEPTH-1:0] o_RedB,
	output reg [COMPONENT_DEPTH-1:0] o_GreenB,
	output reg [COMPONENT_DEPTH-1:0] o_BlueB
);

//
// line buffers
reg [COMPONENT_DEPTH-1:0] line_buffer_red[0:LINE_BUFFER_COUNT-1][0:LINE_BUFFER_SIZE-1];
reg [COMPONENT_DEPTH-1:0] line_buffer_green[0:LINE_BUFFER_COUNT-1][0:LINE_BUFFER_SIZE-1];
reg [COMPONENT_DEPTH-1:0] line_buffer_blue[0:LINE_BUFFER_COUNT-1][0:LINE_BUFFER_SIZE-1];

//
// input processing
//

// horizontal
reg [HORIZONTAL_COUNTER_DEPTH_A-1:0] w_A_HActivePixelCount = 0;
reg [HORIZONTAL_COUNTER_DEPTH_A-1:0] w_A_HActiveWidth = 0;
wire [HORIZONTAL_COUNTER_DEPTH_A-1:0] w_A_HBufferPixelIndex;
wire w_A_HActivePixelTrigger;					// start of active active pixel trigger
wire w_A_HActivePixel;									// active video (horizontal)

reg w_A_HActivePixelTrigger_latched = 0;

// vertical
reg [VERTICAL_COUNTER_DEPTH_A-1:0] w_A_VActiveLineCount = 0;
reg [VERTICAL_COUNTER_DEPTH_A-1:0] w_A_VActiveHeight = 0;
reg [4:0] w_A_VBufferLineIndex = 0;
reg [4:0] w_A_VSoFBufferIndex = 0;
wire w_A_VActiveLineTrigger;									// start of active active line trigger
wire w_A_VActiveLine;									// active video (vertical)
reg w_A_FrameLocked = 0;
reg w_A_FrameLocked_alpha = 0;

reg w_A_VActiveLineTrigger_latched = 0;

assign w_A_HBufferPixelIndex = w_A_HActivePixelCount % LINE_BUFFER_SIZE;		// map write position to active pixel counter
assign o_LockedA = w_A_FrameLocked;

//
// output processing
//

// horizontal
reg [HORIZONTAL_COUNTER_DEPTH_B-1:0] w_B_HActivePixelCount = 0;
reg [HORIZONTAL_COUNTER_DEPTH_B-1:0] w_B_HActiveWidth = 0;
wire [HORIZONTAL_COUNTER_DEPTH_B-1:0] w_B_HBufferPixelIndex;
reg [HORIZONTAL_COUNTER_DEPTH_B+SCALE_PRECISION_WIDTH-1:0] w_B_HPixelPosAccumulator = 0;
reg [SCALE_PRECISION_WIDTH:0] w_B_HPixelPosDelta = 0;
// vertical
reg [VERTICAL_COUNTER_DEPTH_B-1:0] w_B_VActiveLineCount = 0;
reg [VERTICAL_COUNTER_DEPTH_B-1:0] w_B_VActiveHeight = 0;
reg [VERTICAL_COUNTER_DEPTH_B+SCALE_PRECISION_HEIGHT-1:0] w_B_VLinePosAccumulator = 0;
reg [SCALE_PRECISION_HEIGHT:0] w_B_VLinePosDelta = 0;
reg [4:0] w_B_VBufferLineIndex;
reg [4:0] w_B_VSoFBufferLineIndex = 0;

wire w_B_HActivePixelTrigger;	
wire w_B_VActiveLineTrigger;
wire w_B_HActivePixelB;	
wire w_B_VActiveLine;	

reg w_B_HActivePixelTrigger_latched = 0;
reg w_B_VActiveLineTrigger_latched = 0;

reg w_B_FrameLocked = 0;
reg w_B_FrameLocked_alpha = 0;
reg w_B_nHSync = 1;
reg w_B_nVSync = 1;
reg w_B_HBlank = 0;
reg w_B_VBlank = 0;
reg [VERTICAL_SYNC_DELAY-1:0] w_B_nVSync_delay = {VERTICAL_SYNC_DELAY{1'b1}};
reg [VERTICAL_SYNC_DELAY-1:0] w_B_VBlank_delay = 0;

reg [COMPONENT_DEPTH-1:0] w_B_Red = 0;
reg [COMPONENT_DEPTH-1:0] w_B_Green = 0;
reg [COMPONENT_DEPTH-1:0] w_B_Blue = 0;

assign w_B_HBufferPixelIndex = (w_B_HPixelPosAccumulator[HORIZONTAL_COUNTER_DEPTH_B+SCALE_PRECISION_WIDTH-1:SCALE_PRECISION_WIDTH]) % LINE_BUFFER_SIZE;
assign o_LockedB = w_B_FrameLocked;

generate
	if (USE_BLANKING_A == 1) begin
		assign w_A_HActivePixelTrigger = ~i_nHSyncA;
		assign w_A_VActiveLineTrigger = ~i_nVSyncA;
		assign w_A_HActivePixel = ~i_HBlankA;
		assign w_A_VActiveLine = ~i_VBlankA;
	end else begin
		assign w_A_HActivePixelTrigger = ~i_nHSyncA;
		assign w_A_VActiveLineTrigger = ~i_nVSyncA;
		assign w_A_HActivePixel = 1;
		assign w_A_VActiveLine = 1;
	end

	if (USE_BLANKING_B == 1) begin
		assign w_B_HActivePixelTrigger = ~i_nHSyncB;
		assign w_B_VActiveLineTrigger = ~w_B_nVSync_delay[VERTICAL_SYNC_DELAY-1];
		assign w_B_HActivePixelB = ~i_HBlankB;
		assign w_B_VActiveLine = ~w_B_VBlank_delay[VERTICAL_SYNC_DELAY-1];
	end else begin
		assign w_B_HActivePixelTrigger = ~i_nHSyncB;
		assign w_B_VActiveLineTrigger = ~w_B_nVSync_delay[VERTICAL_SYNC_DELAY-1];
		assign w_B_HActivePixelB = 1;
		assign w_B_VActiveLine = 1;
	end
endgenerate

localparam delta_width = (1 << SCALE_PRECISION_WIDTH);
localparam delta_height = (1 << SCALE_PRECISION_HEIGHT);

always @(negedge i_ClkA) begin
	if (i_Rst) begin
		w_A_HActivePixelCount <= 0;
		w_A_VActiveLineCount <= 0;
		w_A_HActiveWidth <= 0;	
		w_A_VActiveHeight <= 0;
		w_A_VBufferLineIndex <= 0;
		w_A_VSoFBufferIndex <= 0;
		w_A_FrameLocked_alpha <= 0;
		w_A_FrameLocked <= 0;
		w_A_HActivePixelTrigger_latched <= 0;		
		w_A_VActiveLineTrigger_latched <= 0;	
			
	end else begin
		// next line ?
		if (w_A_HActivePixelTrigger && ~w_A_HActivePixelTrigger_latched) begin
			// cache active width
			w_A_HActiveWidth = w_A_HActivePixelCount;// + 1;
			
			// return to start of next line
			w_A_HActivePixelCount = 0;
			
			// increment active line
			if (w_A_VActiveLine) begin
				w_A_VActiveLineCount = w_A_VActiveLineCount + 1;
				
				// next line in the buffer
				w_A_VBufferLineIndex = (w_A_VBufferLineIndex + 1) % LINE_BUFFER_COUNT;
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
		
		if (~w_A_FrameLocked) begin
			if (w_A_FrameLocked_alpha) begin
				o_WidthA = w_A_HActiveWidth;
				o_HeightA = w_A_VActiveHeight;
				
				w_A_FrameLocked <= 1;
			end
			
			w_A_FrameLocked_alpha <= 1;
		end
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

always @(negedge i_nHSyncB) begin
	if (i_Rst) begin
		w_B_nVSync_delay <= {VERTICAL_SYNC_DELAY{1'b1}};
		w_B_VBlank_delay <= 0;
	end else begin
		w_B_nVSync_delay = w_B_nVSync_delay << 1;
		w_B_nVSync_delay[0] = i_nVSyncB;
		
		w_B_VBlank_delay = w_B_VBlank_delay << 1;
		w_B_VBlank_delay[0] = i_VBlankB;
	end
end

always @(posedge i_ClkB) begin
	// sync'd outputs
	/*o_LockedA <= w_A_FrameLocked;
	o_WidthA <= w_A_HActiveWidth;
	o_HeightA <= w_A_VActiveHeight;
	o_LockedB <= w_B_FrameLocked;
	o_WidthB <= w_B_HActiveWidth;
	o_HeightB <= w_B_VActiveHeight;*/
	o_nHSyncB <= w_B_nHSync;
	o_nVSyncB <= w_B_nVSync;
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
		w_B_FrameLocked_alpha <= 0;
		w_B_nHSync <= 1;
		w_B_nVSync <= 1;
		w_B_HBlank <= 0;
		w_B_VBlank <= 0;
		w_B_Red <= 0;
		w_B_Green <= 0;
		w_B_Blue <= 0;
	end else begin
		// next line ?
		if (w_B_HActivePixelTrigger && ~w_B_HActivePixelTrigger_latched) begin
			// cache active width
			w_B_HActiveWidth = w_B_HActivePixelCount;// + 1;
			
			// return to start of next line
			w_B_HActivePixelCount = 0;
			
			// reset line accumulator
			w_B_HPixelPosAccumulator = 0;
			
			// calculate scaling factor
			if (w_A_FrameLocked) w_B_HPixelPosDelta = (delta_width * w_A_HActiveWidth) / w_B_HActiveWidth;
			
			// increment active line
			if (w_B_VActiveLine) begin
				w_B_VActiveLineCount = w_B_VActiveLineCount + 1;
				
				// increment line accumulator
				w_B_VLinePosAccumulator = w_B_VLinePosAccumulator + w_B_VLinePosDelta;
				
				// next line in the buffer
				w_B_VBufferLineIndex = (w_B_VSoFBufferLineIndex + w_B_VLinePosAccumulator[SCALE_PRECISION_HEIGHT+9:SCALE_PRECISION_HEIGHT]) % LINE_BUFFER_COUNT;
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
		if (~w_B_FrameLocked) begin
			if (w_A_FrameLocked && w_B_FrameLocked_alpha) begin
				w_B_VLinePosDelta <= (delta_height * w_A_VActiveHeight) / w_B_VActiveHeight;
			
				o_WidthB <= w_B_HActiveWidth;
				o_HeightB <= w_B_VActiveHeight;
				
				w_B_FrameLocked <= 1;
			end
			
			w_B_FrameLocked_alpha <= 1;
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
	w_B_nHSync <= i_nHSyncB;
	w_B_nVSync <= w_B_nVSync_delay[VERTICAL_SYNC_DELAY-1];
	w_B_HBlank <= i_HBlankB;
	w_B_VBlank <= w_B_VBlank_delay[VERTICAL_SYNC_DELAY-1];
		
	// update latches
	w_B_HActivePixelTrigger_latched <= w_B_HActivePixelTrigger;
	w_B_VActiveLineTrigger_latched <= w_B_VActiveLineTrigger;
	
	// pre-frame stats
	//o_LockedA <= w_A_FrameLocked;
	//o_WidthA <= w_A_HActiveWidth;
	//o_HeightA <= w_A_VActiveHeight;
	//o_LockedB <= w_B_FrameLocked;
	//o_WidthB <= w_B_HActiveWidth;
	//o_HeightB <= w_B_VActiveHeight;
end

endmodule
