;***************************************************************************
; fileText.asm
; Ejercicio que lee y escribe un archivo de texto
; Objetivos
;	- manejo de archivo de texto
;	- usar fopen (abrir)
;	- usar fgets (leer)
;	- usar fputs (escribir)
;	- usar fclose (cerrar)
; Copiar el texto que se encuentra al final en un archivo con nombre "07archivo.txt"
; 
;***************************************************************************
global		main
extern		printf
extern		puts
extern		fopen
extern		fgets
extern		fputs
extern		fclose

section		.data
	fileName		db	"07archivo.txt",0 ;LA ULTIMA LINEA DEL ARCHIVO DEBE TERMINAR CON UN FIN DE LINEA (ENTER)!!!
	mode			db	"r+",0
	linea			db	"Autor: Orga Computador",10,0
	msgErrOpen		db  "Error en apertura de archivo",0
	
section		.bss
	fileHandle		resq	1
	registro		resb	81
section		.text
main:
	sub		rsp,40
;	Abro archivo para lectura y escritura	
	mov		rcx,fileName		;Parametro 1: dir nombre del archivo
	mov		rdx,mode			;Parametro 2: dir string modo de apertura
	call	fopen				;ABRO archivo y deja el handle en RAX

	cmp		rax,0				;Error en apertura?
	jg		openOk

;	Error apertura
	mov		rcx,msgErrOpen
	call	puts
	jmp		endProg

openOk:
	mov		[fileHandle],rax
read:
;	Leo registro
	mov		rcx,registro		;Parametro 1: dir area de memoria donde se copia
	mov		rdx,80				;Parametro 2: cantidad de bytes maximas a leer (o hasta fin de linea)
	mov		r8,[fileHandle]		;Parametro 3: handle del archivo
	call	fgets				;LEO registro. Devuelve en rax la cantidad de bytes leidos

	cmp		rax,0				;Fin de archivo?
	jle		write

;	Imprimo el registro en pantalla
	mov		rcx,registro
	call	printf
	jmp		read

write:
;	Escribo una linea al final
	mov		rcx,linea			;Parametro 1: dir area de memoria a copiar
	mov		rdx,[fileHandle]	;Parametro 2: handle del archivo
	call	fputs				;ESCRIBO archivo.
close:
;	Cierro el archivo
	mov		rcx,[fileHandle]	;Parametro 1: handle del archivo
	call	fclose				;CIERRO archivo
endProg:
	add		rsp,40
	ret

;************* Texto de prueba para el archivo *******************************	
;??Cu??ndo realizar tu sue??o?
;- ??Y cu??ndo piensas realizar tu sue??o? le pregunt?? el Maestro a su disc??pulo.
;- Cu??ndo tenga la oportunidad de hacerlo, respondi?? este.
;El Maestro le contest??:
;- La oportunidad nunca llega. La oportunidad ya est?? aqu??.
;*****************************************************************************