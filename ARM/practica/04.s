    .equ swi_open, 0x66
    .equ swi_read_int, 0x6c
    .equ swi_print_int, 0x6b
    .equ swi_close, 0x68
    .equ swi_exit, 0x11

    .data
file:
    .asciz "04.txt"
    .align

    .text
    .global _start

_start:
    ldr r0, =file
    mov r1, #0
    swi swi_open
    mov r4, r0      @ copia el handler en r4
    swi swi_read_int
    mov r1, r0
    mov r0, #0
    swi swi_print_int
    mov r0, r4
    swi swi_close
    swi swi_exit
    .end