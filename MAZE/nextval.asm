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
         .code                       
nextval:
    push ax
    push cx
    push bp
calc_offset:
    xor ax, ax
    xor cx, cx

    mov al, BYTE PTR ds:[di]
    sub ax, 1
    
    mov cl, 30
    mul cl

    add al, BYTE PTR ds:[si]
    sub ax, 1

    add bp, ax
nextval_main:
    cmp BYTE PTR ds:[bx], 1
    je testn
    cmp BYTE PTR ds:[bx], 2
    je teste
    cmp BYTE PTR ds:[bx], 3
    je tests
    cmp BYTE PTR ds:[bx], 4
    je testw
testn:
    cmp BYTE ptr ds:[bp - 30], ' '

    jne teste

    sub BYTE PTR ds:[di], 1

    mov BYTE ptr ds:[bx], 4
    jmp next_val_exit
teste:
    cmp BYTE ptr ds:[bp + 1], ' '

    jne tests

    add BYTE PTR ds:[si], 1

    mov BYTE ptr ds:[bx], 1
    jmp next_val_exit
tests:
    cmp BYTE ptr ds:[bp + 30], ' '

    jne testw

    add BYTE PTR ds:[di], 1

    mov BYTE ptr ds:[bx], 2
    jmp next_val_exit
testw:
    cmp BYTE ptr ds:[bp - 1], ' '

    jne testn

    sub BYTE PTR ds:[si], 1

    mov BYTE ptr ds:[bx], 3
    jmp next_val_exit

next_val_exit:
    pop bp
    pop cx
    pop ax
    ret

exit:
    end   