##############################################################################
#
# (c) Copyright 2021 Paul Wightmore. All rights reserved.
#
# Driver stub based on GPIO driver
#
##############################################################################
#uses "xillib.tcl"

proc generate {drv_handle} {
  set level [xget_value $drv_handle "PARAMETER" "level"]
  xdefine_include_file $drv_handle "xparameters.h" "XSystem86" "NUM_INSTANCES" "C_BASEADDR" "C_HIGHADDR" "DEVICE_ID" "C_ADDR_WIDTH" "C_DATA_WIDTH" "C_MAPPED_ADDRESS" "C_USE_DYNAMIC_MAPPING" "C_READONLY" "C_INTERRUPT_PRESENT"
  xdefine_config_file $drv_handle "xsystem86_g.c" "XSystem86" "DEVICE_ID" "C_BASEADDR" "C_ADDR_WIDTH" "C_DATA_WIDTH" "C_MAPPED_ADDRESS" "C_USE_DYNAMIC_MAPPING" "C_READONLY" "C_INTERRUPT_PRESENT"
  xdefine_canonical_xpars $drv_handle "xparameters.h" "System86" "C_BASEADDR" "C_HIGHADDR" "DEVICE_ID" "C_ADDR_WIDTH" "C_DATA_WIDTH" "C_MAPPED_ADDRESS" "C_USE_DYNAMIC_MAPPING" "C_READONLY" "C_INTERRUPT_PRESENT"
}
