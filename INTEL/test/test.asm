global  main
extern	printf

section .data
	msjIngTexto db "DATO: %i",10,0
    n dq 10

section .bss
    dato resq 1

section .text
main:
    sub rsp,32

    mov rcx,[n]
    mov r8,0
loopardo:
    push rcx
    mov r9,rcx

    add r8,2
    pop rcx

    loop loopardo

    mov [dato],r8
    mov rcx,msjIngTexto
    mov rdx,[dato]
    call printf

add rsp,32
ret