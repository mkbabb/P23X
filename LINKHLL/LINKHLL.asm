;-----------------------------------------------------------
;
; Program: Linkhll
;
; Function:
;
; Owner:
;
; Date:
; 11/21/2016   Original Version
;
;
;---------------------------------------
         .model    small               ;
         .8086                         ;
         public    _linkhll            ;
;---------------------------------------

;---------------------------------------

         .code
;---------------------------------------
;
; Code Segment
;
;---------------------------------------
_linkhll:
    push    bp                  
    mov bp, sp               
    mov ax, [bp+4]           
    mov bx, [bp+6]
tmp0:
    cmp ax, bx
    jae  tmp1 
    xchg ax, bx
tmp1:
    cmp bx, [bp+8]
    jae tmp2
    xchg bx, [bp+8]
    jmp tmp0
tmp2:
    cmp bx, [bp+10]
    jae done
    mov bx, [bp+10]
done:
    mul bx
    pop bp
    ret
    end
;---------------------------------------

