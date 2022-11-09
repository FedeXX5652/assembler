; Escribir un programa que lea 15 números ingresados por teclado. Se pide imprimir
; dichos números en forma decreciente.

global 	main
extern 	printf
extern gets
extern sscanf

section .data
    debug db "DEBUG: %i - ",0
    msgIngreso db "Ingrese 5 numeros (maximo 10 caracteres c/u):",0
    cantDatos dq 5
    aux dq 0

    intFormat db '%li',0

section .bss
    vec times 5 resq 1
    ingreso resq 1
    buffer resq 1

section .text
main:
    sub rsp,32
    call llenarVector


add rsp,32
ret ;RETURN MAIN

llenarVector:
    mov rcx,msgIngreso
    call printf

    mov rcx,[cantDatos]

loopLlenar:
    push rcx        ; rcx -> pila para poder pedir input

    ;mov rdx,rcx     ; rcx -> rdx para poder imprimir el valor que tenga rcx
    ;mov rcx,debug   ; imprimo el valor de rcx (ahora en rdx)
    ;call printf

    mov rcx,buffer  ; pido input
    call gets

    mov rcx,buffer
    mov rdx,intFormat
    mov r8,ingreso
    call sscanf

    pop rcx
    
    cmp rax,0
    jle loopLlenar  ; si no es nro valido bifurco
    
    loop loopLlenar

ret ; RETURN LLENAR VECTOR