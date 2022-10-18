global  main
extern	puts

section     .data
	msjIngTexto		db	"Ingrese un texto por teclado! (max 99 caracteres)",0
section     .text
main:

    mov     rcx,msjIngTexto
    sub     rsp,32
    call    puts
    add     rsp,32

ret