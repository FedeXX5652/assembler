
    .equ    SWI_Exit,0x11
    .text
    .global _start

_start:
        mov r0, #107
        mov r1, #104

        add r2, r0, r1
        sub r3, r0, r1
        mul r4, r0, r1
        and r5, r0, r1
        orr r6, r0, r1
        eor r7, r0, r1
        mov r8, r0, LSL r1
        mov r9, r0, LSR r1
        mov r10, r0, ASR r1
        
        swi SWI_Exit
        .end