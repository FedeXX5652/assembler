        .equ SWI_Open_File, 0x66
        .equ SWI_Read_Int, 0x6C
        .equ SWI_Print_Int, 0x6B
        .equ SWI_Close_File, 0x68
        .equ SWI_Exit, 0x11
        .equ SWI_Print_Char, 0x00
        .equ SWI_Print_Str, 0x69
        .equ Stdout, 1

        .data
filename:
    .asciz "file22.txt"
    .align
eol:
    .asciz "\n"
    .align
InFileHandle:
    .word 0

    .text
    .global _start
_start:
    ldr r0,=filename
    mov r1,#0
    swi SWI_Open_File
    bcs InFileError
    ldr r1,=InFileHandle
    str r0,[r1]

loop:
    ldr r0,=InFileHandle
    ldr r0,[r0]
    swi SWI_Read_Int
    bcs Eof

    mov r2,r0
    bl print_r1_int
    mov r3,#-1
    EOR r1,r2,r3
    bl print_int
    b loop

print_int:
    stmfd sp!,{r0,r1,lr}
    ldr r0,=Stdout
    swi SWI_Print_Int
    ldr r1,=eol
    swi SWI_Print_Str
    ldmfd sp!,{r0,r1,lr}

InFileError:
Eof:
    swi SWI_Exit
    .end