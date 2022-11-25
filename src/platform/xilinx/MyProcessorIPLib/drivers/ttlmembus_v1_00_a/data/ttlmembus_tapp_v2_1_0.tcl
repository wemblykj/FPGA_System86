##############################################################################
#
# (c) Copyright 2021 Paul Wightmore. All rights reserved.
#
# Driver stub based on GPIO driver
#
##############################################################################
# Uses $XILINX_EDK/bin/lib/xillib_sw.tcl

# -----------------------------------------------------------------
# Software Project Types (swproj):
#   0 : MemoryTest - Calls basic  memorytest routines from common driver dir
#   1 : PeripheralTest - Calls any existing polled_example and/or selftest
# -----------------------------------------------------------------

# -----------------------------------------------------------------
# Global variables
# Each global string defined here is a C test function definition.
# Each function defined here must have a unique function prototype.
# Ie. ALL functions defined in this file must be capable of 
#     co-existing in the same C file!

# -----------------------------------------------------------------
# TCL Procedures:
# -----------------------------------------------------------------

proc gen_include_files {swproj mhsinst} {
    if {$swproj == 0} {
        return "xbasic_types.h"
    }
    if {$swproj == 1} {
        set ttlmembus_intr [get_intr $mhsinst]
        
	if { ${ttlmembus_intr} == 1 } {
            set inc_file_lines {xbasic_types.h xttlmembus.h ttlmembus_header.h ttlmembus_intr_header.h}
        } else {
            set inc_file_lines {xbasic_types.h xttlmembus.h ttlmembus_header.h}
        }
        
        return $inc_file_lines
    }
}

proc gen_src_files {swproj mhsinst} {
    if {$swproj == 0} {
        return ""
    }
    if {$swproj == 1} {
        set ttlmembus_intr [get_intr $mhsinst]
        
        if { ${ttlmembus_intr} == 1 } {
            set inc_file_lines {examples/xttlmembus_tapp_example.c examples/xttlmembus_intr_tapp_example.c data/ttlmembus_header.h data/ttlmembus_intr_header.h}
        } else {
            set inc_file_lines {examples/xttlmembus_tapp_example.c data/ttlmembus_header.h}
        }
        return $inc_file_lines
    }
}

proc gen_testfunc_def {swproj mhsinst} {
    if {$swproj == 0} {
        return ""
    }
    if {$swproj == 1} {
        set ttlmembus_intr [get_intr $mhsinst]
        
        if { ${ttlmembus_intr} == 1 } {
            append decl "
#define TTLMEMBUS_ADDR 1
#define TTLMEMBUS_DATA_READ 2
#define TTLMEMBUS_DATA_WRITE 4"
            
            set inc_file_lines $decl
            return $inc_file_lines
        } else {
            return ""
        }
    }
}

proc gen_init_code {swproj mhsinst} {
    if {$swproj == 0} {
        return ""
    }
    if {$swproj == 1} {
        set ttlmembus_intr [get_intr $mhsinst]
        set ipname [xget_value $mhsinst "NAME"]
        
        if { ${ttlmembus_intr} == 1 } {
            set decl "   static XTtlMemBus ${ipname}_TtlMemBus;"
            set inc_file_lines $decl
            return $inc_file_lines
        } else {
            return ""
        }
    }
}

proc gen_testfunc_call {swproj mhsinst} {
    
    if {$swproj == 0} {
        return ""
    }
    
    set ipname [xget_value $mhsinst "NAME"]
    set deviceid [xget_name $mhsinst "DEVICE_ID"]
    set hasStdout [xhas_stdout $mhsinst]
    set ttlmembus_intr [get_intr $mhsinst]
        
    if { ${ttlmembus_intr} == 1 } {
        set mhsHandle [xget_hw_parent_handle $mhsinst]
        set retMhsInst [xget_intc $mhsHandle] 
        set intcname [xget_value $retMhsInst "NAME"]
        set intcvar [xget_intc_drv_var]
    }
    set testfunc_call ""
    
    if {${hasStdout} == 0} {
        append testfunc_call "

   {
      int status;
      
      status = TtlMemBusExample(${deviceid});
   }"
        }
        
        
        if { ${ttlmembus_intr} == 1 } {
            set intr_id "XPAR_${intcname}_${ipname}_IP2INTC_IRPT_INTR"
            set intr_mask "TTLMEMBUS_ADDR | TTLMEMBUS_DATA_READ | TTLMEMBUS_DATA_WRITE"
   
            set intr_id [string toupper $intr_id]
            set intr_mask [string toupper $intr_mask]
            append testfunc_call "
    {
       int Status;
	
       Status = TtlMemBusIntrExample(&${intcvar}, &${ipname}_TtlMemBus, \\
                                ${deviceid}, \\
                                ${intr_id}, \\
                                ${intr_mask});
    }"  
        }
        
    if {${hasStdout} == 1} {
        
        append testfunc_call "

   {
      u32 status;
      
      print(\"\\r\\nRunning TTlMemBusExample() for ${ipname}...\\r\\n\");

      status = TtlMemBusExample(${deviceid});
      
      if (status == 0) {
         print(\"TtlMemBusExample PASSED.\\r\\n\");
      }
      else {
         print(\"TtlMemBusExample FAILED.\\r\\n\");
      }
   }"
        }
        
        
    if { ${ttlmembus_intr} == 1 } {
        set intr_id "XPAR_${intcname}_${ipname}_IP2INTC_IRPT_INTR"
        set intr_mask "TTLMEMBUS_ADDR | TTLMEMBUS_DATA_READ | TTLMEMBUS_DATA_WRITE"
        set intr_id [string toupper $intr_id]
        set intr_mask [string toupper $intr_mask]
        append testfunc_call "
   {
      
      int Status;
        
      print(\" Press CE & OE buttons to Generate Interrupt\\r\\n\");
      
      Status = TtlMemBusIntrExample(&${intcvar}, &${ipname}_Gpio, \\
                               ${deviceid}, \\
                               ${intr_id}, \\
                               ${intr_mask});
	
      if (Status == 0 ){
         print(\"TtlMemBus Interrupt Test PASSED. \\r\\n\"); 
      } 
      else {
         print(\"TtlMemBus Interrupt Test FAILED.\\r\\n\");
      }
	
   }"  
        }
    
    return $testfunc_call
}


proc get_intr {mhsinst} {
    
    set param_intr [xget_value $mhsinst "PARAMETER" "C_INTERRUPT_PRESENT"]
    set ipname [xget_value $mhsinst "NAME"]
    
    if {$param_intr == 1} {
        set mhsHandle [xget_hw_parent_handle $mhsinst]
        set sinkHandle [xget_hw_connected_ports_handle $mhsHandle "${ipname}_IP2INTC_Irpt" "sink"]
        if {$sinkHandle != ""} {
            set intcHandle [xget_hw_parent_handle $sinkHandle]
            set irqValue [xget_hw_port_value $intcHandle "Irq"] 
            if {$irqValue != ""} {
                set procSinkHandle [xget_hw_connected_ports_handle $mhsHandle $irqValue "sink"]
                if {$procSinkHandle != ""} {
                    set procSinkName [xget_hw_name $procSinkHandle]
                    set procVisiblePPC440 [string match $procSinkName "EICC440EXTIRQ"]
                    set procVisiblePPC [string match $procSinkName "EICC405EXTINPUTIRQ"]
                    set procVisibleMB [string match -nocase $procSinkName "INTERRUPT"]                        
                    set procVisible [expr $procVisiblePPC || $procVisibleMB || $procVisiblePPC440]
                    if {$procVisible == 1} {
                        set param_intr 1
                        return $param_intr
                    }
                }
            }
        }
    }
    set param_intr 0
    return $param_intr
}

