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
; Owner:     Dana A. Lasher, Mike Babb (mbabb), Sanjana Cheerla (scheerl)
;
; Date:      Update Reason
; --------------------------
; 11/06/2016 Original version
;---------------------------------------
         .model    small                              ;64k code and 64k data
         .8086                                        ;only allow 8086 instructions
         public    nextval                            ;allow extrnal programs to call
;---------------------------------------
; data segment 
;---------------------------------------
         .data                                        ;data segment
    p0 db 30                                          ;number of columns (30)
;---------------------------------------
; code segment starts
;---------------------------------------           
         .code                       
;---------------------------------------
; push data onto stack
;---------------------------------------  
nextval:                                              ;Start the stack
    push bp                                           ;push base pointer
    push ax                                           ;push ax
;---------------------------------------  
; offset = (*y-1)*30 + (*x-1);
;--------------------------------------- 
calc_offset:                                          ;calculate offset
    xor ax, ax                                        ;make sure ax is 0
    add al, BYTE PTR ds:[si]                          ;move the y value into al

    add bp, ax                                        ;add ax into bp

    mov al, ds:[di]                                   ;move the x value into al
    dec ax                                            ;decrement x

    imul [p0]                                         ;multiply by num columns (30)

    add bp, ax                                        ;add x value into bp
;---------------------------------------  
; if (*direction == 1) goto testn;
; if (*direction == 2) goto teste;
; if (*direction == 3) goto tests;
; if (*direction == 4) goto testw;
;---------------------------------------  
nextval_main:                                        ;decide next value to go to
    cmp BYTE PTR ds:[bx], 3                          ;see if bx is pointing west
    je tests                                         ;if west, go to south
    ja testw                                         ;if north go to west
    cmp BYTE PTR ds:[bx], 2                          ;see if bx is pointting south
    je teste                                         ;if south go east, else go north
;---------------------------------------  
; if (maze[offset-30] == ' ')
;     {
;     *y = *y-1;
;     *x = *x;
;     *direction = 4;
;     return;
;     }
;---------------------------------------  
testn:
    cmp BYTE ptr ds:[bp - 1 - 30], ' '               ;compare to see if north is empty
    jne teste                                        ;if not empty go east
    sub WORD PTR ds:[di], 1                          ;decrement y
    mov BYTE ptr ds:[bx], 4                          ;set travel direction to north
    jmp next_val_exit                                ;exit
;---------------------------------------  
; if (maze[offset+1] == ' ')
;     {
;     *y = *y;
;     *x = *x+1;
;     *direction = 1;
;     return;
;     }
;---------------------------------------  
teste:
    cmp BYTE ptr ds:[bp - 1 + 1], ' '               ;compare to see if east is empty
    jne tests                                       ;if not empty go south
    add WORD PTR ds:[si], 1                         ;increment y
    mov BYTE ptr ds:[bx], 1                         ;set travel direction to east
    jmp next_val_exit                               ;exit
;---------------------------------------  
; if (maze[offset+30] == ' ')
;     {
;     *y = *y+1;
;     *x = *x;
;     *direction = 2;
;     return;
;     }
;---------------------------------------  
tests:
    cmp BYTE ptr ds:[bp - 1 + 30], ' '               ;compare to see if south is empty
    jne testw                                        ;if not empty go west
    add WORD PTR ds:[di], 1                          ;decrement x
    mov BYTE ptr ds:[bx], 2                          ;set travel direction to south
    jmp next_val_exit                                ;exit
;---------------------------------------  
; if (maze[offset-1] == ' ')
;     {
;     *y = *y;
;     *x = *x-1;
;     *direction = 3;
;     return;
;     }
; goto testn;
;---------------------------------------  
testw:
    cmp BYTE ptr ds:[bp - 1 - 1], ' '               ;compare to see if west is empty
    jne testn                                       ;if not empty go north
    sub WORD PTR ds:[si], 1                         ;increment x
    mov BYTE ptr ds:[bx], 3                         ;set travel direction to west
;---------------------------------------  
; remove data from stack
;---------------------------------------  
next_val_exit:                                      ;exit loop
    pop ax                                          ;pop ax
    pop bp                                          ;pop np
    ret                                             ;return
;---------------------------------------  
; end loop
;---------------------------------------  
exit:
    end                               ;add x value into bp