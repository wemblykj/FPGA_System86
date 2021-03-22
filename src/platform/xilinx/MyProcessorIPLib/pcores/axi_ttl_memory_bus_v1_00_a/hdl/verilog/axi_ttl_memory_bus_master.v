module axi_ttl_memory_bus_master #(
	parameter C_ADDR_WIDTH = 16,
        parameter C_DATA_WIDTH = 8,
		  parameter C_MST_AWIDTH = 32,
        parameter C_MST_DWIDTH = 32)
       (input wire 				nChipEnable,
        input wire 				nOutputEnable,
        input wire 				nWriteEnable,
        input wire [C_ADDR_WIDTH-1:0] 	 	Address,
        inout wire [C_DATA_WIDTH-1:0] 	 	Data,
        input wire [C_MST_AWIDTH-1:0] 	MappedAddress,
    output wire ip2bus_mstrd_req,
    output wire ip2bus_mstwr_req,
    output wire [C_MST_AWIDTH-1:0] ip2bus_mst_addr,
    output wire [(C_MST_DWIDTH/8)-1:0]ip2bus_mst_be,
    output wire ip2bus_mst_lock,
    output wire ip2bus_mst_reset,
    input wire bus2ip_mst_cmdack,
    input wire bus2ip_mst_cmplt,
    input wire bus2ip_mst_error,
    input wire bus2ip_mst_rearbitrate,
    input wire bus2ip_mst_cmd_timeout,
    input wire [C_MST_DWIDTH-1:0] bus2ip_mstrd_d,
    input wire bus2ip_mstrd_src_rdy_n,
    output wire [C_MST_DWIDTH-1:0] ip2bus_mstwr_d,
    input wire bus2ip_mstwr_dst_rdy_n
		  );

localparam
	Idle = 3'b000,
	AddressReq = 3'b001,
	AddressMap = 3'b010,
	OperationReq = 3'b011,
	ReadReq = 3'b100,
	WriteReq = 3'b101;

reg[2:0] state_reg, state_next;

reg [C_ADDR_WIDTH-1:0] busAddress;
reg [C_MST_AWIDTH-1:0] mappedAddress;

always @(state_next, posedge ip2bus_mst_reset) begin
	if (ip2bus_mst_reset) begin
		state_reg <= Idle;
	end else begin
		state_reg <= state_next;
	end
end

always @(state_reg, nChipEnable, nOutputEnable, nWriteEnable) begin
	state_next = state_reg;
	
	case(state_reg)
		Idle:
			 if (!nChipEnable)
				if (busAddress !== Address)
					state_next = AddressReq;
					
		AddressReq:
			busAddress = Address;
			// TODO: wait on interrupts
			if (!nChipEnable)
				state_next = AddressMap;
			else 
				state_next = Idle;
				
		AddressMap:
			if (!nChipEnable) begin
				mappedAddress <= MappedAddress + busAddress;
				state_next = OperationReq;
			end else
				state_next = Idle;
				
		OperationReq:
			if (!nChipEnable) begin
				if (busAddress !== Address)
					state_next = AddressReq;
				if (nWriteEnable) begin
					state_next = WriteReq;
				end else if (nOutputEnable) begin
					state_next = ReadReq;
				end
			end else
				state_next = Idle;
					
		ReadReq:
			if (!nChipEnable) begin
				// TODO: wait on interrupts
			end else
				state_next = Idle;
		WriteReq:
			if (!nChipEnable) begin
				// TODO: wait on interrupts
			end else
				state_next = Idle;
	endcase
end
	
endmodule

