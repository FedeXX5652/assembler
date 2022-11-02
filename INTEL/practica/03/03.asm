; Realizar un programa que resuelva X Y teniendo en cuenta que tanto X e Y pueden
; ser positivos o negativos.

global main
extern printf

section .data       ; n1^n2
    debug db "DEBUG",0
    msg db 'nro: %lli',10,0
    n1 dq 2
    n2 dq 4
    result dq 0

section .bss
    aux resq 1

section .text
main:
    mov rbp, rsp; for correct debugging
    sub rsp,32
    call invertir
    mov rax,n2

    imul rax,[n2]

    ;mov [aux],rax
    
    mov rcx,msg
    mov rdx,[rax]
    call printf

fin:
    add rsp,32
    ret

invertir:
    cmp qword[n2],0
    jg  salir
    ; invertir n1 y negar n2
salir:
    ret