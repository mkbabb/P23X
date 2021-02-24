section .data
msg      db        'Hello World'       ;the hello world message
eol      db        13,10               ;cr/lf = \n in c++
term     db        '$'
msglen   dw        term-msg+1  


section .text
main:
    mov edx, msglen
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ebx, 0
    mov eax, 1
    int 0x80