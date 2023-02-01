@ Escribir el código ARM que ejecutado bajo ARMSim# lea dos enteros desde un archivo e
@ imprima:
@ El primer entero en su propia línea.
@ El resultado de aplicar NOT al primer entero en su propia línea.
@ El segundo entero en su propia línea.
@ El resultado de aplicar NOT al segundo entero en su propia línea.

    .equ swi_open_file, 0x66
    .equ swi_read_int, 0x6c
    .equ swi_print_int, 0x6b
    .equ swi_close_file, 0x68
    .equ swi_exit, 0x11
    .equ swi_print_char, 0x00
    .equ swi_print_str, 0x69

    .equ stdout, 1


    .data
file:
    .asciz "05.txt"
eol:
    .asciz "\n"
    .align
handler:
    .word 0


    .text
    .global _start
_start:
    ldr r0, =file       @ nombre de archivo de entrada
    mov r1, #0          @ modo: entrada
    swi swi_open_file   @ abre archivo
    bcs fileError       @ chequear si hubo error
    ldr r1, =handler    @ cargar dirección donde almacenar el handler
    str r0, [r1]        @ almacenar handler

read_loop:
    ldr r0, =handler    @ cargar handler
    ldr r0, [r0]
    swi swi_read_int    @ leer entero
    bcs eof             @ chequear si EoF
    @ el entero está ahora en r0

    mov r2, r0          @ copiar entero

    mov r1, r2
    bl print_int
    mov r3, #-1
    EOR r1, r2, r3      @ aplicar NOT
    bl print_int
    b read_loop

print_int:
    stmfd sp!, {r0,r1,lr}
    ldr r0, =stdout
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str
    ldmfd sp!, {r0,r1,pc}

fileError:
eof:
    swi swi_exit
    .end