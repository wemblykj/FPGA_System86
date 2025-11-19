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
        set system86_intr [get_intr $mhsinst]
        
		if { ${system86_intr} == 1 } {
            set inc_file_lines {xbasic_types.h xsystem86.h system86_header.h system86_intr_header.h}
        } else {
            set inc_file_lines {xbasic_types.h xsystem86.h gpio_header.h}
        }
        
        
        
        return $inc_file_lines
    }
}

proc gen_src_files {swproj mhsinst} {
    if {$swproj == 0} {
        return ""
    }
    if {$swproj == 1} {
        set system86_intr [get_intr $mhsinst]
        
        if { ${system86_intr} == 1 } {
            set inc_file_lines {examples/xsystem86_tapp_example.c examples/xsystem86_intr_tapp_example.c data/system86_header.h data/system86_intr_header.h}
        } else {
            set inc_file_lines {examples/xsystem86_tapp_example.c data/system86_header.h}
        }
        return $inc_file_lines

    }
}

proc gen_testfunc_def {swproj mhsinst} {
    if {$swproj == 0} {
        return ""
    }
    if {$swproj == 1} {
        set system86_intr [get_intr $mhsinst]
        
        if { ${system86_intr} == 1 } {
            append decl "
#define SYSTEM86_ADDR 1
#define SYSTEM86_DATA_READ 2
#define SYSTEM86_DATA_WRITE 4"
            
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
        set system86_intr [get_intr $mhsinst]
        set ipname [xget_value $mhsinst "NAME"]
        
        if { ${system86_intr} == 1 && ${all_inputs} == 1 } {
            set decl "   static XSystem86 ${ipname}_XSystem86;"
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
    set gpio_width [xget_value $mhsinst "PARAMETER" "C_GPIO_WIDTH"]
    set system86_intr [get_intr $mhsinst]
        
    if { ${system86_intr} == 1 && ${all_inputs} == 1 } {
        set mhsHandle [xget_hw_parent_handle $mhsinst]
        set retMhsInst [xget_intc $mhsHandle] 
        set intcname [xget_value $retMhsInst "NAME"]
        set intcvar [xget_intc_drv_var]
    }
    set testfunc_call ""
    
    if {${hasStdout} == 0} {
        
        switch ${all_inputs} {
            0       { 
                append testfunc_call "

   {
      int status;
      
      status = System86Example(${deviceid});
   }"
            }
            1       { 
                append testfunc_call "

   {
      int status;
	 
      u32 DataRead;
      
      status = GpioInputExample(${deviceid}, &DataRead);
   }"
            }
            default { return "" }
        }
        
        
        if { ${system86_intr} == 1 } {
            set intr_id "XPAR_${intcname}_${ipname}_IP2INTC_IRPT_INTR"
            set intr_mask "system86_ADDR | system86_DATA_READ | system86_DATA_WRITE"
   
            set intr_id [string toupper $intr_id]
            set intr_mask [string toupper $intr_mask]
            append testfunc_call "
    {
       int Status;
	
       u32 DataRead;
   
       Status = GpioIntrExample(&${intcvar}, &${ipname}_Gpio, \\
                                ${deviceid}, \\
                                ${intr_id}, \\
                                ${intr_mask}, &DataRead);
    }"  
        }
        
    }
    if {${hasStdout} == 1} {
        
        switch ${all_inputs} {
            0       { 
                append testfunc_call "

   {
      u32 status;
      
      print(\"\\r\\nRunning GpioOutputExample() for ${ipname}...\\r\\n\");

      status = GpioOutputExample(${deviceid},${gpio_width});
      
      if (status == 0) {
         print(\"GpioOutputExample PASSED.\\r\\n\");
      }
      else {
         print(\"GpioOutputExample FAILED.\\r\\n\");
      }
   }"
            }
            1       { 
                append testfunc_call "

   {
      u32 status;
      
      print(\"\\r\\nRunning GpioInputExample() for ${ipname}...\\r\\n\");

      u32 DataRead;
      
      status = GpioInputExample(${deviceid}, &DataRead);
      
      if (status == 0) {
         xil_printf(\"GpioInputExample PASSED. Read data:0x%X\\r\\n\", DataRead);
      }
      else {
         print(\"GpioInputExample FAILED.\\r\\n\");
      }
   }"
            }
            default { return "" }
        }
        
        
        if { ${system86_intr} == 1 && ${all_inputs} == 1 } {
            set intr_id "XPAR_${intcname}_${ipname}_IP2INTC_IRPT_INTR"
            if { ${gpio_isdual} == 1 } {
                set intr_mask "GPIO_CHANNEL1 | GPIO_CHANNEL2"
            } else {
                set intr_mask "GPIO_CHANNEL1"
            }
            set intr_id [string toupper $intr_id]
            set intr_mask [string toupper $intr_mask]
            append testfunc_call "
   {
      
      int Status;
        
      u32 DataRead;
      
      print(\" Press button to Generate Interrupt\\r\\n\");
      
      Status = GpioIntrExample(&${intcvar}, &${ipname}_Gpio, \\
                               ${deviceid}, \\
                               ${intr_id}, \\
                               ${intr_mask}, &DataRead);
	
      if (Status == 0 ){
             if(DataRead == 0)
                print(\"No button pressed. \\r\\n\");
             else
                print(\"Gpio Interrupt Test PASSED. \\r\\n\"); 
      } 
      else {
         print(\"Gpio Interrupt Test FAILED.\\r\\n\");
      }
	
   }"  
        }
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

