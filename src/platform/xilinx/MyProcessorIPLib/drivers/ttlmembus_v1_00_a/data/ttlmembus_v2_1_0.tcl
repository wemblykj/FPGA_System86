##############################################################################
#
# (c) Copyright 2021 Paul Wightmore. All rights reserved.
#
##############################################################################
#uses "xillib.tcl"

proc generate {drv_handle} {
  set level [xget_value $drv_handle "PARAMETER" "level"]
  xdefine_include_file $drv_handle "xparameters.h" "XTtlMemBus" "NUM_INSTANCES" "C_BASEADDR" "C_HIGHADDR" "DEVICE_ID" "C_MAPPED_BASEADDR"
  xdefine_config_file $drv_handle "xttlmembus_g.c" "XTtlMemBus"  "DEVICE_ID" "C_BASEADDR" "C_MAPPED_BASEADDR"
  xdefine_canonical_xpars $drv_handle "xparameters.h" "TtlMemBus" "C_BASEADDR" "C_HIGHADDR" "DEVICE_ID" "C_MAPPED_BASEADDR"
}
