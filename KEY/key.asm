        .model     small
        .8086                         
        .stack     256
.code
caps:
    sub dl, 32
print:
    mov ah, 02h
    int 21h
my_loop:
    mov ah, 08h ; read from stdin, no echo
    int 21h

    mov dl, al

    sub al, 'A'
    cmp al, 25
    jbe print

    sub al, 32
    cmp al, 25
    jbe caps

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