section .data
    msg db "Hello world", 0xd, 0xa, 0

section .text
global main
extern ExitProcess

extern printf

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    lea rcx, [msg]
    call printf

    xor rax, rax
    call ExitProcess

ret