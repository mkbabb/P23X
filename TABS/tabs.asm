        .model     small
        .8086          
        .stack     256 
.code
   
default:
    mov bl, 10
    jmp main_body

get_tab_count:
    cmp byte ptr es:[80h],0
    je default

    mov bl, byte ptr es:[82h]
    sub bl, '0'
   
main_body:
    xor cx, cx
    mov cl, bl

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

    dec cx
    jcxz main_body
    jmp main_loop

print_space:
    mov dl, ' '
print_space_loop:
    mov ah, 02h                 ; print to stdout from dl.
    int 21h                     ; int'rupt.
    loop print_space_loop

    jmp main_body

done:
    mov ah, 4ch                 
    int 21h  

    end get_tab_count  
