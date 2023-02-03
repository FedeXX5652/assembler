@ Escribir el código ARM que ejecutado bajo ARMSim# encuentre e imprima el menor elemento
@ de un vector, donde el vector está especificado con el label vector y la longitud del vector con
@ el label long_vector.

    .equ SWI_Print_Int, 0x6B
    .equ SWI_Exit, 0x11
    .equ SWI_Print_Str, 0x69
    .equ Stdout, 1

    .data
vec:
    .word 18,54,-23,-12,9,11,48,-7,26
long_vec:
    .word 9
eol:
    .asciz "\n"

    .text
    .global _start
_start:
    ldr r0, =vec
    ldr r1, [r0]
    ldr r2, =long_vec
    ldr r2, [r2]

search_min:
    ldr r3, [r0]
    cmp r1, r3
    ble cmp_min
    ldr r1, [r0]
cmp_min:
    add r0, r0, #4
    sub r2, r2, #1
    cmp r2, #0
    bne search_min

print_min:
    stmfd sp!, {r0,r1, lr}
    ldr r0, =Stdout
    swi SWI_Print_Int
    ldr r1, =eol
    swi SWI_Print_Str
    ldmfd sp!, {r0,r1, pc}

end:
    swi SWI_Exit
    .end