@ Escribir el código ARM que ejecutado bajo ARMSim# imprima dos valores enteros definidos en
@ memoria, los reemplace por otros dos valores e imprima los dos nuevos valores.

    .equ swi_print_str, 0x69
    .equ swi_print_int, 0x6b
    .equ swi_exit, 0x11

    .data
int1: .word 5
int2: .word 10
eol:
    .asciz "\n"
    .align

    .text
    .global _start

_start:
    @ print int1
    mov r0, #1
    ldr r2, =int1
    ldr r1, [r2]
    swi swi_print_int
    
    ldr r1, =eol
    swi swi_print_str

    @ print int2
    mov r0, #1
    ldr r2, =int2
    ldr r1, [r2]
    swi swi_print_int
    
    ldr r1, =eol
    swi swi_print_str

    @ replace int1 to 20
    mov r0, #20
    ldr r2, =int1
    str r0, [r2]

    @ replace int2 to 30
    mov r0, #30
    ldr r2, =int2
    str r0, [r2]

    @ print int1
    mov r0, #1
    ldr r2, =int1
    ldr r1, [r2]
    swi swi_print_int
    
    ldr r1, =eol
    swi swi_print_str

    @ print int2
    mov r0, #1
    ldr r2, =int2
    ldr r1, [r2]
    swi swi_print_int
    
    ldr r1, =eol
    swi swi_print_str

    swi swi_exit
    .end