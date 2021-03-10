        .model     small
        .8086          
        .stack     256 
.code
   
print_space:
    mov dl, ' '
print_space_loop:
    int 21h                     ; int'rupt 2 print.
    loopz print_space_loop
main_body:
    mov cl, byte ptr es:[82h]
    sub cl, '0'
    jnc main_loop
    
    mov cl, 10
main_loop:
    mov ah, 08h                 ; read from stdin into al, no echo.
    int 21h                     ; int'rupt thereof.
    mov dl, al

    mov ah, 02h                 ; code 2 print; will be int'rupt'd later.

    cmp al, 09h
    je print_space              

    int 21h                     ; int'rupt 2 print.

    cmp al, 0dh                 ; a \n? jmp to reset tab counter.
    je main_body                
    cmp al, 0ah                 ; a \r? jmp to reset tab counter.
    je main_body
    cmp al, 1ah                 ; a EOF? jmp to done.
    je done

    loopnz main_loop
    jmp main_body               
done:
    mov ah, 4ch                 
    int 21h  

    end main_body  
