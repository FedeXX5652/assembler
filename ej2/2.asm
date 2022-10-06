; dada una matriz de 5x5 cuyo elementos son nros enteros de 2 bytes (word)
; se pide ingresar por teclado uin nro de fil y col y realizar
; la sumatoria de los elementos de la fila elegida a partir de la columna elegida y mostrar el res por pantalla
; se deberá validar mediante una rutina interna que los datos ingresados por teclado sean validos

global main
extern printf
extern gets
extern sscanf

section .data
    askInputText db "Ingrese fila (1-5) y columna (1-5) separados por un espacio: ",0
    formatInputFilCol db "%hi %hi",0

section .bss
    inputFilCol resb 50
    fil resw 1
    col resw 1
    inputValido resb 1  ; S es valido, N es invalido

section .text
main:
    ; imprimo el texto de askInputText
    mov rcx,askInputText
    sub rsp,32
    call printf
    add rsp,32

    ; espero la entrada de datos
    mov rcx,inputFilCol
    sub rsp,32
    call gets
    add rsp,32
    
    call validarFyC
    
    cmp byte[inputValido], "N"
    je main

ret ; fin del programa principal

;-----------------------------------------
;           RUTINAS INTERNAS
;-----------------------------------------
validarFyC:
    mov byte[inputValido],"N"

    ; intento convertir de string a int, si no puedo hago un jump
    mov rcx,inputFilCol
    mov rdx,formatInputFilCol
    mov r8,fil
    mov r9, col

    sub rsp,32
    call sscanf
    add rsp,32

    cmp rax,2   ; en arx se guarda la cantidad de conversiones validas
    jl invalido


    cmp word[fil],1
    jl invalido
    cmp word[fil],5
    jl invalido
    
    cmp word[col],1
    jl invalido
    cmp word[col],5
    jl invalido
    
    mov byte[inputValido],"S"
ret
invalido:
ret