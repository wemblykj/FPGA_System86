##############################################################################
#
# (c) Copyright 2021 Paul Wightmore. All rights reserved.
#
##############################################################################
#uses "xillib.tcl"

proc generate {drv_handle} {
  set level [xget_value $drv_handle "PARAMETER" "level"]
  xdefine_include_file $drv_handle "xparameters.h" "XTtlMemBus" "NUM_INSTANCES" "C_BASEADDR" "C_HIGHADDR" "DEVICE_ID" "C_ADDR_WIDTH" "C_DATA_WIDTH" "C_MAPPED_ADDRESS" "C_USE_DYNAMIC_MAPPING" "C_READONLY" "C_INTERRUPT_PRESENT"
  xdefine_config_file $drv_handle "xttlmembus_g.c" "XTtlMemBus" "DEVICE_ID" "C_BASEADDR" "C_ADDR_WIDTH" "C_DATA_WIDTH" "C_MAPPED_ADDRESS" "C_USE_DYNAMIC_MAPPING" "C_READONLY" "C_INTERRUPT_PRESENT"
  xdefine_canonical_xpars $drv_handle "xparameters.h" "TtlMemBus" "C_BASEADDR" "C_HIGHADDR" "DEVICE_ID" "C_ADDR_WIDTH" "C_DATA_WIDTH" "C_MAPPED_ADDRESS" "C_USE_DYNAMIC_MAPPING" "C_READONLY" "C_INTERRUPT_PRESENT"
}
