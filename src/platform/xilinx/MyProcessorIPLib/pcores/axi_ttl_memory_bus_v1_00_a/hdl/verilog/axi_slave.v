module axi_slave #(parameter C_REGISTER_COUNT = 1,
				   parameter C_S_AXI_ADDR_WIDTH = 32,
                  parameter C_S_AXI_DATA_WIDTH = 32)
       (input wire [(C_REGISTER_COUNT*C_S_AXI_DATA_WIDTH)-1:0] packed_registers, //[0:C_REGISTER_COUNT-1],
	    input wire  										S_AXI_ACLK,
        input wire  										S_AXI_ARESETN,
        input wire [C_S_AXI_ADDR_WIDTH-1:0] 		S_AXI_ARADDR,
        input wire 										S_AXI_ARVALID,
        output wire 	 									S_AXI_ARREADY,
        output wire [C_S_AXI_DATA_WIDTH-1:0] 	S_AXI_RDATA,
		  output wire [1:0] 								S_AXI_RRESP,
        output wire 				 						S_AXI_RVALID,
        input wire 				 						S_AXI_RREADY,
		  input wire [C_S_AXI_ADDR_WIDTH-1:0] 		S_AXI_AWADDR,
        input wire 										S_AXI_AWVALID,
        output wire 	 									S_AXI_AWREADY,
        input wire [C_S_AXI_DATA_WIDTH-1:0] 		S_AXI_WDATA,
        input wire 				 						S_AXI_WVALID,
        output wire 				 						S_AXI_WREADY,
		  output wire [1:0] 								S_AXI_BRESP,
        output wire 				 						S_AXI_BVALID,
        input wire 				 						S_AXI_BREADY);

reg [C_S_AXI_DATA_WIDTH:0] registers [0:C_REGISTER_COUNT-1];
genvar i;
for (i=0;i<C_REGISTER_COUNT;i=i+1) 
  assign packed_registers[C_S_AXI_DATA_WIDTH*i+(C_S_AXI_DATA_WIDTH-1):C_S_AXI_DATA_WIDTH*i] = registers[i];

localparam [1:0]
	Idle = 2'b00,
	Read = 2'b01,
	Write = 2'b10,
	Resp = 2'b11;

reg [1:0] state_next;
reg [1:0] state;

reg rd_done;
reg wr_done;

reg [1:0] s_axi_bresp_i;
reg [1:0] s_axi_rresp_i;
reg s_axi_rdata_i;

reg s_axi_bvalid_i;
reg s_axi_rvalid_i;

// state reset
always @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin
	if (!S_AXI_ARESETN) begin
		state <= Idle;
	end else begin
		state <= state_next;
	end
end

// state transitions
always @(state) begin
	case (state)
		Idle:
			if (S_AXI_ARVALID)
				state_next <= Read;
			else if (S_AXI_AWVALID && S_AXI_WVALID)
				state_next <= Write;
			else
			   state_next <= Idle;	// effective after reset
		Read:
			if (rd_done)
				state_next <= Resp;
			//else
			//	state_next <= Read;
		Write:
			if (wr_done)
				state_next <= Resp;
		   //else
			//	state_next <= Write;
		Resp:
			if ((s_axi_bvalid_i && S_AXI_BREADY) ||
			    (s_axi_rvalid_i && S_AXI_RREADY))
				state_next <= Idle;
			//else
			//	state_next = Resp;
	endcase
end

integer j;
always @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin
  if (!S_AXI_ARESETN) begin
    for (j =  0; j < C_REGISTER_COUNT; j = j + 1) 
      registers[j] = 0;
  end else if (S_AXI_AWREADY)
    if (S_AXI_ARADDR < C_REGISTER_COUNT)
      registers[S_AXI_AWADDR] = S_AXI_WDATA;
end

always @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin
    if (!S_AXI_ARESETN) begin
      s_axi_rresp_i <= 0;
      s_axi_rdata_i <= 0;
    end else if (state == Read) begin
      if (S_AXI_ARADDR < C_REGISTER_COUNT) begin
        s_axi_rresp_i <= 1;
        s_axi_rdata_i <=  registers[S_AXI_ARADDR];
      end else begin
        s_axi_rresp_i <= 0;
        s_axi_rdata_i <=  0;
      end
   end
end

assign S_AXI_RRESP = s_axi_rresp_i;
assign S_AXI_RDATA = s_axi_rdata_i;

always @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin
	if (!S_AXI_ARESETN)
		s_axi_rvalid_i <= 0;
  else if ((state == Read) && rd_done)
    s_axi_rvalid_i <= 1;
  else if (S_AXI_RREADY)
    s_axi_rvalid_i <= 0;
end

always @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin
   if (!S_AXI_ARESETN)
		s_axi_bresp_i <= 0;
   /*else if (state == Write)
		s_axi_bresp_i <= 0<= (IP2Bus_Error) & '0';
	*/
end

always @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin
      if (!S_AXI_ARESETN)
         s_axi_bvalid_i <= 0;
      else if ((state == Write) && wr_done)
         s_axi_bvalid_i <= 1;
      else if (S_AXI_BREADY)
         s_axi_bvalid_i <= 0;
end

assign S_AXI_BVALID = s_axi_bvalid_i;
assign S_AXI_RVALID = s_axi_rvalid_i;
assign S_AXI_ARREADY = rd_done;
assign S_AXI_AWREADY = wr_done;
assign S_AXI_WREADY = wr_done;

endmodule