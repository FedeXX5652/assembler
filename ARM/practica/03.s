    .equ swi_exit, 0x11
    .equ swi_print_int, 0x6b
    .equ swi_print_str, 0x02
    .equ stdout, 1

    .data
msg:
    .asciz "\n"
    .align

    .text
    .global _start


print_int:
    stmfd sp!,{r0,r1, lr}
    mov r1, r11
    ldr r0, =stdout
    swi swi_print_int
    ldr r0, =msg
    swi swi_print_str
    ldmfd sp!,{r0,r1, pc}

_start:
    mov r0, #4
    mov r1, #5

    add r2, r0, r1
    mov r11, r2
    bl print_int
    sub r3, r0, r1
    mov r11, r3
    bl print_int
    mul r4, r0, r1
    mov r11, r4
    bl print_int
    and r5, r0, r1
    mov r11, r5
    bl print_int
    orr r6, r0, r1
    mov r11, r6
    bl print_int
    eor r7, r0, r1
    mov r11, r7
    bl print_int
    mov r8, r0, lsl r1
    mov r11, r8
    bl print_int
    mov r9, r0, lsr r1
    mov r11, r9
    bl print_int
    mov r10, r0, asr r1
    mov r11, r10
    bl print_int

    swi swi_exit
    .end