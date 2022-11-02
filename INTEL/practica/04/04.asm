; Escribir un programa que lea 15 números ingresados por teclado. Se pide imprimir
; dichos números en forma decreciente.

global 	main
extern 	printf

section .data
    aux dq 0

section .bss
    vec resq 15

section .data
main:
    

ret ;RETURN MAIN