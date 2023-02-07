@ Codificar un programa en assembler ARM de 32 bits que recorra un vector de enteros y los imprima
@ por la salida estándar agregando la leyenda “PAR” a continuación de todos aquellos números que así lo sean.

    .equ swi_open_file, 0x66
    .equ swi_read_int, 0x6c
    .equ swi_print_int, 0x6b
    .equ swi_close_file, 0x68
    .equ swi_exit, 0x11
    .equ swi_print_char, 0x00
    .equ swi_print_str, 0x69

    .equ stdout, 1

    .data
vec:
    .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
eol:
    .asciz "\n"
par:
    .asciz "PAR: "

    .text
    .global _start
_start:
    ldr r2, =vec
    ldr r3, =10     @ tamaño del vector
loop:
    bl es_par
    add r2, r2, #4
    subs r3, r3, #1
    bne loop
    b exit

es_par:
    stmfd sp!, {r0,r1,lr}
    ldr r0, [r2]
    ands r0, r0, #1
    beq print_par
    bne print_impar

print_impar:
    stmfd sp!, {r0,r1,lr}
    ldr r0, =stdout
    ldr r1, [r2]
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str
    ldmfd sp!, {r0,r1,pc}

print_par:
    stmfd sp!, {r0,r1,lr}
    ldr r0, =stdout
    ldr r1, =par
    swi swi_print_str
    ldr r1, [r2]
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str
    ldmfd sp!, {r0,r1,pc}

exit:
    swi swi_exit
    .end