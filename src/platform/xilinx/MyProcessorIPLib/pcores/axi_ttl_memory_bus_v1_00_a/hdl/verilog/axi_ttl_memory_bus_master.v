module axi_ttl_memory_bus_master #(
        parameter C_ADDR_WIDTH = 16,
        parameter C_DATA_WIDTH = 8,
        parameter C_MST_AWIDTH = 32,
        parameter C_MST_DWIDTH = 32)
       (input wire rst_n,
        input wire 				nChipEnable,
        input wire 				nOutputEnable,
        input wire 				nWriteEnable,
        
        input wire [C_ADDR_WIDTH-1:0] 	 	Address,
        inout wire [C_DATA_WIDTH-1:0] 	 	Data,
        input wire [C_MST_AWIDTH-1:0] 	MappedAddress,
        
		  output wire Interrupt,
      
      output wire [C_MST_DWIDTH-1:0] 	BusAddressReadReg,
		  input wire [C_MST_DWIDTH-1:0] 	BusAddressWriteReg,
      
		  output wire [C_MST_DWIDTH-1:0] 	BusDataReadReg,
		  input wire [C_MST_DWIDTH-1:0] 	BusDataWriteReg,
      
		  input wire [C_MST_DWIDTH-1:0] 	IntrEnableReg,
		  output wire [C_MST_DWIDTH-1:0] 	IntrStatusReg,
      input wire [C_MST_DWIDTH-1:0] 	IntrAckReg,
      
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

localparam IntrEnableMask_Address = 4'b0001;
localparam IntrEnableMask_Read = 4'b0010;
localparam IntrEnableMask_Write = 4'b0100;

localparam
  Reset = 5'b00000,
	Idle = 5'b00001,
	BusAddressReq = 5'b00010,
  AddressIntrReq = 5'b00011,
  AddressIntrResp = 5'b00100,
	MstAddressReq = 5'b00101,
	BusReq = 5'b00110,
  BusReadReq = 5'b00111,
  BusReadResp = 5'b01000,
	MstReadReq = 5'b01001,
  MstReadResp = 5'b01010,
  ReadIntrReq = 5'b01011,
  ReadIntrAck = 5'b01100,
  BusWriteReq = 5'b01101,
  BusWriteResp = 5'b01110,
	MstWriteReq = 5'b01111,
  MstWriteResp = 5'b10000,
  WriteIntrReq = 5'b10001,
  WriteIntrAck = 5'b10010;

reg[4:0] state_reg, state_next;

reg [C_ADDR_WIDTH-1:0] busAddress;
reg [C_DATA_WIDTH-1:0] busData;
reg [C_DATA_WIDTH-1:0] readData;

reg [C_MST_AWIDTH-1:0] mstAddress;
reg [C_MST_DWIDTH-1:0] mstData;

reg readRequest;
reg writeRequest;
reg intrStatus;

always @(state_next, rst_n) begin
	if (!rst_n) begin
		state_reg <= Reset;
	end else begin
		state_reg <= state_next;
	end
end

always @(state_reg, nChipEnable, nOutputEnable, nWriteEnable) begin
	state_next <= state_reg;
	
	case(state_reg)
    Reset:
      begin
        writeRequest <= 0;
        readRequest <= 0;
        busAddress <= 0;
        busData <= 0;
        
        // Assume that we should process the pending address once we come out of reset
        if (!nChipEnable)
            state_next <= BusAddressReq;
          else 
            state_next <= Idle;
      end
      
		Idle:
      if (!nChipEnable)
				if (busAddress !== Address)
					state_next <= BusAddressReq;
					
		BusAddressReq: 
      begin
        busAddress <= Address;
        if (!nChipEnable)
          if (IntrEnableReg & IntrEnableMask_Address)
            state_next <= AddressIntrReq;
          else
            state_next <= MstAddressReq;
        else 
          state_next <= Idle;
      end
		
    AddressIntrReq: 
      begin
        // TODO: Await pending interrupts to finish
        if ((IntrAckReg & IntrEnableMask_Address) == 0) begin
          // TODO: Raise address interrupt
          intrStatus <= IntrStatusReg | IntrEnableMask_Address;
          
          state_next <= AddressIntrResp;
        end
      end

    AddressIntrResp: 
      begin
        // TODO: Await address interrupt acknowledge
        if ((IntrAckReg & IntrEnableMask_Address) == 0) begin
          // not sure if this if going to work without some thought
          busAddress <= BusAddressWriteReg;
        
          // TODO: Clear interrupt status
          intrStatus <= IntrStatusReg & ~IntrEnableMask_Address;
          
          state_next <= MstAddressReq;
        end
      end
      
		MstAddressReq:
			if (!nChipEnable) begin
				mstAddress <= MappedAddress + busAddress;
				state_next <= BusReq;
			end else
				state_next <= Idle;
				
		BusReq:
			if (!nChipEnable) begin
        // Await for operation if not already set 
        // in the meantime handle any change in address
				if (busAddress !== Address)
          // address has changed, restart
					state_next <= BusAddressReq;
				if (nWriteEnable) begin
          // A write operation was requested
					state_next <= BusWriteReq;
				end else if (nOutputEnable) begin
          // A read operation was requested
          state_next <= BusReadReq;
				end
			end else
				state_next <= Idle;
					
    BusReadReq:
      if (!nChipEnable)
        state_next <= MstReadReq;
      else
		  state_next <= Idle;
        
	 MstReadReq:
	   if (!bus2ip_mstwr_dst_rdy_n) begin
        readRequest <= 1;
        state_next <= MstReadResp;
      end
        
    MstReadResp:
		if (bus2ip_mst_cmdack) begin			// request has been put on AXI bus
			// TODO: Handle errors
			if (bus2ip_mst_cmplt) begin			// request has completed
			 readRequest <= 0;
			 
			 // Store read data in bus data register
			 // TODO: byte strobing 
			 busData <= bus2ip_mstrd_d;
			 
        if (IntrEnableReg & IntrEnableMask_Read)
          state_next <= ReadIntrReq;
        else
          state_next <= BusReadResp;
			end
		end
        
    ReadIntrReq:
      begin
        // TODO: wait on pending interrupts
        if ((IntrAckReg & IntrEnableMask_Read) == 0) begin
          // TODO: raise read interrupt request
          intrStatus <= IntrStatusReg | IntrEnableMask_Read;
          
          state_next <= ReadIntrAck;
        end
      end
        
    ReadIntrAck:
      begin
        // TODO: wait on read req interrupt acknowledge
        if ((IntrAckReg & IntrEnableMask_Read) == 0) begin
          // not sure if this if going to work without some thought
          busData <= BusDataWriteReg;
          
          // TODO: Clear interrupt status
          intrStatus <= IntrStatusReg & ~IntrEnableMask_Read;
          
          state_next <= BusReadResp;
        end
      end
    
    BusReadResp:
      begin
        // Update read data from bus data register
        readData <= busData; 

        state_next <= Idle;
      end
    
    BusWriteReq:
      if (!nChipEnable) begin
				// TODO: wait on pending interrupts
        
        // Put data to write in bus data register
        // TODO: byte strobing
        busData <= Data;
        
        if (IntrEnableReg & IntrEnableMask_Write)
          state_next <= WriteIntrReq;
        else
          state_next <= MstWriteReq;
        
			end else
				state_next <= Idle;
        
		WriteIntrReq:
      begin
        // TODO: wait on pending interrupts
        if ((IntrAckReg & IntrEnableMask_Write) == 0) begin
          // TODO: raise write interrupt request
          intrStatus <= IntrStatusReg | IntrEnableMask_Write;
          
          state_next <= WriteIntrAck;
        end
			end
        
    WriteIntrAck:
      begin
        // TODO: wait on write req interrupt acknowledge
        if (IntrAckReg & IntrEnableMask_Write) begin
          // not sure if this if going to work without some thought
          busData <= BusDataWriteReg;
        
          // TODO: Clear write interrupt status
          intrStatus <= IntrStatusReg & ~IntrEnableMask_Write;
          
          state_next <= MstWriteReq;
        end
      end
        
    MstWriteReq:
      if (!bus2ip_mstwr_dst_rdy_n) begin
          writeRequest <= 1;
          state_next <= MstWriteResp;
      end
        
    MstWriteResp:
	   if (bus2ip_mst_cmdack) begin		// request has been put on AXI bus
		  // TODO: Handle errors
		  if (bus2ip_mst_cmplt) begin		// request has completed
			 writeRequest <= 0;
			 state_next <= BusWriteResp;
		  end
		end
		   
    BusWriteResp:
      begin
        // update the read data with the data just written
        readData <= busData;
				state_next <= Idle;
      end
        
	endcase
end
	
  //assign ip2bus_mst_reset = rst;
  assign ip2bus_mst_addr = mstAddress;
  assign ip2bus_mstwr_req = writeRequest;
  assign ip2bus_mstwr_d = mstData;
  
  assign BusAddressReadReg = busAddress;
  assign BusDataReadReg = busData;
  
  assign IntrStatusReg = intrStatus;
  
  assign Data = nWriteEnable ? (nOutputEnable ? {C_DATA_WIDTH{1'bx}} : readData) : {C_DATA_WIDTH{1'bz}};
  
endmodule

