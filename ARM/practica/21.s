@ Escribir el código ARM que ejecutado bajo ARMSim# lea los valores de un vector (vector) de
@ longitud long_vector, sume un valor específico (valor) y guarde el resultado en otro vector
@ (vector_suma).

    .equ swi_print_int, 0x6B
    .equ swi_exit, 0x11
    .equ swi_print_str, 0x69
    .equ stdout, 1

    .data
vec:
    .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
vec1:
    .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
long_vector:
    .word 10
valor:
    .word 1
eol:
    .asciz "\n"

    .text
    .global _start
_start:
    ldr r0, =vec
    ldr r1, =vec1
    ldr r2, =long_vector
    ldr r2, [r2]
    ldr r3, =valor
    ldr r3, [r3]

loop:
    ldr r4, [r0]    @ r4 = valor del vector
    add r4, r4, r3  @ r4 = r4 + valor
    str r4, [r1]    @ vector_suma = r4
    add r0, r0, #4  @ r0 = siguiente puntero del vector
    add r1, r1, #4  @ r1 = siguiente puntero del vector_suma
    sub r2, r2, #1 @ r2 = r2 - 1
    cmp r2, #0
    bne loop        @ si r2 != 0, volver a loop

    ldr r2, =vec1
    ldr r3, =long_vector
    ldr r3, [r3]

loop_mostrar:
    cmp r3, #0
    beq exit

    ldr r0, =stdout
    ldr r1, [r2]
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str

    add r2, r2, #4
    sub r3, r3, #1
    b loop_mostrar

exit:
    swi swi_exit
    .end