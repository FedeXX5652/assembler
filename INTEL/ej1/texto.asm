; ---------------------------------------------------------------------------------------------
; ingresa un texto y un caracter
; se imprime el texto y se deben indicar la cantidad de apariciones del caracter en el texto
; imprime el porcentaje de apariciones del caracter respecto del texto
; ---------------------------------------------------------------------------------------------

global main
extern puts
extern gets

section .data
    msjIngTexto    db "Ingrese un texto por teclado (max 99 caracteres):",0

section .bss
    texto    resb 100

section .text
main:
    mov     rbp, rsp; for correct debugging   ; main siempre va debajo de .text
    mov     rcx, msjIngTexto
    sub     rsp, 32
    call    puts        ; para todas las fuciones de C primero resto 32 a rsp y despues lo vuelvo a sumar
    add     rsp, 32

    mov     rcx, texto
    sub     rsp, 32
    call    gets
    add     rsp, 32

    mov     rcx, texto
    sub     rsp, 32
    call    puts
    add     rsp, 32

    ret