@ Escribir el código ARM que ejecutado bajo ARMSim# lea un entero desde un archivo e imprima
@ el valor absoluto del entero. Utilizar instrucciones ejecutadas condicionalmente y no utilizar
@ bifurcaciones condicionales.

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
    .asciz "07.txt"
    
    .text
    .global _start
_start:
    @ Abrir el archivo y cargar el handler en r2
    ldr r0, =file
    mov r1, #0
    swi swi_open_file
    mov r2, r0

    @ Leer el entero y guarda valor en r3
    swi swi_read_int
    mov r3, r0

    @ Cerrar archivo
    cmp r0, r2
    swi swi_close_file

    @ check r3<0
    cmp r3, #0

    @ Si es negativo, sobre-escribir r3 con su negativo aritmetico
    mov r4, #0
    submi r3, r4, r3

    @ Imprimir el valor absoluto
    mov r0, #1
    mov r1, r3
    swi swi_print_int

    @ Salir
    swi swi_exit
    .end