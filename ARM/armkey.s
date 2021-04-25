@--------------------------------------------------------------------
@
@   Program:   KEY
@
@   Function:  Key reads each character from the standard input.  
@              After reading in a singular character, the program
@              will only print out letters A-Z and a-z and spaces.
@              The program terminates at the end upon reading in a 
@              period and printing it out.
@             - INPUT:  key.in  : reads until end of input file key.in
@             - OUTPUT: key.out : writes to key.out
@             - one line to the output file followed by CR LF
@
@              It is intended to ability to program in arm
@
@              It assumes that the characters read are in the
@              range of 20h - 7Fh
@
@   Owner:     Mike Babb
@   Owner:     Sanjana Cheerla
@
@   Date       Reason
@   ----       ------
@   04/20/2021 A little buggy
@   04/21/2021 Final Versions
@
@---------------------------------------------------------------------
        .equ SWI_Open,  0x66     	
        .equ SWI_Close, 0x68     	
        .equ SWI_PrStr, 0x69     	
        .equ SWI_RdStr, 0x6a     	
        .equ SWI_Exit,  0x11     	
        .global   _load
        .text
@----------------------------------------------------------------------
@ load files
@----------------------------------------------------------------------
_load:
@----------------------------------------------------------------------
@ load output file
@----------------------------------------------------------------------
        ldr  r0, =OutputFileName    	
        ldr  r1, =1              	
        swi  SWI_Open            	
        ldr  r1, =OutputFileHandle  	
        str  r0, [r1]            	
@----------------------------------------------------------------------
@ load input file
@----------------------------------------------------------------------
        ldr  r0, =InputFileName     	
        ldr  r1, =0              	
        swi  SWI_Open            	
        ldr  r1, =InputFileHandle   	
        str  r0, [r1]            	
@----------------------------------------------------------------------
@ compare read character with A-Z, a-z, and ' '
@----------------------------------------------------------------------
_main:
        ldr  r0, =InputFileHandle   	
        ldr  r0, [r0]            	
        ldr  r1, =InString       	
        ldr  r2, =80           	
        swi  SWI_RdStr           	
        cmp r0, #0				
        beq _exit					
        ldr  r0, =InString       	
        ldr  r1, =OutString      	
@----------------------------------------------------------------------
@ compare read character with A-Z, a-z, and ' '
@----------------------------------------------------------------------
_my_loop:                            	
        ldrb r2, [r0], #1        	
        cmp r2, #0				
        beq _write_char_final				

        cmp r2, #' '
        beq _write_char

        and r2, r2, #0xdf       
        sub r3, r2, #'A'        
        cmp r3, #25             
        bls _write_char 

        b _my_loop          		
				
@----------------------------------------------------------------------
@ writes character and increments r1 pointer
@----------------------------------------------------------------------
_write_char:								
        strb r2, [r1], #1        	
	b _my_loop
@----------------------------------------------------------------------
@ writes character and does not increment r1 pointer
@----------------------------------------------------------------------						
_write_char_final: 							
	strb r2, [r1]				
@----------------------------------------------------------------------
@ prints out the stored string of characters
@----------------------------------------------------------------------
_print:
        ldr  r0, =OutputFileHandle  	
        ldr  r0, [r0]            	
        ldr  r1, =OutString      	
        swi  SWI_PrStr           	
        ldr  r1, =CRLF           	
        swi  SWI_PrStr           	
        b _main					
@----------------------------------------------------------------------
@ Close output file
@ Terminate the program
@----------------------------------------------------------------------
_exit:                            	
        ldr  r0, =OutputFileHandle
        swi       SWI_Close   
        ldr  r0, =InputFileHandle
        swi       SWI_Close                
        swi  SWI_Exit           	
@----------------------------------------------------------------------
         .data
@----------------------------------------------------------------------
InputFileHandle:  .skip 4            	
OutputFileHandle: .skip 4            	
									
InputFileName:    .asciz "KEY.IN"   	
OutputFileName:   .asciz "KEY.OUT"  	
									
InString:      .skip 80          	
OutString:     .skip 80          	
									
CRLF:          .byte 13, 10, 0    	
									
@----------------------------------------------------------------------
         .end
@----------------------------------------------------------------------