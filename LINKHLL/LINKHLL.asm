;-----------------------------------------------------------
; Program: Linkhll
;
; Function: Function to link a high level language, C, 
;           and thereupon complete the following task,
;           find the subset maxima of cardinality 2,
;           and perform a multiplicaiton reduction withal.
;           
;           For it is linked,
;           That is to say,
;           Wherefore doth thinked,
;           Surely as night cometh day.
;
; Owner: D.v.P.
;
; Date:
;       11/21/2016   Original Version
;---------------------------------------
         .model    small               ; small sz.
         .8086                         ; 8086 set.
         public    _linkhll            ; public funx.
;---------------------------------------

;---------------------------------------
    .code
;---------------------------------------
; Code Segment; scilicet, the segment wherein code is executed
;---------------------------------------
_linkhll:
    push    bp                          ; save bp.             
    mov bp, sp                          ; we only care about the sp.
    mov ax, [bp+4]                      ; set ax to val 1.
    mov bx, [bp+6]                      ; set bx to val 2.
;---------------------------------------
cmp0:               
    cmp ax, bx                          ; ax > bx?
    jae  cmp1                           ; jmp if so.
    xchg ax, bx                         ; else, exchange.
;---------------------------------------
; The first compare, wherein a loop is formed;
; Compared, intelligibly to the spokes of the wheel,
; exaltant in its grand allegory.
;---------------------------------------
cmp1:
    cmp bx, [bp+8]                      ; bx > val 3?
    jae cmp2                            ; jmp if so.
    xchg bx, [bp+8]                     ; else, exchange, but we can't gurantee that ax was the max val.
    jmp cmp0                            ; so we check again, jmping to cmp0.
;---------------------------------------
; The second compare; penultima.
;---------------------------------------
cmp2:                   
    cmp bx, [bp+10]                     ; bx > val 3?
    jae done                            ; jmp if so.
    mov bx, [bp+10]                     ; else, we've already excluded vals 1 and 2, so the only option 4.
;---------------------------------------
; Finale ultimo: viva allegro con brio con giocoso
;---------------------------------------
done:
    mul bx                              ; mul is commutative, so we mul bx.
    pop bp                              ; restore bp.
    ret                                 ; the ret.
    end                                 ; fin.
;---------------------------------------

