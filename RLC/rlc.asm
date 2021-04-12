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

cur_set:
    mov dl, 32
;---------------------------------------
main_body:
    mov al, byte ptr [si]; al = code
    inc si

    cmp al, 0
    je exit

    mov ah, al

    mov cl, 4
    shr al, cl
    
    and ah, 0fh

    mov [run], al
    mov [run + 1], ah

    xor bx, bx ; i variable
    xor cx, cx ; len variable

for_loop:
    cmp bx, 2
    jge main_body
    inc bx

pels_left_test:
    cmp [pels_left], 0
    jne run_test

    mov [pels_left], 80
    mov dl, 32

run_test:
    cmp [run + bx], 15
    je run_test_if
    mov cl, [run + bx]
    jmp while_loop
run_test_if:
    mov cl, [pels_left]
while_loop: 
    mov byte ptr [di], dl
    inc di
    dec [pels_left]
    loop while_loop

cur_test:
    cmp dl, 32
    jne cur_set
    mov dl, 219
    jmp main_body
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