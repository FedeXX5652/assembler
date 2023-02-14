@ recorrer un vector, hacerles AND contra una constante y guardar todos los resultados en un archivo

    .equ swi_exit, 0x11
    .equ swi_print_int, 0x6b
    .equ swi_print_str, 0x69
    .equ swi_open_file, 0x66
    .equ swi_close_file, 0x68
    .equ stdout, 1

    .data

file_out:
    .asciz "out.txt"
eol:
    .asciz "\n"
    .align
vec:
    .word 1,2,3,4,5,6,7,8
long_vec:
    .word 8
const:
    .word 4

    .text
    .global _start
_start:
    ldr r2, =vec    @ r2 apunta al vector
    ldr r3, =long_vec
    ldr r3, [r3]    @ r3 tiene el tamaño del vector
    ldr r4, =const  @ r4 apunta a la constante a sumar
    ldr r4, [r4]    @ r4 tiene el valor de la constante

loop:
    ldr r0, [r2], #4    @ r0 tiene el valor del vector
    and r1, r0, r4  @ r0 tiene el valor del vector AND constante
    bl save_int
    subs r3, r3, #1 @ r3 tiene el tamaño del vector - 1
    bne loop
    b end

save_int:   @ r0 tiene el valor a guardar
    stmfd sp!, {r0,r1, lr}
    mov r2, r1
    ldr r0, =file_out
    mov r1, #2
    swi swi_open_file
    bcs end
    mov r1, r2
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str
    swi swi_close_file
    ldmfd sp!, {r0,r1, pc}

end:
    swi swi_exit
    .end
