         .model     small              ;64k code and 64k data
         .8086                         ;only allow 8086 instructions
         .stack     256   
.data
    ; mercury         db      5, 10, -5
    ; venus           db      'a', 'b', 'c'
    ; earth           dw      1, 2, 3
    ; mars            db      '$'
    ; p0 db  008h, 000h, 002h, 000h, 000h, 000h, 004h, 000h, 0FFh, 0FFh, 006h, 000h, 000h, 002h, 000h, 001h
    p0 db  008h, 000h, 002h, 000h, 000h, 000h, 004h, 000h, 0FFh, 0FFh, 006h, 000h, 000h, 002h, 000h, 001h
.code

tmp:
    ; mov cx, @data
    ; mov ax, 0CF17h
    ; mov bx, 011F1h
    ; add ax, bx
    ; mov ax, 0b20h

    ; mov al, 140
    ; mov bl, 107

    ; mov al, 0E7h
    ;   cbw
    ;   mov cl, 10
    ;   idiv cl

    ; add al, bl

    ; mov ax, 200h
    ; mov bx, 400h
    ; mul bx

    ; mov ax, 0000Ah
    ; mov bx, 00002h
    ; mov cx, 00003h
    ; mov dx, 0000Bh

    ; mul bl
    ; div dl

    ; mov ax, 200h
    ; mov bx, 400h
    ; mul bx

    ; mov ax, 00014h
    ; mov bx, 00919h
    ; mov cx, 0A00Ah
    ; mov dx, 0F00Fh

    ; imul cx

    mov       ax,@data
    mov       ds,ax

    ; mov si, 0006h
    ; mov di, [si + 3]

    mov bx, 0002h

    mov BX, [BX]
    mov BX, [BX]
    mov BX, [BX]

    ; mov bp, 0420h
    ; mov di, 0140h

    ; mov AX, [BP + DI + 8]


    ; mov bx, [earth]
    ; mov al, bh
 

done:
    mov       ax,4c00h            ;set dos code to terminate program
    int       21h  
    end       tmp   
