;----------------------------------------------
;   Program: tabs.asm (MASM variant whereof)
;   
;   Functionzione:
;                Takes a stream of characters 
;                and outputs every tab therein,
;                expanded as a space'd char,
;                whereof's count is bound by race.  
;                
;                
;   Owner: DvP
;
;   Date: Marz. 9th, 2021
;   Changes: null
;----------------------------------------------
        .model     small; 64k code and 64k data.
        .8086           ; dialect.            
        .stack     256  ; stack sz.
.code
;----------------------------------------------
; main print space body,
; whereof expands the tab,
; by amount equal to,
; tab_amount - counter.
;----------------------------------------------
print_space:
    mov dl, ' '                 ; moves char ' ' into dl.
;----------------------------------------------
print_space_loop:
    int 21h                     ; int'rupt 2 print.
    loopz print_space_loop      ; loop whilst cx != 0

;----------------------------------------------
; main function body;
; reads in the chars,
; transforms if behooveful,
; and prints thereon.
;----------------------------------------------
main_body:
    mov cl, byte ptr es:[82h]   ; reads a command line arg in.
    sub cl, '0'                 ; converts to an int.
    jnc main_loop               ; if the command line arg was 0,
                                ; default to 10;
    mov cl, 10                  ; defs.
;----------------------------------------------
main_loop:
    mov ah, 08h                 ; read from stdin into al, no echo.
    int 21h                     ; int'rupt thereof.
    mov dl, al                  ; copies al to dl.

    mov ah, 02h                 ; code 2 print; will be int'rupt'd later.

    cmp al, 09h                 ; a \t? jmp to print the consonant
    je print_space              ; space count.

    int 21h                     ; int'rupt 2 print.

    cmp al, 0dh                 ; a \n? jmp to reset tab counter.
    je main_body                ; jmping.
    cmp al, 0ah                 ; a \r? jmp to reset tab counter.
    je main_body                ; jmping.
    cmp al, 1ah                 ; a EOF? jmp to done.
    je done                     ; jmping.

    loopnz main_loop            ; loop with the cx variable as counter.
    jmp main_body               ; if cx has gone < 0, reset the counter.

;----------------------------------------------
; the final executor,
; foreswear no hope,
; ye who enter here;
; we've made it!
;----------------------------------------------
done:
    mov ah, 4ch                 ; opcode to exit gracefully.      
    int 21h                     ; the executor of the above,
                                ; a beatitude, grace hereof.
    end main_body               ;
