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
#                IPLEVEL_UPDATE_VALUE_PROC
#
#***--------------------------------***-----------------------------------***

#
# update parameter C_M_AXI_SUPPORTS_WRITE
#

proc iplevel_update_supports_write { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set memtype [xget_hw_parameter_value $mhsinst "C_MEM_TYPE"]
  if { $memtype == 1 } {
    return 0
  } else {
    return 1
  }
}

proc iplevel_update_control_bus_size { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set memtype [xget_hw_parameter_value $mhsinst "C_MEM_TYPE"]
  if { $memtype == 1 } {
    set romtype [xget_hw_parameter_value $mhsinst "C_ROM_TYPE"]
    if { $romtype == 1 } {
        return 2
    } else {
        return 1
    }
  } else {
    return 3
  }
}

proc calc_mapped_size { mhsinst } {
  set addr_width [xget_hw_parameter_value $mhsinst "C_ADDR_WIDTH"]
  set data_width [xget_hw_parameter_value $mhsinst "C_DATA_WIDTH"]
  set size [expr (int(pow(2.0, $addr_width) * $data_width) / 8)]
  
  return $size
}

proc iplevel_update_mapped_size { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  return [calc_mapped_size $mhsinst]
}

proc iplevel_update_mapped_high { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set size [calc_mapped_size $mhsinst]
  
  set addr_base [xget_hw_parameter_value $mhsinst "C_MAPPED_BASEADDR"]
  set addr_high [expr ($addr_base + $size) - 1]
  
  return [format 0x%08X $addr_high]
}
