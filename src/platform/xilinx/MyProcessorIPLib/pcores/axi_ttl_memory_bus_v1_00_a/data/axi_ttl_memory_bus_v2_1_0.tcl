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

proc get_presets { preset_array } {
	upvar  $preset_array arr

	array set arr {}
	
	set arr(rom1) [ list "Generic Rom" 0 ]
	set arr(rom2) [ list "Generic Ram" 1 ]
}

proc iplevel_update_preset { param_handle } {
    set mhsinst [xget_hw_parent_handle $param_handle]
	
	set preset [xget_hw_parameter_value $mhsinst "C_PRESET"]
	set preset_handle [xget_hw_parameter_handle $mhsinst "C_PRESET"]
	
	get_presets preset_list
	
	set count [llength preset_list]
	set values "(0=Custom"
	set i 1
	foreach { key value } [array get preset_list] {
		set name [lindex $value 0]
		set values "${values}, ${i}= ${name}"
		
		incr i
	}
	
	set values [ concat $values ")" ]
	
	set range "(0:"
	set range [ concat $range $count ]
	set range [ concat $range ")" ]
    
	xadd_hw_subproperty $preset_handle             "RANGE" $range
	xadd_hw_subproperty $preset_handle             "VALUES" $values
	
	return $preset
}

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
	#set bw [expr 3]
    return 3
  }
  
  return 0
}

proc calc_mapped_size { mhsinst } {
  set addr_width [xget_hw_parameter_value $mhsinst "C_ADDR_WIDTH"]
  set data_width [xget_hw_parameter_value $mhsinst "C_DATA_WIDTH"]
  set size [expr (int(pow(2.0, $addr_width) * pow(2.0, $data_width)) / 8)]
  
  return $size
}

proc iplevel_update_mapped_size { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set size [calc_mapped_size $mhsinst]

  return [format 0x%08X $size]
}

proc iplevel_update_mapped_high { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set size [calc_mapped_size $mhsinst]
  
  set addr_base [xget_hw_parameter_value $mhsinst "C_MAPPED_BASEADDR"]
  if { $addr_base != 0xffffffff } {
  	set addr_high [expr ($addr_base + $size) - 1]
  } else {
  	set addr_high 0xffffffff
  }
  
  return [format 0x%08X $addr_high]
}
