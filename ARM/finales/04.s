@ Codificar un programa en assembler ARM de 32 bits que recorra un vector de enteros y genere un nuevo
@ vector formado por elementos que resultan de sumar pares de elementos del vector original. Ej. vector original
@ {1,2,5,6}, vector nuevo {3,11}

    .equ swi_print_int, 0x6b
    .equ swi_print_string, 0x69
    .equ swi_exit, 0x11

    .equ stdout, 1

    .data
v:
    .word 1,2,5,6
r:
    .word 0,0
eol:
    .asciz "\n"
    
    .text
    .global main
main:
    ldr r2, =v
    mov r3, #4

    ldr r4, =r
    mov r5, #2

loop:
    ldr r0, [r2], #4    @ r0 = v[i]
    ldr r1, [r2], #4    @ r1 = v[i+1]
    add r0, r0, r1      @ r0 = v[i] + v[i+1]
    str r0, [r4], #4    @ r[i] = r0
    subs r3, r3, #2
    bne loop

print_vec:
    ldr r2, =r
    mov r3, #2

loop2:
    ldr r0, =stdout
    ldr r1, [r2], #4
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_string
    subs r3, r3, #1
    bne loop2

    mov r0, #0
    swi swi_exit