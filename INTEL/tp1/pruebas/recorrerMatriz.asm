global main
extern printf

section .data
    msjSal  db 'Elemento guardado en fila %i y columna %i: %i',10,10,10,0

    msgDesp db  'desplazamiento %i',10,0

    ;matriz  times 9 dw 2
    matriz  dq 8,7,6,9,5,11,5,9,4,1,1,1,1,3,5
            dq 2,9,8,5,6,2,4,7,8,5,4,10,10,4,2
            dq 7,9,1,6,4,2,2,6,1,3,8,1,5,9,7

    LONG_ELEM dq 2
    CANT_FIL dq 3
    CANT_COL dq 3

    TOPE_FIL dq 3
    TOPE_COL dq 15

    fil dq 0
    col dq 0

section  .text
main:
    cicloFil:
        inc qword[fil]

        mov rcx,[TOPE_FIL]
        cmp [fil],rcx
        jg fin

        mov qword[col],0

        cicloCol:
            inc qword[col]

            mov rcx,[TOPE_COL]
            cmp [col],rcx
            jg cicloFil

            ; desplazamiento fila
            mov rax,[fil]
            dec rax
            imul rax,[LONG_ELEM]
            imul rax,[CANT_COL]
            mov rbx,rax

            ; desplazamiento columna
            mov rax,[col]
            dec rax
            imul rax,[LONG_ELEM]

            add rbx,rax     ; rbx = desplazamiento total

            sub rsp,32
            mov rcx,msjSal
            mov rdx,[fil]
            mov r8,[col]
            mov r9,[matriz+rbx]
            call printf
            add rsp,32

            jmp cicloCol
fin:

ret