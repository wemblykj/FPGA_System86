module axi_ttl_memory_bus_master #(
		  parameter C_CTRL_WIDTH = 3,
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

	   output wire [C_CTRL_WIDTH-1:0] 	BusControlReadReg,

		output wire [C_ADDR_WIDTH-1:0] 	BusAddressReadReg,
		input wire [C_ADDR_WIDTH-1:0] 	BusAddressWriteReg,

		output wire [C_DATA_WIDTH-1:0] 	BusDataReadReg,
		input wire [C_DATA_WIDTH-1:0] 	BusDataWriteReg,

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
  Disabled = 5'b00000,
  Reset = 5'b00001,
  Idle = 5'b00010,
	BusAddressReq =     5'b00011,
  AddressIntrReq =     5'b00100,
  AddressIntrAck =     5'b00101,
  AddressIntrPending = 5'b00110,
  AddressIntrResp =    5'b00111,
	MstAddressReq =     5'b01000,
	BusReq =            5'b01001,
  BusReadReq =         5'b01010, 
  BusReadResp =        5'b01011, 
	MstReadReq =        5'b01100, 
  MstReadResp =        5'b01101, 
  ReadIntrReq =        5'b01110, 
  ReadIntrAck =        5'b01111, 
  ReadIntrPending =    5'b10000,
  BusWriteReq =        5'b10001, 
  BusWriteResp =       5'b10010, 
	MstWriteReq =       5'b10011, 
  MstWriteResp =       5'b10100, 
  WriteIntrReq =       5'b10101, 
  WriteIntrAck =       5'b10110,
  WriteIntrClear =     5'b10111;

reg[4:0] fsmState, state_next;

reg [C_MST_DWIDTH-1:0] statusReg;

reg [2:0] busControl;
reg [C_ADDR_WIDTH-1:0] busAddress;
reg [C_DATA_WIDTH-1:0] busData;
reg [C_DATA_WIDTH-1:0] readData;

reg [C_MST_AWIDTH-1:0] mstAddress;
reg [C_MST_DWIDTH-1:0] mstData;

reg runningFlag;
reg readRequest;
reg writeRequest;
reg intrStatus;

always @(state_next, rst_n) begin
	if (!rst_n) begin
		fsmState <= Disabled;
	end else begin
		fsmState <= state_next;
	end
end

always @(fsmState, runningFlag) begin
	statusReg <= { fsmState, {(C_MST_DWIDTH-6){1'b0}}, runningFlag, 1 };
end

always @(fsmState, nChipEnable, nOutputEnable, nWriteEnable) begin
	state_next <= fsmState;
	
	case(fsmState)
		Disabled:
		begin
			if (ControlReg[1]) begin
				state_next <= Reset;
			end

			runningFlag <= ControlReg[1];
		end
		
		Reset:
      begin
        writeRequest <= 0;
        readRequest <= 0;
		  busControl <= 0;
        busAddress <= 0;
        busData <= 0;
        
        state_next <= Idle;
      end
      
		Idle:
		begin
			if (ControlReg[1]) begin
				if (!nChipEnable) begin
					if (busAddress !== Address) begin
						state_next <= BusAddressReq;
					end
				end 

				busControl <= { {(C_CTRL_WIDTH-1){1'b0}}, nChipEnable };
			end else
				state_next <= Disabled;
		end	
		
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
				state_next <= Reset;
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
		begin
			if (!nChipEnable) begin
			  mstAddress <= MappedAddress + busAddress;
			  state_next <= BusReq;
			end else
			  state_next <= Reset;
		end
		
		BusReq:
      if (!nChipEnable) begin
			// Await for operation if not already set 
			// in the meantime handle any change in address
			if (busAddress !== Address)
				// address has changed, restart
				state_next <= BusAddressReq;
			else if (nWriteEnable)
				// A write operation was requested
				state_next <= BusWriteReq;
			else if (nOutputEnable)
					// A read operation was requested
				state_next <= BusReadReq;
			
      end else
        state_next <= Reset;
				
		BusReadReq:
      if (!nChipEnable) begin
			busControl[1] <= 1;
			state_next <= MstReadReq;
      end else
			state_next <= Reset;
        
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

			state_next <= Reset;
		end
    
		BusWriteReq:
		if (!nChipEnable) begin
			busControl[2] <= 1;

			// TODO: wait on pending interrupts

			// Put data to write in bus data register
			// TODO: byte strobing
			busData <= Data[C_DATA_WIDTH-1:0];

			if (DataWriteReqIntrEnable)
				state_next <= WriteIntrReq;
			else
				state_next <= MstWriteReq;
				
		end else
			state_next <= Reset;
        
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
			state_next <= Reset;
      end
        
	endcase
end
	
  assign ip2bus_mst_reset = ~rst_n;
  assign ip2bus_mst_addr = mstAddress;
  assign ip2bus_mstwr_req = writeRequest;
  assign ip2bus_mstwr_d = mstData;
  
generate
	if (C_CTRL_WIDTH == 1)
		assign BusControlReadReg = busControl[0];
	else if (C_CTRL_WIDTH == 2) begin
		assign BusControlReadReg = { busControl[1], busControl[0] }; 
	end else if (C_CTRL_WIDTH == 3) begin
		assign BusControlReadReg = { busControl[2], busControl[1], busControl[0] }; 
	end
endgenerate
  
  assign StatusReg = statusReg;
  assign BusAddressReadReg = busAddress;
  assign BusDataReadReg = busData;
  
  assign IntrStatusReg = intrStatus;
  
  assign Data = nWriteEnable ? (nOutputEnable ? {C_DATA_WIDTH{1'bx}} : readData) : {C_DATA_WIDTH{1'bz}};
  
endmodule

