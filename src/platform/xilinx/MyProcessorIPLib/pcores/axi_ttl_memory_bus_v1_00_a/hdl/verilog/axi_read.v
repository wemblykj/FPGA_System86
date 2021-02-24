module axi_read #(parameter C_ADDR_WIDTH = 16,
                  parameter C_DATA_WIDTH = 8,
                  parameter C_M_AXI_ADDR_WIDTH = 32,
                  parameter C_M_AXI_DATA_WIDTH = 32)
       (input wire chipEnable,
        input wire outputEnable,
        input wire [C_ADDR_WIDTH-1:0] 	 address,
        output wire [C_DATA_WIDTH-1:0] 	 data,
        input wire [C_M_AXI_ADDR_WIDTH:0] baseAddress,
        input wire 	 ACLK,
        input wire 	 ARESETN,
        output wire [C_M_AXI_ADDR_WIDTH-1:0] 	 M_AXI_ARADDR,
        output wire 				 M_AXI_ARVALID,
        input wire 				 M_AXI_ARREADY,
        input wire [C_M_AXI_DATA_WIDTH-1:0] 	 M_AXI_RDATA,
        input wire 				 M_AXI_RVALID,
        output wire 				 M_AXI_RREADY);

endmodule

