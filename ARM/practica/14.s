@ Práctica 14: Cálculo de fibonacci
@ Escribir el código ARM que ejecutado bajo ARMSim# lea un entero desde un archivo, calcule el
@ valor de la posición que corresponde a ese entero en la sucesión de Fibonacci.
@
@           ┌
@ fib(x)    |fib(x-1) + fib(x-2) si x > 2
@           |1 si x < 2
@           └
@
@ Una salida aceptable del programa sería, para el caso que el valor de entrada fuera 8:
@ 21

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
    .asciz "12.txt"
eol:
    .asciz "\n"
    .align
handler:
    .word 0

    .text
    .global _start

_start:
    ldr r0, =file
    mov r1, #0
    swi swi_open_file
    bcs file_error
    ldr r1, =handler
    str r0, [r1]

    bl read_int
    bl fibonacci
    bl print_int
    b end

fibonacci:
    stmfd sp!, {r0,r2, lr}
    cmp r0, #1
    ble fibonacci_1
    sub r0, r0, #1
    bl fibonacci
    mov r2, r1
    sub r0, r0, #1
    bl fibonacci
    add r1, r1, r2
    b fibonacci_end
fibonacci_1:
    mov r1, r0
fibonacci_end:
    ldmfd sp!, {r0,r2, pc}

read_int:
    stmfd sp!, {lr}
    ldr r0, =handler
    ldr r0, [r0]
    swi swi_read_int
    ldmfd sp!, {pc}

print_int:
    stmfd sp!, {r0,r1, lr}
    ldr r0, =stdout
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str
    ldmfd sp!, {r0,r1, pc}

file_error:
    ldr r0, =eol
    swi swi_print_str
    swi swi_exit
end:
    swi swi_exit
    .end