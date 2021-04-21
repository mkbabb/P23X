
         .equ SWI_Open,  0x66     	
         .equ SWI_Close, 0x68     	
         .equ SWI_PrStr, 0x69     	
         .equ SWI_RdStr, 0x6a     	
         .equ SWI_Exit,  0x11     	
@----------------------------------
         .global   _load
         .text

_load:
@----------------------------------
         ldr  r0, =OutputFileName    	
         ldr  r1, =1              	
         swi  SWI_Open            	
         ldr  r1, =OutputFileHandle  	
         str  r0, [r1]            	
@----------------------------------
         ldr  r0, =InputFileName     	
         ldr  r1, =0              	
         swi  SWI_Open            	
         ldr  r1, =InputFileHandle   	
         str  r0, [r1]            	
@----------------------------------
_main:
         ldr  r0, =InputFileHandle   	
         ldr  r0, [r0]            	
         ldr  r1, =InString       	
         ldr  r2, =80           	
         swi  SWI_RdStr           	
		 cmp r0, #0				
		 beq _exit					
@----------------------------------
         ldr  r0, =InString       	
         ldr  r1, =OutString      	
_my_loop:                            	
        ldrb r2, [r0], #1        	
        cmp r2, #0				
        beq _write_char_final				

        cmp r2, #' '
        beq _write_char

        and r2, r2, #0xdf               ; bit-twiddling caps trick.
        sub r3, r2, #'A'                 ; in the range 'twixt [A, Z]?
        cmp r3, #25                     ; does the cmp above the above.
        bls _write_char 

        b _my_loop                ; jmp if so.	 		
				
_write_char:								
        strb r2, [r1], #1        	
		b _my_loop						
_write_char_final: 							
		strb r2, [r1]				
@----------------------------------
_print:
         ldr  r0, =OutputFileHandle  	
         ldr  r0, [r0]            	
         ldr  r1, =OutString      	
         swi  SWI_PrStr           	
         ldr  r1, =CRLF           	
         swi  SWI_PrStr           	
		 b _main					
@----------------------------------
_exit:                            	
         swi  SWI_Exit            	
@----------------------------------
         .data
@----------------------------------
InputFileHandle:  .skip 4            	
OutputFileHandle: .skip 4            	
									
InputFileName:    .asciz "KEY.IN"   	
OutputFileName:   .asciz "KEY.OUT"  	
									
InString:      .skip 80          	
OutString:     .skip 80          	
									
CRLF:          .byte 13, 10, 0    	
									
@----------------------------------
         .end