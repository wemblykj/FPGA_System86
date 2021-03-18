module axi_ttl_memory_bus_master #(
	parameter C_ADDR_WIDTH = 16,
        parameter C_DATA_WIDTH = 8,
		  parameter C_MST_AWIDTH = 32,
        parameter C_MST_DWIDTH = 32)
       (input wire 				ChipEnable/*,
        input wire 				OutputEnable,
        input wire 				WriteEnable,
        input wire [C_ADDR_WIDTH-1:0] 	 	Address,
        inout wire [C_DATA_WIDTH-1:0] 	 	Data,
        input wire [C_MST_AWIDTH-1:0] 	MappedAddress*/
    /*output wire ip2bus_mstrd_req,
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
    input wire bus2ip_mstwr_dst_rdy_n*/
		  );

always @(posedge ChipEnable) begin
end

endmodule

