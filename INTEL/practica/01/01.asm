; Escribir un programa que imprima por pantalla “Organización del Computador”.

global main
extern puts

section .data
    msg db "Organizacion del Computador",0

section .text
main:
    mov rcx,msg
    sub rsp,32
    call puts
    add rsp,32
ret