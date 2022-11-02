    .equ SWI_Open_File, 0x66
    .equ SWI_Read_Int, 0x6C
    .equ SWI_Print_Int, 0x6B
    .equ SWI_Close_File, 0x68
    .equ SWI_Exit, 0x11

    .data
file:
    .asciz "file21.txt"
    .text
    .global _start
_start:
    ldr r0,=file
    mov r1,#0
    swi SWI_Open_File

    mov r5,r0
    swi SWI_Read_Int

    mov r1, r0
    mov r0, #1
    swi SWI_Print_Int

    mov r0,r5
    swi SWI_Close_File

    swi SWI_Exit
    .end