###############################################################################
##
## (c) Copyright 1995-2010 Paul Wightmore, Inc. All rights reserved.
##

##
###############################################################################
##
## axi_ttl_memory_bus_v2_1_0.tcl
##
###############################################################################


#***--------------------------------***-----------------------------------***
#
#			     IPLEVEL_UPDATE_VALUE_PROC
#
#***--------------------------------***-----------------------------------***

#
# update parameter C_M_AXI_SUPPORTS_WRITE
#
proc iplevel_update_supports_write { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set readonly [xget_hw_parameter_value $mhsinst "C_READONLY"]
  if { $readonly == 1 } {
    return 0
  } else {
    return 1
  }
}
