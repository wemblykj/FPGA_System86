module axi_ttl_memory_bus_master #(
        parameter C_ADDR_WIDTH = 16,
        parameter C_DATA_WIDTH = 8,
        parameter C_MST_AWIDTH = 32,
        parameter C_MST_DWIDTH = 32)
       (input wire rst_n,
        input wire 				nChipEnable,
        input wire 				nOutputEnable,
        input wire 				nWriteEnable,
        
        input wire [C_ADDR_WIDTH-1:0] 	Address,
        inout wire [C_DATA_WIDTH-1:0] 	Data,
        input wire [C_MST_AWIDTH-1:0] 	MappedAddress,	  
      
		input wire [C_MST_DWIDTH-1:0] 	ControlReg,
		output wire [C_MST_DWIDTH-1:0] 	StatusReg,

		output wire [C_MST_DWIDTH-1:0] 	BusAddressReadReg,
		input wire [C_MST_DWIDTH-1:0] 	BusAddressWriteReg,

		output wire [C_MST_DWIDTH-1:0] 	BusDataReadReg,
		input wire [C_MST_DWIDTH-1:0] 	BusDataWriteReg,

		output reg AddrReqIntr,
		input wire AddrReqIntrStatus,
		input wire AddrReqIntrEnable,
      
		output reg DataReadReqIntr,
		input wire DataReadReqIntrStatus,
		input wire DataReadReqIntrEnable,
		
		output reg DataWriteReqIntr,
		input wire DataWriteReqIntrStatus,
		input wire DataWriteReqIntrEnable,
		
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
  Reset = 5'b00000,
	Idle = 5'b00001,
	BusAddressReq =     5'b00010,
  AddressIntrReq =     5'b00011,
  AddressIntrAck =     5'b00100,
  AddressIntrPending = 5'b00101,
  AddressIntrResp =    5'b00110,
	MstAddressReq =     5'b00111,
	BusReq =            5'b01000,
  BusReadReq =         5'b01001, 
  BusReadResp =        5'b01010, 
	MstReadReq =        5'b01011, 
  MstReadResp =        5'b01100, 
  ReadIntrReq =        5'b01101, 
  ReadIntrAck =        5'b01110, 
  ReadIntrPending =    5'b01111,
  BusWriteReq =        5'b10000, 
  BusWriteResp =       5'b10001, 
	MstWriteReq =       5'b10010, 
  MstWriteResp =       5'b10011, 
  WriteIntrReq =       5'b10100, 
  WriteIntrAck =       5'b10101,
  WriteIntrClear =     5'b10110;

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
          if (AddrReqIntrEnable) begin
            AddrReqIntr <= 1;
            state_next <= AddressIntrReq;
          end else
            state_next <= MstAddressReq;
        else 
          state_next <= Idle;
      end
		
    AddressIntrReq: 
      begin
        // Await interrupt to register
        if (AddrReqIntrStatus == 0) begin
          state_next <= AddressIntrAck;
        end
      end

    AddressIntrAck: 
      begin
        // Await interrupt to register
        if (AddrReqIntrStatus == 1) begin
          state_next <= AddressIntrPending;
        end
      end
	  
    AddressIntrPending: 
      begin
        // Await pending interrupts to be clear
        if (AddrReqIntrStatus == 0) begin
          // Use address from register ??? need to think about this, could do with additional 'updated' register
		  // for now we assume if interrupts are enabled then the adress register will be updated
          busAddress <= BusAddressWriteReg[C_ADDR_WIDTH-1:0];
          
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
          busData <= bus2ip_mstrd_d[C_DATA_WIDTH-1:0];
         
          if (DataReadReqIntrEnable) 
            state_next <= ReadIntrReq;
          else
            state_next <= BusReadResp;
        end
      end
        
	ReadIntrReq:
      begin
        // wait on pending interrupts
        if (DataReadReqIntrStatus == 0) begin
		    DataReadReqIntr <= 1;
          
          state_next <= ReadIntrAck;
        end
      end
	 
    ReadIntrAck:
      begin
        // wait on pending interrupts
        if (DataReadReqIntrStatus == 1) begin
		  DataReadReqIntr <= 0;
          
          state_next <= ReadIntrPending;
        end
      end
	  
    ReadIntrPending:
      begin
        // TODO: wait on pending interrupts
        if (DataReadReqIntrStatus == 0) begin
          busData <= BusDataWriteReg[C_DATA_WIDTH-1:0];
          
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
        busData <= Data[C_DATA_WIDTH-1:0];
        
        if (DataWriteReqIntrEnable)
          state_next <= WriteIntrReq;
        else
          state_next <= MstWriteReq;
        
			end else
				state_next <= Idle;
        
		WriteIntrReq:
      begin
        // TODO: wait on pending interrupts
        if (DataWriteReqIntrStatus == 0) begin
          // TODO: raise write interrupt request
          DataWriteReqIntr <= 1;
          
          state_next <= WriteIntrAck;
        end
			end
        
    WriteIntrAck:
      begin
        // TODO: wait on write req interrupt acknowledge
        if (DataWriteReqIntrStatus == 1) begin
          DataWriteReqIntr <= 0;
          state_next <= WriteIntrClear;
        end
      end
        
    WriteIntrClear:
      begin
        // TODO: wait on write req interrupt acknowledge
        if (DataWriteReqIntrStatus == 0) begin
          // not sure if this if going to work without some thought
          busData <= BusDataWriteReg[C_DATA_WIDTH-1:0];
          
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
	
  assign ip2bus_mst_reset = ~rst_n;
  assign ip2bus_mst_addr = mstAddress;
  assign ip2bus_mstwr_req = writeRequest;
  assign ip2bus_mstwr_d = mstData;
  
  assign BusAddressReadReg = { {(C_MST_DWIDTH-C_ADDR_WIDTH){1'b0}}, busAddress };
  assign BusDataReadReg = { {(C_MST_DWIDTH-C_DATA_WIDTH){1'b0}}, busData };
  
  assign IntrStatusReg = intrStatus;
  
  assign Data = nWriteEnable ? (nOutputEnable ? {C_DATA_WIDTH{1'bx}} : readData) : {C_DATA_WIDTH{1'bz}};
  
endmodule

