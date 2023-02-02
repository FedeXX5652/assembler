@ Escribir el código ARM que ejecutado bajo ARMSim# imprima los números del 0 al 9.
@ Pseudocódigo:
@ x = 0
@ while (x < 10) {
@   print x
@   x++
@ }

    .equ swi_open_file, 0x66
    .equ swi_read_int, 0x6c
    .equ swi_print_int, 0x6b
    .equ swi_close_file, 0x68
    .equ swi_exit, 0x11
    .equ swi_print_char, 0x00
    .equ swi_print_str, 0x69

    .equ stdout, 1

    .text
    .global _start

_start:
    mov r2, #0      @ r2 = 0
loop:
    cmp r2, #10     @ r2 == 10?
    bge end         @ if (r2 >= 10) goto end
    mov r0, #1
    mov r1, r2      @ r1 = r2
    swi swi_print_int   @ print r0
    add r2, r2, #1  @ r2++
    b loop          @ goto loop
end:
    mov r0, #0      @ r0 = 0
    swi swi_exit
    .end