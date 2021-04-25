;---------------------------------------------------------------------
; Program:   MOV
;
; Function: 
;           Takes an ASCII char (x value), a number (y value),
;           and a computation operand (z value).
;
;           If the operand is "+",
;           the y value is added to x,
;           and the result is thereon printed.

;           Else the operand like of not,
;           the y value is unused,
;           and the x value remains stinted.
;            
; Input:    x: ASCII char; A-Z
;           y: ASCII number; 0-9    
;           z: ASCII operand; "+", or anything else.
; Output:    
;
; Owner:     Sanjana Cheerla (scheerl), Mike Babb (mbabb)
;
; Date:      04/23/2021
;----------------------------------
         .model    small          ;4 64KB segments
         .8086                    ;only 8086 instructions
         .stack    256            ;256 byte stack
;----------------------------------

;----------------------------------
         .data                    ;data
;----------------------------------
x       db        0              ;variable x
x_if_plus db        0            ;variable x_if_plus; used for if statement simulation.
y       db        0              ;variable y
z       db        0              ;variable z
inctbl  db        000, 001, 002, 003, 004, 005, 006, 007, 008, 009 ; conversion table of ascii + offset.
        db        010, 011, 012, 013, 014, 015, 016, 017, 018, 019 ;
        db        020, 021, 022, 023, 024, 025, 026, 027, 028, 029 ;
        db        030, 031, 032, 033, 034, 035, 036, 037, 038, 039 ;
        db        040, 041, 042, 043, 044, 045, 046, 047, 048, 049 ;
        db        050, 051, 052, 053, 054, 055, 056, 057, 058, 059 ;
        db        060, 061, 062, 063, 064, 065, 066, 067, 068, 069 ;
        db        070, 071, 072, 073, 074, 075, 076, 077, 078, 079 ;
        db        080, 081, 082, 083, 084, 085, 086, 087, 088, 089 ;
        db        090, 091, 092, 093, 094, 095, 096, 097, 098, 099 ;
        db        100, 101, 102, 103, 104, 105, 106, 107, 108, 109 ;
        db        110, 111, 112, 113, 114, 115, 116, 117, 118, 119 ;
        db        120, 121, 122, 123, 124, 125, 126, 127, 128      ;
;----------------------------------


;----------------------------------
         .fardata                 ;256 bytes of work memory for selection code
;----------------------------------
        db        256 dup(0)      ;byte vars need 256 bytes of work memory
;----------------------------------
;----------------------------------
         .code                    ;Program
;----------------------------------
;----------------------------------
; Start of the code, whereof will execute the above funcs.
;----------------------------------
start:  mov       ax,@data          ;initialize
        mov       ds, ax            ;the ds register
        mov       ax,@fardata       ;initialize
        mov       es, ax            ;the es register
        mov       bx, 0             ;clear bx as pointer register
;----------------------------------
; Read and echo x
;----------------------------------
        mov       ah, 8             ;read code
        int       21h               ;read interrupt
        mov       [x], al           ;save x
        mov       dl, al            ;ready to echo x
        mov       ah, 2             ;write code
        int       21h               ;write interrupt
;----------------------------------
; Read and echo y
;----------------------------------
        mov       ah, 8             ;read code
        int       21h               ;read interrupt
        mov       [y], al           ;save y
        mov       dl, al            ;ready to echo y
        mov       ah, 2             ;write code
        int       21h               ;write interrupt
;----------------------------------
; Read and echo z
;----------------------------------
        mov       ah, 8             ;read code
        int       21h               ;read interrupt
        mov       [z], al           ;save z
        mov       dl, al            ;ready to echo z
        mov       ah, 2             ;write code
        int       21h               ;write interrupt
;--------------------------------------------------
; ASCII 2 hex conversion
; Uses the aforecoded inc table.
;--------------------------------------------------
        mov bl, [y]                 ;load y
        mov al, [inctbl + bx - 48]  ;convert y (ascii digit) to hex (offset of 48 b/c '0' is 48 decimal)
        mov di, ax                  ;save cx val to di

        mov bl, [x]                 ;load x
        mov al, [inctbl + bx + di]  ;shift x's value by the y offset within di.
        mov [x_if_plus], al         ;save value to register, whereof's only used if z == +.

;--------------------------------------------------
; Comparison of z to +. 
; If z == '+', we print the shifted value calculated above
; Else, we print just x
;--------------------------------------------------
        mov       bl, [z]           ; load z
        mov  byte ptr es:[bx], 0    ; set position of [z] to 0 .
                            
        mov       bl, '+'           ; load + char    
        mov  byte ptr es:[bx], 1    ; set position of aforesaid to 1.
                                
        mov       bl, [z]           ; load z      
        mov       bl, es:[bx]       ; overrite z's original 0 value if z == '+' (if statement). 

        mov  dl, byte ptr[x + bx]   ; load either x, or x_if_plus, into the dl register for printing.

        mov       ah, 2             ;write code
        int       21h               ;write interrupt
;--------------------------------------------------
; End of the line for this our code,
; Fare thee well, our sweet lux'd abode.
;--------------------------------------------------
        mov       ax, 4c00h         ;get the termination code
        int       21h               ;terminate

        end       start             ;end program
