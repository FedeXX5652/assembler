@ Modificar el ejercicio para utilizar direccionamiento por registro indirecto con registro indexado.

    .equ swi_print_int, 0x6b
    .equ swi_print_str, 0x69
    .equ swi_exit, 0x11

    .equ stdout, 1

    .data
vec:
    .word 1, 2, 3, 4
eol:
    .asciz "\n"

    .text
    .global _start
_start:
    ldr r2, =vec
    mov r3, #4      @ long del vector

loop:
    bl print_int
    subs r3, r3, #1
    bne loop
    b end

print_int:
    stmfd sp!, {r0,r1, lr}
    ldr r0, =stdout
    ldr r1, [r2, r3]
    add r4, r4, #4
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str
    ldmfd sp!, {r0,r1, pc}

end:
    swi swi_exit
    .end