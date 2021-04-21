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

    black db 219
    cur db 32
    divider db 16

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
    
    mov ax, ds
    mov es, ax
;---------------------------------------
main_body:
    lodsb

    cmp al, 0
    je exit

    mov [run + 1], al
    and [run + 1], 0fh

    div [BYTE PTR divider]
    ; mov cl, 4
    mov [run], al
    ; shr [run], cl


    xor bx, bx ; i
    ; xor cx, cx ; len

    mov al, [cur]

    call for_looper
    mov bx, 1
    call for_looper

    mov [cur], al

    jmp main_body
for_looper:
    cmp [pels_left], 0
    jne run_test

    mov [pels_left], 80
    mov al, 32
    mov [black], 219
run_test:
    cmp [run + bx], 15
    je run_test_if

    mov cl, [run + bx]
    jmp while_loop_test
run_test_if:
    mov cl, [pels_left]

while_loop_test:
    sub [pels_left], cl

while_loop: 
    rep stosb

cur_test:
    xchg al, [black]
    ret

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