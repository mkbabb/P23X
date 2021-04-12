         .model     small              ;64k code and 64k data
         .8086                         ;only allow 8086 instructions
         .stack     256   
.data
p0 db 0CCh,0FDh,0BAh,001h,002h,003h,004h,005h,006h,007h,008h,009h,00Ah,00Bh,00Ch,00Dh

.code

tmp:
    mov ax, 5005h
    mov bx, 0010h
    div bx

done:
    mov       ax,4c00h            ;set dos code to terminate program
    int       21h  
    end       tmp   
