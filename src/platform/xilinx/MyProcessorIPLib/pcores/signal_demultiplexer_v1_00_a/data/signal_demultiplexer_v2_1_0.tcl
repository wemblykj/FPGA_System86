###############################################################################
##
## (c) Copyright 1995-2010 Paul Wightmore, Inc. All rights reserved.
##

##
###############################################################################
##
## signal_demultiplexer_v2_1_0.tcl
##
###############################################################################


#***--------------------------------***-----------------------------------***
#
#                IPLEVEL_UPDATE_VALUE_PROC
#
#***--------------------------------***-----------------------------------***

proc iplevel_update_select_width { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  
  set num_ports [xget_hw_parameter_value $mhsinst "C_NUM_PORTS"]
  set select_width [expr int(log($num_ports)/log(2))]
  
  return $select_width
}
