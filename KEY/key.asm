        .model     small
        .8086                         
        .stack     256
.code

letters:
    and dl, 0dfh
print:  
    mov ah, 02h
    int 21h
my_loop:
    mov ah, 08h ; read from stdin, no echo
    int 21h

    mov dl, al
    and al, 0dfh
    
    sub al, 'A'
    cmp al, 25
    jbe letters

    cmp dl, ' '
    je print
    cmp dl, '.'
    jne my_loop
exit:
    mov ah, 02h
    int 21h

    mov ax, 4c00h
    int 21h
    end my_loop