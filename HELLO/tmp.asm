         .model     small              ;64k code and 64k data
         .8086                         ;only allow 8086 instructions
         .stack     256   
.data
p0 db  05Bh, 039h, 053h, 0D9h, 0FAh, 0EBh, 0CAh, 005h, 0FEh, 089h, 036h, 035h, 052h, 01Eh, 000h, 07Dh
p1 db  0CBh, 0FFh, 0BAh, 073h, 0B8h, 00Bh, 058h, 091h, 0BBh, 032h, 09Dh, 0DAh, 0D7h, 034h, 0D3h, 0C0h
p2 db  0C9h, 0ABh, 0BFh, 046h, 09Ch, 04Ch, 0D4h, 062h, 078h, 06Ah, 0A7h, 0A5h, 0BBh, 0BBh, 0A3h, 01Dh
p3 db  04Ah, 05Fh, 0FEh, 07Bh, 02Ah, 01Eh, 0EBh, 071h, 04Ah, 0F2h, 012h, 05Eh, 0A3h, 0C5h, 03Dh, 02Dh

.code
tmp:
    mov si, 0011h
    mov di, 0009h
    mov bx, 001Ch
    mov bp, 00FAh

    mov ax, @data
    mov ds, ax

    xor ax, ax

    mov al,[p0 + bx] 

    mov al,[p0 + si] 
    
    mov al,[p0 + di] 
    
    mov al,[p0 + di+1] 
    
    mov al,[p0 + di-1] 

    mov ax,[WORD PTR p0 + bx] 

    mov ax,[WORD PTR p0 + si] 

    mov ax,[WORD PTR p0 + di] 

    mov ax,[WORD PTR p0 + si+7] 

    mov ax,[WORD PTR p0 + di+12] 

    mov ax,[WORD PTR p0 + bx-13] 

    mov ax,[WORD PTR p0 + bx+si] 

    mov ax,[WORD PTR p0 + bx+di] 

    mov ax,[WORD PTR p0 + bx+si+4] 

    mov ax,[WORD PTR p0 + bx+di-9] 

    mov       ax,4c00h            ;set dos code to terminate program
    int       21h  
    end       tmp   
