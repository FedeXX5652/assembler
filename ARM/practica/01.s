    .equ swi_exit, 0x11
    .equ swi_print_str, 0x02
    
    .data
msg:
    .asciz "Hello, world!\n"
    
    .text
    .global _start

_start:
    ldr r0, =msg
    swi swi_print_str
    swi swi_exit