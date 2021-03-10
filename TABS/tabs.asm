        .model     small
        .8086          
        .stack     256 
.code
   
print_space:
    mov dl, ' '
print_space_loop:
    mov ah, 02h                 ; print to stdout from dl.
    int 21h                     ; int'rupt.
    loopz print_space_loop
main_body:
    mov cl, byte ptr es:[82h]
    xor cl '0'
main_loop:
    mov ah, 08h                 ; read from stdin into al, no echo.
    int 21h                     ; int'rupt.
    mov dl, al

    cmp al, 09h
    je print_space

    mov ah, 02h                 ; print to stdout from dl.
    int 21h                     ; int'rupt.

    cmp al, 0dh
    je main_body
    cmp al, 0ah
    je main_body
    cmp al, 1ah
    je done

    loopnz main_loop
    jmp main_body

done:
    mov ah, 4ch                 
    int 21h  

    end main_body  
