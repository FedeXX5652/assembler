    .equ swi_open_file, 0x66
    .equ swi_read_int, 0x6c
    .equ swi_print_int, 0x6b
    .equ swi_close_file, 0x68
    .equ swi_exit, 0x11
    .equ swi_print_char, 0x00
    .equ swi_print_str, 0x69

    .equ stdout, 1

    .data
exit:
    .asciz "END OF PROGRAM"
file_error:   
    .asciz "Error abriendo el archivo\n"
file:
    .asciz "01.txt"
eol:
    .asciz "\n"
    .align
handler:
    .word 0
vec:
    .word 1,2,3,4,5,6,7,8,9
cte:
    .word 5


    .text
    .global _start
_start:
    @ open file
    ldr r0, =file
    mov r1, #2
    swi swi_open_file
    bcs fileError
    ldr r1, =handler
    str r0, [r1]

    ldr r2, =vec
    ldr r3, =cte
    ldr r3, [r3]
    mov r4, #9  @ r4 = long vec

loop:
    bl print_int
    bl save_r1
    add r2, r2, #4
    subs r4, r4, #1
    bne loop
    b eof

save_r1:    @ value to save must be in r1
    stmfd sp!, {r0,r1,lr}
    ldr r0, =handler
    ldr r1, [r2]
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str
    swi swi_close_file
    ldmfd sp!, {r0,r1,pc}

print_int:
    stmfd sp!, {r0,r1,lr}
    ldr r0, =stdout
    ldr r1, [r2]
    swi swi_print_int
    ldr r1, =eol
    swi swi_print_str
    ldmfd sp!, {r0,r1,pc}

fileError:
    ldr r0, =stdout
    ldr r1, =file_error
    swi swi_print_str
eof:
    ldr r0, =stdout
    ldr r1, =exit
    swi swi_print_str
    swi swi_exit
    .end