@ Escribir el código ARM que ejecutado bajo ARMSim# lea tres enteros desde un archivo e
@ imprima la mediana, siendo la mediana el valor de la variable de posición central en un
@ conjunto de datos ordenados. Por ejemplo, si los valores fueran 5, 8 y 9, la mediana sería 8.

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
    .asciz "10.txt"
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
    mov r2, r0
    bl read_int
    mov r3, r0
    bl read_int
    mov r4, r0

    bl calcular_mediana
    mov r1, r3
    bl print_int
    
    b exit

calcular_mediana:
    cmp r2, r3
    blt swapr2r3
        mov r0, r2
        mov r2, r3
        mov r3, r0
    swapr2r3:
    cmp r3, r4
    blt swapr3r4
        mov r0, r3
        mov r3, r4
        mov r4, r0
    swapr3r4:
    cmp r2, r3
    blt swapr2r32
        mov r0, r2
        mov r2, r3
        mov r3, r0
    swapr2r32:

read_int:
    stmfd sp!, {lr}
    ldr r0,=handler
    ldr r0,[r0]
    swi swi_read_int
    ldmfd sp!, {pc}

print_int:
    stmfd sp!, {r0,r1,lr}
    ldr r0, =stdout
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str
    ldmfd sp!, {r0,r1,pc}

file_error:
exit:
    swi swi_exit
    .end