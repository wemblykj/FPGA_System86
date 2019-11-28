//----------------------------------------------------------------------------
// bfm_system_tb.v - module
//----------------------------------------------------------------------------
//
// ***************************************************************************
// ** Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.            **
// **                                                                       **
// ** Xilinx, Inc.                                                          **
// ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
// ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
// ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
// ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
// ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
// ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
// ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
// ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
// ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
// ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
// ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
// ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
// ** FOR A PARTICULAR PURPOSE.                                             **
// **                                                                       **
// ***************************************************************************
//
//----------------------------------------------------------------------------
// Filename:          bfm_system_tb.v
// Version:           1.00.a
// Description:       Testbench logic.
// Date:              Thu Nov 28 13:05:45 2019 (by Create and Import Peripheral Wizard)
// Verilog Standard:  Verilog-2001
//----------------------------------------------------------------------------
// Naming Conventions:
//   active low signals:                    "*_n"
//   clock signals:                         "clk", "clk_div#", "clk_#x"
//   reset signals:                         "rst", "rst_n"
//   generics:                              "C_*"
//   user defined types:                    "*_TYPE"
//   state machine next state:              "*_ns"
//   state machine current state:           "*_cs"
//   combinatorial signals:                 "*_com"
//   pipelined or register delay signals:   "*_d#"
//   counter signals:                       "*cnt*"
//   clock enable signals:                  "*_ce"
//   internal version of output port:       "*_i"
//   device pins:                           "*_pin"
//   ports:                                 "- Names begin with Uppercase"
//   processes:                             "*_PROCESS"
//   component instantiations:              "<ENTITY_>I_<#|FUNC>"
//----------------------------------------------------------------------------

`timescale 1 ns / 100 fs

//testbench defines
`define RESET_PERIOD 200
`define CLOCK_PERIOD 10
`define INIT_DELAY   400

//user slave defines
`define SLAVE_BASE_ADDR  32'h30000000
`define SLAVE_REG_OFFSET 32'h00000000
`define SLAVE_RESET_ADDR 32'h00000100
`define SLAVE_SOFT_RESET 32'h0000000A

//Response type defines
`define RESPONSE_OKAY   2'b00
//AMBA 4 defines
`define MAX_BURST_LENGTH 1
`define PROT_BUS_WIDTH   3
`define ADDR_BUS_WIDTH   32
`define RESP_BUS_WIDTH   2

module bfm_system_tb
(
); // bfm_system_tb

// -- ADD USER PARAMETERS BELOW THIS LINE ------------
// --USER parameters added here 
// -- ADD USER PARAMETERS ABOVE THIS LINE ------------

// -- DO NOT EDIT BELOW THIS LINE --------------------
// -- Bus protocol parameters, do not add to or delete
parameter C_NUM_REG                      = 5;
parameter C_SLV_DWIDTH                   = 32;
// -- DO NOT EDIT ABOVE THIS LINE --------------------

//----------------------------------------------------------------------------
// Implementation
//----------------------------------------------------------------------------

  // -- Testbench nets declartions added here, as needed for testbench logic

  reg                                       rst_n;
  reg                                       sys_clk;
  integer                                   number_of_bytes;
  integer                                   i;
  integer                                   j;
  reg        [C_SLV_DWIDTH-1 : 0]           test_data;
  reg        [`ADDR_BUS_WIDTH-1 : 0]        mtestAddr;
  reg        [`PROT_BUS_WIDTH-1 : 0]        mtestProtection;
  reg        [C_SLV_DWIDTH-1 : 0]           rd_data;
  reg        [`RESP_BUS_WIDTH-1 : 0]        response;
  //----------------------------------------------------------------------------
  // Instantiate bfm_system
  //----------------------------------------------------------------------------

  bfm_system
    dut(.sys_reset(rst_n),.sys_clk(sys_clk));

  //----------------------------------------------------------------------------
  // Reset block
  //----------------------------------------------------------------------------

  initial begin
         rst_n = 1'b0;
    #`RESET_PERIOD rst_n = 1'b1;
  end

  //----------------------------------------------------------------------------
  // Simple Clock Generator
  //----------------------------------------------------------------------------

  initial sys_clk = 1'b0;
  always #`CLOCK_PERIOD sys_clk = !sys_clk;

  //----------------------------------------------------------------------------
  // Simple testbench logic
  //----------------------------------------------------------------------------

  initial begin
    //Wait for end of reset
    wait(rst_n == 0) @(posedge sys_clk);
    wait(rst_n == 1) @(posedge sys_clk);
    #`INIT_DELAY mtestProtection = 0;
    $display("----------------------------------------------------");
    $display("Full Registers write followed by a full Registers read");
    $display("----------------------------------------------------");
    number_of_bytes = (C_SLV_DWIDTH/8);
    for( i = 0 ; i <5; i = i+1) begin
      for(j = 0 ; j < number_of_bytes ; j = j+1)
        test_data[j*8 +: 8] = j+(i*number_of_bytes);
      mtestAddr = `SLAVE_BASE_ADDR + `SLAVE_REG_OFFSET + i*number_of_bytes;
      $display("Writing to Slave Register addr=0x%h",mtestAddr, " data=0x%h",test_data);
      SINGLE_WRITE(mtestAddr,test_data,mtestProtection,4'b1111, response);
    end
    for( i = 0 ; i <5; i = i+1) begin
      for(j=0 ; j < number_of_bytes ; j = j+1)
        test_data[j*8 +: 8] = j+(i*number_of_bytes);
      mtestAddr = `SLAVE_BASE_ADDR + `SLAVE_REG_OFFSET + i*number_of_bytes;
      SINGLE_READ(mtestAddr,rd_data,mtestProtection,response);
      $display("Reading from Slave Register addr=0x%h",mtestAddr, " data=0x%h",rd_data);
      COMPARE_DATA(test_data,rd_data);
    end
    $display("----------------------------------------------------");
    $display("Soft Reseting of peripheral and Full Register read");
    $display("----------------------------------------------------");
    test_data = `SLAVE_SOFT_RESET;
    mtestAddr = `SLAVE_BASE_ADDR + `SLAVE_RESET_ADDR;
    SINGLE_WRITE(mtestAddr,test_data,mtestProtection,4'b1111, response);
        test_data = 0;
    for( i = 0 ; i <5; i = i+1) begin
      for(j=0 ; j < number_of_bytes ; j = j+1)
      mtestAddr = `SLAVE_BASE_ADDR + `SLAVE_REG_OFFSET + i*number_of_bytes;
      SINGLE_READ(mtestAddr,rd_data,mtestProtection,response);
      $display("Reading from Slave Register addr=0x%h",mtestAddr, " data=0x%h",rd_data);
      COMPARE_DATA(test_data,rd_data);
    end
  $display("----------------------------------------------------");
  $display("Peripheral Verification Completed Successfully");
  $display("----------------------------------------------------");
end

  //----------------------------------------------------------------------------
  // SINGLE_WRITE : SINGLE_WRITE(Address, Data,protection,strobe,response)
  //----------------------------------------------------------------------------

  task automatic SINGLE_WRITE;
     input [`ADDR_BUS_WIDTH-1 : 0] address;
     input [C_SLV_DWIDTH-1 : 0]    data;
     input [`PROT_BUS_WIDTH-1 : 0] prot; 
     input [3:0]                   strobe;
     output[`RESP_BUS_WIDTH-1 : 0] response;
     begin
       fork
          dut.bfm_processor.bfm_processor.cdn_axi4_lite_master_bfm_inst.SEND_WRITE_ADDRESS(address,prot);
          dut.bfm_processor.bfm_processor.cdn_axi4_lite_master_bfm_inst.SEND_WRITE_DATA(strobe, data);
          dut.bfm_processor.bfm_processor.cdn_axi4_lite_master_bfm_inst.RECEIVE_WRITE_RESPONSE(response);
       join
       CHECK_RESPONSE_OKAY(response);
     end
  endtask

  //----------------------------------------------------------------------------
  // SINGLE_READ : SINGLE_READ(Address, Data,Protection,strobe,respone)
  //----------------------------------------------------------------------------

  task automatic SINGLE_READ;
     input [`ADDR_BUS_WIDTH-1 : 0] address;
     output [C_SLV_DWIDTH-1 : 0]    data;
     input [`PROT_BUS_WIDTH-1 : 0] prot; 
     output[`RESP_BUS_WIDTH-1 : 0] response;
     begin
      dut.bfm_processor.bfm_processor.cdn_axi4_lite_master_bfm_inst.SEND_READ_ADDRESS(address,prot);
      dut.bfm_processor.bfm_processor.cdn_axi4_lite_master_bfm_inst.RECEIVE_READ_DATA(data,response);
      CHECK_RESPONSE_OKAY(response);
     end
  endtask

  //----------------------------------------------------------------------------
  //   TEST LEVEL API: CHECK_RESPONSE_OKAY(response)
  //----------------------------------------------------------------------------

  //Description: This task check if the return response is equal to OKAY
  //----------------------------------------------------------------------
  task automatic CHECK_RESPONSE_OKAY;
    input [`RESP_BUS_WIDTH-1:0] response;
     begin
      if (response !== `RESPONSE_OKAY) begin
        $display("TESTBENCH FAILED! Response is not OKAY",
          "\n expected = 0x%h",`RESPONSE_OKAY,
          "\n actual = 0x%h", response);
        $stop;
      end
    end
  endtask
  //----------------------------------------------------------------------------
  //   TEST LEVEL API: COMPARE_DATA(expected,actual)
  //----------------------------------------------------------------------------

  //Description: This task checks if the actual data is equal to the expected data
  //----------------------------------------------------------------------
  task automatic COMPARE_DATA;
    input [(C_SLV_DWIDTH*(`MAX_BURST_LENGTH+1))-1:0] expected;
    input [(C_SLV_DWIDTH*(`MAX_BURST_LENGTH+1))-1:0] actual;
    begin
      if (expected === 'hx || actual === 'hx) begin
        $display("TESTBENCH FAILED! COMPARE_DATA cannot be performed with an expected or actual vector that is all 'x'!");
        $stop;
      end
      if (actual !== expected) begin
        $display("TESTBENCH FAILED! Data expected is not equal to actual.","\n expected = 0x%h",expected,
        "\n actual   = 0x%h",actual);
        $stop;
      end
    end
    endtask
endmodule
