    .equ swi_print_int, 0x6b
    .equ swi_print_str, 0x69
    .equ swi_exit, 0x11

    .equ stdout, 1

    .data
v1:
    .word 1,2,3
v2:
    .word 4,5,6
v3:
    .word 7,8,9
eol:
    .asciz "\n"

    .text
    .global _start
_start:
    ldr r2, =v1
    mov r3, #3
    bl loop
    ldr r2, =v2
    mov r3, #3
    bl loop
    ldr r2, =v3
    mov r3, #3
    bl loop
    b exit

loop:
    bl print_int
    add r2, r2, #4
    sub r3, r3, #1
    bne loop

print_int:
    stmfd sp!, {r0,r1, lr}
    ldr r0, =stdout
    ldr r1, [r2]
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str
    ldmfd sp!, {r0,r1, pc}

exit:
    swi swi_exit
    .end