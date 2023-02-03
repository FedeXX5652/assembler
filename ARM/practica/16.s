@ Escribir el código ARM que ejecutado bajo ARMSim# imprima los valores de un vector de
@ cuatro enteros definidos en memoria, recorriendo el vector mediante una subrutina que utilice
@ direccionamiento por registro indirecto.

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
    add r2, r2, #4  @ sumo offset de 4 bytes al puntero del vector
    subs r3, r3, #1 @ decremento el contador
    bne loop    @ si no es 0, vuelvo a loop
    b end

print_int:
    stmfd sp!, {r0,r1, lr}
    ldr r0, =stdout
    ldr r1, [r2]
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str
    ldmfd sp!, {r0,r1, pc}

end:
    swi swi_exit
    .end