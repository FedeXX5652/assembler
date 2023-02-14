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
eol:
    .asciz "\n"
    .align
handler:
    .word 0

    .text
    .global _strart
_start:
    mov r4, #0
    ldr r0, =file
    mov r1, #0
    swi swi_open_file
    bcs file_error
    ldr r1, =handler
    str r0, [r1]

loop:
    ldr r0, =handler
    ldr r0, [r0]
    swi swi_read_int
    bcs eof
    add r4, r4, r0
    b loop

eof:
    ldr r0, =stdout
    mov r1, r4
    swi swi_print_int
    ldr r0, =handler
    ldr r0, [r0]
    swi swi_close_file
file_error:
    swi swi_exit
    .end