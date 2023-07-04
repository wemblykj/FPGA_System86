	********************************************* 
	* SUB CPU EQUATES 
	******************************************** 
	
	SUBOBJ		EQU	$0000		; WORK RAM
	SUBSPR		EQU	$1800		; SPRITE REGISTERS
	SUBSCR0		EQU	$2000		; TILEMAP 0/1 RAM
	SUBSCR1		EQU	$4000		; TILEMAP 2/3 RAM
	
	ROM12D		EQU	$6000		;ROM 12D START  
	ROM12DSIZ	EQU	$2000		;ROM 12D SIZE (8K BANKED)

	ROM12C		EQU	$8000		;ROM 12C START  
	ROM12CSIZ	EQU	$8000		;ROM 12C SIZE (32K)