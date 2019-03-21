------------------------------------------------------------------------------
--
-- BFM simulation Guide
--
------------------------------------------------------------------------------


BFM Simulation XPS Flow
------------------------------------------------------------------------------

1. Open this bfm_system.xmp project in XPS.

2. Click Project -> Project Options... to open up the Project Options
   dialog and specify the following options:

   - Device and Repository -
     * select the Architecture, Device Size, Package and Grade you desired
       in the Target Device group.
     * no other changes are necessary.

   - Hierarchy and Flow -
     * accept all defaults, no change.

   - HDL and Simulation -
     * select the simulator you desire in the Simulator Compile Script group.
     * specify EDK Library and Xilinx Library paths in the Simulation Libraries
       Path group if they are blank.
     * make sure Behavioral is selected in the Simulation Models group.

3. Click Simulation -> Generate Simulation HDL Files in XPS to generate the BFM   simulation platform. 
Copy <pcore>/devl/bfmsim/scripts/bfm_system_tb.v to devl/bfmsim/simulation/behavioral dir

4. Click on Simulation -> Launch HDL Simulator to launch the simulator.


