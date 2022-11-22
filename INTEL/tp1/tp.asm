global main
extern printf
extern sscanf
extern gets

; Datos de prueba
; dw  8,7,6,9,5,11,5,9,4,1,1,1,1,3,5
; dw  2,9,8,5,6,2,4,7,8,5,4,10,10,4,2
; dw  7,9,1,6,4,2,2,6,1,3,8,1,5,9,7

section .data
    ; Parser
    parserInt db '%li',0

    ; Mensajes
    msgDato db 'Nro en posicion %i: %i',10,10,0
    msgNuevoPaquete db '  Nuevo Paquete n %i:',10,0
    msgAgregoAPaquete db '      VAL: %i, SUMA: %i, POS: %i',10,0
    msgSeparador db '------------------DESTINO: %s------------------',13,10,0
    msgSalida db 'Fin del programa',10,0
    msgSalidaPaquete db 'No se pueden crear mas paquetes',10,10,0
    msgIngresoDestino db 'Ingrese el destino (1-Mar del Plata / 2-Posadas / 3-Bariloche): ',0
    msgIngresoPeso  db 'Ingrese el peso (<=11): ',0
    msgDestinoError db 'Ingrese un destino valido',0
    msgPesoError db 'Ingrese un peso valido',0,0

    ; Mensajes para debug
    debug db 'DEBUG',10,0
    msgInt db 'NRO: %i',10,0

    ; Matriz de datos
    matNum  dq  8,7,6,9,5,11,5,9,4,1,1,1,1,3,5;times   20      dq      -1      ; Mar del Plata
            dq  2,9,8,5,6,2,4,7,8,5,4,10,10,4,2;times   20      dq      -1      ; Posadas
            dq  7,9,1,6,4,2,2,6,1,3,8,1,5,9,7;times   20      dq      -1      ; Bariloche

    ; Topes
    TOPE_FIL dq 3
    TOPE_COL dq 15
    TOPE_PESO dq 11
    TOPE_DATOS dq 3
    TOPE_MDP dq 0
    TOPE_POSADAS dq 0
    TOPE_BARILOCHE dq 0

    ; Datos
    peso dq 0
    destino dq 0
    posFil dq 0
    posCol dq 0
    suma dq 0
    paquetes dq 0
    desplazamiento dq 0
    datosIngresados dq 0

    ; Datos de destinos
    MDP_ID dq 1
    POSADAS_ID dq 2
    BARILOCHE_ID dq 3

    MDP db 'MAR DEL PLATA',0
    POSADAS db 'POSADAS',0
    BARILOCHE db 'BARILOCHE',0

section .bss
    buffer resb 10

section    .text
main:
    ;call llenarMatriz
    cicloCol:
        inc qword[posFil]
        mov qword[paquetes],0
        
        call imprimirDestino

        call imprimirFila
        mov qword[posCol],0
        mov qword[suma],0

        call crearPaquetes
        mov qword[posCol],0
        mov qword[suma],0

        cmp qword[posFil],3
        je fin

        jmp cicloCol

fin:
    sub  rsp,32
    mov rcx,msgSalida
    call printf
    add  rsp,32
    ret

;--------------------------------------------------------------------------------------------
;                                   Funciones Internas
;--------------------------------------------------------------------------------------------

; Funcion que crea los grupos de paquetes
crearPaquetes:
    nuevoPaquete:
        inc qword[paquetes]

        sub rsp,32
        mov rcx,msgNuevoPaquete
        mov rdx,[paquetes]
        call printf
        add rsp,32

        mov qword[posCol],0
        mov qword[suma],0
    iterar:
        inc qword[posCol]

        mov        rcx,[posCol]
        dec        rcx
        imul    ebx,ecx,8

        mov        rcx,[posFil]
        dec        rcx
        imul    rcx,[TOPE_COL]
        imul    eax,ecx,8

        add ebx,eax

        mov rcx,[TOPE_COL]
        cmp [posCol],rcx        ; Salto por ultimo valor del vector
        jg checkPaquete

        mov        rax,[matNum+ebx]    ;ax = elemento (2 bytes / word)

        mov rbx,rax

        add rax,[suma]
        cmp rax,[TOPE_PESO]
        jg iterar

        cmp rbx,-1          ; Salto por valor usado o invalido
        je iterar

        ; ejecuto la suma y reemplazo del valor
        add [suma],rbx

        mov        rcx,[posCol]
        dec        rcx
        imul    ebx,ecx,8

        mov        rcx,[posFil]
        dec        rcx
        imul    rcx,[TOPE_COL]
        imul    eax,ecx,8

        add ebx,eax
        mov        rax,[matNum+ebx]

        mov word[matNum+ebx],-1


        sub rsp,32
        mov rcx,msgAgregoAPaquete
        mov rdx,rax
        mov r8,[suma]
        mov r9,[posCol]
        call printf
        add rsp,32

        jmp iterar

    checkPaquete:
        cmp qword[suma],0
        jg nuevoPaquete
    finCrearPaquetes:
        sub rsp,32
        mov rcx,msgSalidaPaquete
        call printf
        add rsp,32
        ret


; Funcion para imprimir el contenido de la fila actual
imprimirFila:
    inc qword[posCol]

    mov        rcx,[posCol]    ;rcx = posicion
    dec        rcx                ;(posicion-1)
    imul    ebx,ecx,8        ;(posicion-1)*longElem

    mov        rcx,[posFil]
    dec        rcx
    imul    rcx,[TOPE_COL]
    imul    eax,ecx,8

    add ebx,eax

    mov        rax,[matNum+ebx]    ;ax = elemento (2 bytes / word)

    mov rbx,rax
    cmp rbx,-1
    je imprimirFila

    sub        rsp,32
    mov        rcx,msgDato        ;Param 1: Direccion del mensaje a imprimir
    mov        rdx,[posCol]    ;Param 2: Direccion del primer dato a imprimir (numero)
    mov        r8,rax            ;Param 3: Contenido del segundo dato a imprimir (numero)
    call    printf
    add        rsp,32

    mov rcx, 15
    cmp rcx,[posCol]
    je finImprimirFila

    jmp imprimirFila

    finImprimirFila:
        ret

; Funcion para imprimir el destino con separador
imprimirDestino:
    mov rcx,[posFil]
    cmp [MDP_ID],rcx
    je imrpimirMDP

    mov rcx,[posFil]
    cmp [POSADAS_ID],rcx
    je imrpimirPOSADAS

    mov rcx,[posFil]
    cmp [BARILOCHE_ID],rcx
    je imrpimirBARILOCHE

    imrpimirMDP:
        sub rsp,32
        mov rcx,msgSeparador
        mov rdx,MDP
        call printf
        add rsp,32
        jmp finImprimirDestino

    imrpimirPOSADAS:
        sub rsp,32
        mov rcx,msgSeparador
        mov rdx,POSADAS
        call printf
        add rsp,32
        jmp finImprimirDestino

    imrpimirBARILOCHE:
        sub rsp,32
        mov rcx,msgSeparador
        mov rdx,BARILOCHE
        call printf
        add rsp,32
        jmp finImprimirDestino

    finImprimirDestino:
        ret

; Funcion para pedir los datos al usuario y llenar la matriz
llenarMatriz:
    jmp ingresoPeso

    pesoErroneo:
        sub rsp,32
        mov rcx,msgPesoError
        call printf
        add rsp,32
    ingresoPeso:
        sub rsp,32
        mov rcx,msgIngresoPeso
        call printf
        add rsp,32

        sub rsp,32
        mov rcx,buffer
        call gets
        add rsp,32

        sub rsp,32
        mov rcx,buffer
        mov rdx,parserInt
        mov r8,peso
        call sscanf
        add rsp,32

        cmp rax,1
        jl ingresoPeso

        mov rcx,[peso]
        cmp rcx,[TOPE_PESO]
        jg pesoErroneo

        jmp ingresoDestino

    destinoErroneo:
        sub rsp,32
        mov rcx,msgDestinoError
        call printf
        add rsp,32
    ingresoDestino:
        sub rsp,32
        mov rcx,msgIngresoDestino
        call printf
        add rsp,32

        sub rsp,32
        mov rcx,buffer
        call gets
        add rsp,32

        sub rsp,32
        mov rcx,buffer
        mov rdx,parserInt
        mov r8,destino
        call sscanf
        add rsp,32

        cmp rax,1
        jl ingresoDestino

        mov rcx,[destino]
        cmp rcx,0
        jl destinoErroneo

        mov rcx,[destino]
        cmp rcx,3
        jg destinoErroneo
    
    call insertarDato
    mov rcx,[TOPE_DATOS]
    cmp qword[datosIngresados],rcx
    jl ingresoPeso

    finLlenarMatriz:
        ret

; Funcion para insertar el dato en la matriz
insertarDato:
    ; insertar dato Mar del Plata
    mov rcx,[destino]
    cmp rcx,0
    je insertarMDP

    ; insertar dato Posadas
    mov rcx,[destino]
    cmp rcx,0
    je insertarPOSADAS

    ; insertar dato Bariloche
    mov rcx,[destino]
    cmp rcx,0
    je insertarBARILOCHE

    insertarMDP:
        inc qword[TOPE_MDP]

        mov        rcx,[TOPE_MDP]
        dec        rcx
        imul    ebx,ecx,8

        mov        rcx,[destino]
        dec        rcx
        imul    rcx,[TOPE_COL]
        imul    eax,ecx,8

        add ebx,eax

        mov rcx,[peso]
        mov [matNum+ebx],rcx

    insertarPOSADAS:
        inc qword[TOPE_POSADAS]
    
        mov        rcx,[TOPE_POSADAS]
        dec        rcx
        imul    ebx,ecx,8

        mov        rcx,[destino]
        dec        rcx
        imul    rcx,[TOPE_POSADAS]
        imul    eax,ecx,8

        add ebx,eax

        mov rcx,[peso]
        mov [matNum+ebx],rcx

    insertarBARILOCHE:
        inc qword[TOPE_BARILOCHE]

        mov        rcx,[TOPE_BARILOCHE]
        dec        rcx
        imul    ebx,ecx,8

        mov        rcx,[destino]
        dec        rcx
        imul    rcx,[TOPE_COL]
        imul    eax,ecx,8

        add ebx,eax

        mov rcx,[peso]
        mov [matNum+ebx],rcx

    finInsertarDato:
        inc qword[datosIngresados]
        ret