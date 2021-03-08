         .model     small              ;64k code and 64k data
         .8086                         ;only allow 8086 instructions
         .stack     256   

.data

.code
jmper:
    mov ax, 0ffffh
tmp:
    mov ax, 290Eh
    mov bx, 5DE8h
    mov cx, 9704h
    mov dx, 0DA59h

    mul cl

    jc jmper

    mov       ax,4c00h            ;set dos code to terminate program
    int       21h  
    end       tmp   
