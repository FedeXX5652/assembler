@ Escribir el código ARM que ejecutado bajo ARMSim# lea dos enteros desde un archivo e
@ imprima el mínimo y el máximo respectivamente de la siguiente manera:
@ Min: <mínimo>
@ Max: <máximo>

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
    .asciz "06.txt"
min_s:
    .asciz "Min: "
max_s:
    .asciz "Max: "
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

    cmp r2, r3
    blt print_res
    mov r1, r2
    mov r2, r3
    mov r3, r1
    
print_res:
    ldr r0, =stdout
    ldr r1, =min_s
    swi swi_print_str
    mov r1, r2
    bl print_int

    ldr r0, =stdout
    ldr r1, =max_s
    swi swi_print_str
    mov r1, r3
    bl print_int

    b exit

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