;Nombre:	FEDERICO GALANTE
;DNI:	43874249
;Padron:	109435

global  main
extern	puts
extern fopen
extern fread
extern fclose

section     .data
    fileName    db  "diagonales.dat",0

    matriz	dw	0,1,2,3,4,5,6,7,8,9     ; matriz de 10x10
			dw  0,1,2,3,4,5,6,7,8,9
			dw	0,1,2,3,4,5,6,7,8,9
			dw	0,1,2,3,4,5,6,7,8,9
			dw	0,1,2,3,4,5,6,7,8,9
            dw	0,1,2,3,4,5,6,7,8,9
			dw  0,1,2,3,4,5,6,7,8,9
			dw	0,1,2,3,4,5,6,7,8,9
			dw	0,1,2,3,4,5,6,7,8,9
			dw	0,1,2,3,4,5,6,7,8,9

    LONG_ELEM	equ	2
    CANT_FIL    equ 10
    CANT_COL    equ 10

    mode        db  "rb+",0
    msgErrOpen		db  "Error abriendo el archivo",0

    registro      times     0   db ""
        filSup    times     4   db ' '
        colSup    times     4   db ' '
        filInf    times     4   db ' '
        colInf    times     4   db ' '
    linea         db        "%1i|%1i%1i|%1i",0
    sumatoria       dq      0
    sumatoriaMax       dq      0
    
section .bss
    fileHandler     resq 1
    diagValida      resb 1

section     .text
main:
    ; abro el archivo
    mov     rcx,fileName
    mov     rdx,mode
    sub     rsp,32
    call    fopen
    add     rsp,32

    cmp     rax,0
    jg      readFile    ; si se abrio correctamente salto

    mov     rcx,msgErrOpen
	sub     rsp,32
    call    puts
    add     rsp,32
	jmp     endProg


readFile:
    mov rcx,registro
    mov rdx,4
    mov r8,1
    mov r9,[fileHandler]
    sub     rsp,32
    call    fread
    add     rsp,32

    cmp		rax,0
	jle		eof
    
    mov     rcx,linea
    sub     rdx,rdx
    mov     dx,[filSup]
    mov     r8,[colSup]
    mov     r9,[filSup]
    mov     r10,[colSup]

    call valreg
    
    cmp		byte[diagValida],'N'
    je		readFile
    push    rcx

sumDiag:
    mov		rax,[fil]			
    dec		rax
    imul	rax,LONG_ELEM
    imul	rax,CANT_COL
    mov		rbx,rax
        
    mov		rax,[col]
    dec		rax
    imul	rax,LONG_ELEM

    add		rbx,rax

    mov     rdx,[fil]
    mov     r8,[col]
    sub     r9,r9
    mov     r9,word[matriz+rbx]
    
    add     r9,[sumatoria]
    dec     colInf
    dec     filInf
    mov     r12,r9
    cmp     r9,filSup
    cmp     r12,colSup
    cmp     r12,r9
    pop     rdx
    je      readFile
    
    cmp sumatoria,sumatoriaMax
    
    jmp     sumDiag

eof:
    mov     rcx,[fileHandler]
    call    fclose
    

endProg:
    mov     rcx,sumatoriaMax
    sub     rsp,32
    call    puts
    add     rsp,32
ret


; RUTINAS INTERNAS

valreg:
    mov     byte[diagValida],'N'

    mov     r11,filSup
    cmp     r11,filInf
    mov     r12,r11
    
    mov     r11,colSup
    cmp     r11,colInf      ; si las distancias entre filSup-filInf y colSup-colInf son distintas no es valido
    cmp     r12,r11
    je      finValreg
    
    mov     byte[diagValida],'S'

finValreg:
ret