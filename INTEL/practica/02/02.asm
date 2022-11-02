; Realizar un programa en assembler Intel x86 que imprima por pantalla la siguiente
; frase: “El alumno [Nombre] [Apellido] de Padrón N° [Padrón] tiene [Edad] años para
; esto se debe solicitar previamente el ingreso por teclado de:
;   - Nombre y Apellido
;   - N° de Padrón
;   - Fecha de nacimiento

global main
extern printf
extern gets
extern sscanf

section .data
    debug db "PRINTEAMOS",0
    msgIngresoNombre db "Ingrese nombre (20 caracteres max):",0
    msgIngresoApellido db "Ingrese apellido (20 caracteres max):",0
    msgIngresoPadron db "Ingrese numero de padron (6 caracteres max):",0
    msgIngresoEdad db "Ingrese edad (3 caracteres max):",0

    msgModelo db 'El alumno %s %s de padron N. %i tiene %i anios',20,20,6,3,0

    intFormat db '%li',0

section .bss
    nombre resb 20
    apellido resb 20
    buffer resb 10
    padron resb 6
    edad resb 3

section .text
main:
    sub rsp,32

ingresoNombre:
    mov rcx,msgIngresoNombre
    call printf

    mov rcx,nombre
    call gets
    cmp byte[nombre],""
    je ingresoNombre

ingresoApellido:
    mov rcx,msgIngresoApellido
    call printf

    mov rcx,apellido
    call gets
    cmp byte[nombre],""
    je ingresoApellido

ingresoPadron:
    mov rcx,msgIngresoPadron
    call printf

    mov rcx,buffer
    call gets

    mov rcx,buffer
    mov rdx,intFormat
    mov r8,padron
    call sscanf

    cmp rax,6
    jg ingresoPadron

ingresoEdad:
    mov rcx,msgIngresoEdad
    call printf

    mov rcx,buffer
    call gets

    mov rcx,buffer
    mov rdx,intFormat
    mov r8,edad
    call sscanf

    cmp rax,3
    jg ingresoEdad

imprimirData:
    mov rcx,msgModelo
    mov rdx,nombre
    mov r8,apellido
    mov r9,[padron]
    mov r10,[edad]
    call printf

fin:
    add rsp,32
    ret