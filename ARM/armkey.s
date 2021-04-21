
         .equ SWI_Open,  0x66     	
         .equ SWI_Close, 0x68     	
         .equ SWI_PrStr, 0x69     	
         .equ SWI_RdStr, 0x6a     	
         .equ SWI_Exit,  0x11     	
@----------------------------------
         .global   _start
         .text

_start:
@----------------------------------
         ldr  r0, =InFileName     	
         ldr  r1, =0              	
         swi  SWI_Open            	
         ldr  r1, =InFileHandle   	
         str  r0, [r1]            	
@----------------------------------
         ldr  r0, =OutFileName    	
         ldr  r1, =1              	
         swi  SWI_Open            	
         ldr  r1, =OutFileHandle  	
         str  r0, [r1]            	
@----------------------------------
_process:
         ldr  r0, =InFileHandle   	
         ldr  r0, [r0]            	
         ldr  r1, =InString       	
         ldr  r2, =80           	
         swi  SWI_RdStr           	
		 cmp r0, #0x00				
		 beq _exit					
@----------------------------------
         ldr  r0, =InString       	
         ldr  r1, =OutString      	
_loop:                            	
		 ldrb r2, [r0], #1        	
		 cmp r2, #0x00				
		 beq _finloop				
		 cmp r2, #0X20				
		 beq _store					
		 cmp  r2, #0x7A		 		
		 bhi  _loop					
		 cmp  r2, #0x60				
		 subhi r2, r2, #0X20		
_dontConvert:						
		 cmp r2, #0x5A				
		 bhi _loop					
		 cmp r2, #0X40				
_store:								
        strhib r2, [r1], #1        	
		b _loop						
_finloop: 							
		strb r2, [r1]				
@----------------------------------
_print:
         ldr  r0, =OutFileHandle  	
         ldr  r0, [r0]            	
         ldr  r1, =OutString      	
         swi  SWI_PrStr           	
         ldr  r1, =CRLF           	
         swi  SWI_PrStr           	
		 b _process					
@----------------------------------
_exit:                            	
         swi  SWI_Exit            	
@----------------------------------
         .data
@----------------------------------
InFileHandle:  .skip 4            	
OutFileHandle: .skip 4            	
									
InFileName:    .asciz "KEY.IN"   	
									
InString:      .skip 80          	
OutString:     .skip 80          	
									
CRLF:          .byte 13, 10, 0    	
									
OutFileName:   .asciz "KEY.OUT"  	
@----------------------------------
         .end