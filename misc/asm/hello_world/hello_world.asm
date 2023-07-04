	********************************************* 
	* GLOBAL MODULE EQUATES 
	******************************************** 
	
	INCLUDE 6809.inc

	********************************************* 
	* MAIN CPU EQUATES 
	******************************************** 

	INCLUDE main_cpu.inc

	********************************************* 
	* SUB CPU EQUATES 
	******************************************** 
	
	;INCLUDE sub_cpu.inc

	********************************************* 
	* MAIN CPU ROUTINES
	******************************************** 
	
	ORG ROM9C 				;ROM ASSEMBLY/DEFAULT ADDRESS

:RESET

	********************************************* 
	* VECTOR TABLE 
	******************************************** 

	ORG IVTBL	 		;SETUP HARDWARE VECTORS
	
	FDB RSRVD 			;RESERVED SLOT
	FDB SWI3 			;SOFTWARE INTERRUPT 3 
	FDB SWI2 			;SOFTWARE INTERRUPT 2 
	FDB FIRQ 			;FAST INTERRUPT REQUEST 
	FDB IRQ 			;INTERRUPT REQUEST 
	FDB SWI 			;SOFTWARE INTERRUPT 
	FDB NMI 			;NON-MASKABLE INTERRUPT 
	FDB RESET 			;RESTART