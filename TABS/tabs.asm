        .model     small
        .8086          
        .stack     256 
.code
string_to_int:
    xor bx, bx
loop_string_to_int:



main:
    cmp byte ptr es:[80h],0
    je noclp
    mov al, byte ptr es:[82h]

    
    mov al, 5
    mov cx, 10
    imul al
    
    mov ah, 4ch                 
    int 21h                     
    end main  
