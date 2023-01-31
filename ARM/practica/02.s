    .equ SWI_Print_String, 0x02
    .equ SWI_Exit, 0x11

    .data
str1:   .asciz "Hello, World!\n"
str2:   .asciz "Goodbye, World!\n"

    .text
    .global _start

_start:
    ldr r3, =str1
    bl print_r3
    ldr r3, =str2
         print_r3
    b exit

print_r3:
    stmfd sp!, {r0,lr}
    mov r0, r3
    swi SWI_Print_String
    ldmfd sp!, {r0,pc}

exit:
    swi SWI_Exit