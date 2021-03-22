;---------------------------------------------------------------------
; Program:   nextval subroutine
;
; Function:  Find next mouse move in an array 15 by 30.
;            We can move into a position if its contents is blank ( 20h ).
;
; Input:     Calling sequence is:
;            x    pointer   si
;            y    pointer   di
;            dir  pointer   bx
;            maze pointer   bp
;
; Output:    x,y,dir modified in caller's data segment
;
; Owner:     Dana A. Lasher
;
; Date:      Update Reason
; --------------------------
; 11/06/2016 Original version
;---------------------------------------
         .model    small               ;64k code and 64k data
         .8086                         ;only allow 8086 instructions
         public    nextval             ;allow extrnal programs to call
;---------------------------------------
         .data  
p0 db 30                    
         .code                       
nextval:
    push bp
    push ax
    push cx

calc_offset:
    xor ax, ax

    mov al, ds:[di] 
    sub ax, 1
    
    mov cx, 30
    mul cl

    mov cl, BYTE PTR ds:[si]

    add ax, cx
    
    add bp, ax

nextval_main:
    cmp BYTE PTR ds:[bx], 2
    je testw
    jb tests
    cmp BYTE PTR ds:[bx], 4
    je teste
testn:
    cmp BYTE ptr ds:[bp - 1 - 30], ' '
    jne testw
    sub WORD PTR ds:[di], 1
    mov BYTE ptr ds:[bx], 4
    jmp next_val_exit
teste:
    cmp BYTE ptr ds:[bp - 1 + 1], ' '
    jne testn
    add WORD PTR ds:[si], 1
    mov BYTE ptr ds:[bx], 1
    jmp next_val_exit
tests:
    cmp BYTE ptr ds:[bp - 1 + 30], ' '
    jne teste
    add WORD PTR ds:[di], 1
    mov BYTE ptr ds:[bx], 2
    jmp next_val_exit
testw:
    cmp BYTE ptr ds:[bp - 1 - 1], ' '
    jne tests
    sub WORD PTR ds:[si], 1
    mov BYTE ptr ds:[bx], 3
next_val_exit:
    pop cx
    pop ax
    pop bp
    ret

exit:
    end   