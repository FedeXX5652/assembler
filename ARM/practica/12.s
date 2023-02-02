@ Escribir el código ARM que ejecutado bajo ARMSim# lea un entero desde un archivo, calcule el
@ factorial de ese entero y muestre los valores intermedios del proceso. El algoritmo podría
@ resumirse como:
@ n = <<entero leído desde archivo>>
@ accum = 1
@ while (n != 0) {
@   accum = accum * n
@   print accum
@   print "\n"
@   n = n - 1 
@ }
@ print accum
@ print "\n"
@ Una salida aceptable del programa sería, para el caso que el valor de entrada fuera 5:
@ 5
@ 20
@ 60
@ 120
@ 120
@ 120
@ Puede asumirse que el archivo no contendrá un entero negativo.

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

    mov r1, #1

factorial:
    cmp r0, #0
    beq factorial_end
    mul r1, r0, r1
    bl print_int
    sub r0, r0, #1
    b factorial

factorial_end:
    bl print_int
    b end

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