;----------------------------------------------
;   Program: key.asm (MASM variant whereof)
;   
;   Functionzione:
;                Takes a stream of characters, 
;                printing only the alphabetical ones,
;                capitialzing if need be thereon. 
;
;                The Executor:
;                done per and by way,
;                of bit-twiddling tricks;
;                then shift'd as clay

;                O then the char!
;                Non alpha in kind:
;                so barred therefrom,
;                hereof's mortal bind
;   Owner: DvP
;
;   Date: Feb. 25th, 2021
;   Changes: null
;----------------------------------------------
        .model     small; 64k code and 64k data.
        .8086           ; dialect.            
        .stack     256  ; stack sz.
;----------------------------------------------

;----------------------------------------------
         .data ;start the data segment
;----------------------------------------------

;----------------------------------------------
; the block of stock, whereof the code finds abode.
;----------------------------------------------
.code ; the aforesaid.
;----------------------------------------------
; the lttrs. Whereof 'twill capitalize an individual ASCII character,
; by way of bit-wise conjunction therewith the constant appelliative
; of hexidecimal value 0xDF: thereon, the high-order (assuming conventional bit
; ordering) bits are cleared and diminutized downard, thus folding the lower-cased
; character into its conmmensurate capital variant.
;----------------------------------------------
letters:                        ;
    and dl, 0dfh                ; duplication of the below bit-twiddling.
;----------------------------------------------
; the printing, wherein the int'rupt of code is
; executed.
;----------------------------------------------
print:                          ;
    mov ah, 02h                 ; print to stdout from dl.
    int 21h                     ; int'rupt.
;----------------------------------------------
; the main loop body, wherein the cap'ing of each streamed letter,
; and verification thereof, is done.
;----------------------------------------------
my_loop:                        ;
    mov ah, 08h                 ; read from stdin into al, no echo.
    int 21h                     ; int'rupt.

    mov dl, al                  ; movs al into dl

    and al, 0dfh                ; bit-twiddling caps trick.

    sub al, 'A'                 ; in the range 'twixt [A, Z]?
    cmp al, 25                  ; does the cmp above the above.
    jbe letters                 ; jmp if so.

    cmp dl, ' '                 ; is space? jmp if so.
    je print                    ; the hereinbefore stipulated jmp.

    cmp dl, '.'                 ; is period? don't jmp.
    jne my_loop                 ; the aforesaid jmp.
;----------------------------------------------
; the exit of the program.
;----------------------------------------------
exit:                           ; header
    mov ah, 02h                 ; print to stoudt from dl.
    int 21h                     ; int'rupt.
    
    mov ah, 4ch                 ; cleanup and exit thereon.
    int 21h                     ; int'rupt.
    end my_loop                 ; end program;
;----------------------------------------------