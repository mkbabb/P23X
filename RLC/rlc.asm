;---------------------------------------------------------------------
;  Program:      Run Length Coding
;
;  Function:     Decompresses 1 dimensional run lengths
;                This subroutine links with a C main program
;
;                Add your additional functional comments
;
;  Owner:
;
;  Changes:
;  Date          Reason
;  ----          ------
;  05/16/2017    Original version ... coded to spec design
;---------------------------------------------------------------------
         .model    small
         .8086
         public    _rlc
;---------------------------------------
         .data                         ;start the data segment
;---------------------------------------
    run         db 2 dup (?)         
    pels_left   db 80
    cur         db 32
;---------------------------------------
         .code                         ;start the code segnment
;---------------------------------------
; Save the registers ... 'C' requires (bp,si,di)
; Access the input and output lists
;---------------------------------------
_rlc:                                  ;
    push      bp                  ;save 'C' register
    mov       bp,sp               ;set bp to point to stack
    push      si                  ;save 'C' register
    push      di                  ;save 'C' register
    mov       si, [bp + 4]           ;si points to the input compressed data
    mov       di, [bp + 6]           ;di points to the empty output buffer
;---------------------------------------
main_body:
    mov al, [si] ; code
    inc si

    cmp al, 0
    je exit

    mov [run], al
    mov [run + 1], al

    mov cl, 4
    shr [run], cl
    
    and [run + 1], 0fh

    xor bx, bx ; i
    xor cx, cx ; len

for_loop:
    cmp bx, 2
    jae main_body

pels_left_test:
    cmp [pels_left], 0
    jne run_test

    mov [pels_left], 80
    mov [cur], 32

run_test:
    cmp [run + bx], 15
    je run_test_if

    mov cl, [run + bx]
    jmp while_loop_test
run_test_if:
    mov cl, [pels_left]

while_loop_test:
    mov dl, [cur]
    cmp cl, 0
    je cur_test
while_loop: 
    mov [di], dl
    inc di

    dec [pels_left]
    loop while_loop

cur_test:
    inc bx    

    cmp cur, 32
    je cur_set_black

cur_set_white:
    mov cur, 32
    jmp for_loop
cur_set_black:
    mov cur, 219
    jmp for_loop

;---------------------------------------
; Restore registers and return
;---------------------------------------
exit:                                  ;
    pop       di                  ;restore 'C' register
    pop       si                  ;restore 'C' register
    pop       bp                  ;restore 'C' register
    ret                           ;return
;---------------------------------------
    end

