    .model    small               ;4 segments of 64KB
    .8086                         ;only  8086 instructions
    .stack    256                 ;stack size is 256 bytes
    extern    output:proc         ;output subroutine is in another file

    .data   
k    real4     10.0
l    real4     5.0
m    real4     -2.0
res  real4     0.0

    .code
start: 
    fld    [l]
    fld    [k]
    fld    [k]
    fld    [l]
    fld    [m]
    fmul
    fdiv
    fsub
    fadd
    fstp [res]

    fld [res]
    call      output     
    fstp [res]         
done:                               
    mov       ax, 4c00h            ;set DOS termination code
    int       21h                 ;terminate

    end       start