@ Codificar un programa en assembler ARM de 32 bits que recorra un vector de enteros
@ y genere un archivo de salida con el resultado de aplicar la función AND en cada uno de los elementos del vector original contra una constante

    .equ swi_open_file, 0x66
    .equ swi_read_int, 0x6c
    .equ swi_print_int, 0x6b
    .equ swi_close_file, 0x68
    .equ swi_exit, 0x11
    .equ swi_print_char, 0x00
    .equ swi_print_str, 0x69

    .equ stdout, 1

    .data
out_file:
    .asciz "08_out.txt"
vec:
    .word 1,2,3,4,5,6,7,8
handler:
    .word 0
eol:
    .asciz "\n"
    .align

    .text
    .global _start
_start:
    ldr r2, =vec
    ldr r3, =long_vec
    mov r3, #8

    ldr r0, =out_file
    mov r1, #2      @ abro el file en append mode
    swi swi_open_file
    bcs exit
    ldr r1, =handler
    str r0, [r1]

loop:
    ldr r4, [r2]    @ valor del vector en r4
    and r4, r4, #4  @ and del valor del vector y una constante en r4
    bl print
    add r2, r2, #4  @ siguiente puntero a valor del vector en r2
    subs r3, r3, #1 @ resto uno a la long del vector
    bne loop        @ si no es 0 loopeo
    b eov

save:
    stmfd sp!, {r0,r1,lr}
    ldr r0, =handler

print:
    stmfd sp!, {r0,r1,lr}
    ldr r0, =stdout
    mov r1, r4
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str
    ldmfd sp!, {r0,r1,pc}

    ldmfd sp!, {r0,r1,pc}

eov:
    ldr r0, =handler
    swi swi_close_file
exit:
    swi swi_exit
    .end