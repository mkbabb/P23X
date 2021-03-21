         .model     small              ;64k code and 64k data
         .8086                         ;only allow 8086 instructions
         .stack     256   
.data
p0 dw 7fffh

.code

; subr:   push  ax                                              
;         push  si                                              
;         mov   ax,[si]                                         
;         mov   [si],ah                                         
;         mov   [si+1],al  

;         mov bx, [WORD PTR si]

;         pop   si                                              
;         pop   ax                                              
;         ret  

subr:       mov  bx,2                                             
            mov  cx,1                                             
            mov  ax,[si]                                          
            mul  bx                                               
            jc   subret                                           
            div  cx                                               
subret:     ret    

tmp:
    call subr
done:
    mov       ax,4c00h            ;set dos code to terminate program
    int       21h  
    end       tmp   
