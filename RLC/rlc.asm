;---------------------------------------------------------------------
;  Program:      Run Length Coding
;
;  Function:     Decompresses 1 dimensional run lengths
;                This subroutine links with a C main program
;
;                This subroutine performs the functions necessary to
;                decompress the exisiting RLC representation.
;                
;                INPUT:
;                -   a pointer to compressed data containg contating 
;                    strings of runs and feature
;                -   a pointer to a buffer to store decompressed data
;                
;                OUTPUT:
;                -   decompressed data in the input buffer pointer
;                -   restored C registers 
;
;  Owner:        mbabb, scheerl
;
;  Changes:      Added all data code, last 2 lines of _rlc and 
;                everything else except exit
;
;  Date          Reason
;  ----          ------
;  05/16/2017    Original version ... coded to spec design
;  03/12/2021    Added program functionality
;---------------------------------------------------------------------
         .model    small
         .8086
         public    _rlc
;---------------------------------------
         .data                         ;start the data segment
;---------------------------------------
    run         db 2 dup (?)         
    pels_left   db 80                  ;set pels left to 80
    black db 219                       ;set black to 219
    cur db 32                          ;set white to 32
;---------------------------------------
         .code                         ;start the code segnment
;---------------------------------------
; Save the registers ... 'C' requires (bp,si,di)
; Access the input and output lists
; pels_left = 80;
; cur = wh;
;---------------------------------------
_rlc:                                  
    push      bp                       ;save 'C' register
    mov       bp,sp                    ;set bp to point to stack
    push      si                       ;save 'C' register
    push      di                       ;save 'C' register
    mov       si, [bp + 4]             ;si points to the input compressed data
    mov       di, [bp + 6]             ;di points to the empty output buffer
    mov ax, ds                         ;move ds to ax
    mov es, ax                         ;move ax into extra segment
;---------------------------------------
; the main loop of the subroutine
; while(1) {
; code = *comp;
; comp++;
; if ( code == 0 ) return(0);
; run[0] = (unsigned char)(code >> 4)
; run[1] = (unsigned char)(code << 4)
;---------------------------------------
main_body:
    lodsb                              ;mov al, increment si
    cmp al, 0                          ;compare al to 0
    je exit                            ;if 0 jump to exit loop
    mov [run], al                      ;move al into run
    mov [run + 1], al                  ;move al into run + 1
    mov cl, 4                          ;move cl into 4
    shr [run], cl                      ;shift right run by 4
    and [run + 1], 0fh                 ;clear high order bits of run + 1
    xor bx, bx                         ;set bx to 0
    xor cx, cx                         ;set cx to 0
    mov al, [cur]                      ;move cur to al
    call for_looper                    ;call for looper subroutine
    inc bx                             ;increment bx by 1
    call for_looper                    ;call for looper subroutine again
    mov [cur], al                      ;move al into cur
    jmp main_body                      ;start main loop again
;---------------------------------------
; for loop sub routine
; for ( i = 0; i < 2; i++ )
;---------------------------------------
for_looper:
    cmp [pels_left], 0                 ;compare pels left to 0
    jne run_test                       ;if not 0 jump to run test
    mov [pels_left], 80                ;move 80 into pels left
    mov al, 32                         ;move 32 into al
    mov [black], 219                   ;move 219 into black
;---------------------------------------
; run test loop to do if else statements
; from c psuedo code
; if i = 0   dl = [run+0]
; if i = 1   dl = [run+1]
;---------------------------------------
run_test:
    cmp [run + bx], 15                 ;compare to see if run[bx] is 15
    je run_test_if                     ;if so jump to run_test_if
    mov cl, [run + bx]                 ;move run[bx] to cl
    jmp while_loop_test                ;jump to while_loop_test
;---------------------------------------
; move pels left into cl
; if ( pels_left == 0 ) {
; pels_left = 80;
; cur = wh;
; }
;---------------------------------------
run_test_if:
    mov cl, [pels_left]                ;move pels left into cl
;---------------------------------------
; decrement pels left by cl
; if ( run[i] == 15) len = pels_left;
; else len = run[i];
;---------------------------------------
while_loop_test:
    sub [pels_left], cl                ;decrement pels left by cl
;---------------------------------------
; do inner while loop
; while ( len > 0 )
; *dcomp = cur;
; dcomp ++;
; len--;
; pels_left--;
;---------------------------------------
while_loop: 
    rep stosb                          ;increment curr pointer, decrement len and pels left all by 1
;---------------------------------------
; cur test loop exchange black into al
; if ( cur == wh ) cur = bl;
; else cur = wh;
;---------------------------------------
cur_test:
    xchg al, [black]                   ;swap black into al
    ret                                ;return
;---------------------------------------
; Restore registers and return
;---------------------------------------
exit:                             
    pop       di                       ;restore 'C' register
    pop       si                       ;restore 'C' register
    pop       bp                       ;restore 'C' register
    ret                                ;return
;---------------------------------------
    end                           ;end

