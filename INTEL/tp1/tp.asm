global     main
extern     printf

section    .data
    msgDato      db  'Nro en posicion %i: %i',10,10,0
    msgInt     db  'NRO: %i',10,0
    msgNuevoPaquete       db  '  Nuevo Paquete n %i:',10,0
    msgSuma     db  '      VAL: %i, SUMA: %i, POS: %i',10,0
    msgSeparador    db  '------------------DESTINO: %s------------------',13,10,0
    msgSalida       db  'Fin del programa',10,0
    msgSalidaPaquete    db  'No se pueden crear mas paquetes',10,10,0
    debug       db  'DEBUG',10,0
    msgFil      db  'Fila: %i',10,0
    msgTope     db  'Tope: %i',10,0

; times   15      dw      -1
    matNum      dw  8,7,6,9,5,11,5,9,4,1,1,1,1,3,5
                dw  2,9,8,5,6,2,4,7,8,5,4,10,10,4,2
                dw  7,9,1,6,4,2,2,6,1,3,8,1,5,9,7

    TOPE_FIL    dq  3
    TOPE_COL    dq  15
    TOPE_PESO   dq  11

    posFil      dq  0
    posCol      dq  0
    suma        dq  0
    paquetes    dq  0

    desplazamiento dq 0

    MDP_ID         dq  1
    POSADAS_ID     dq  2
    BARILOCHE_ID   dq  3

    MDP         db  'MAR DEL PLATA',0
    POSADAS     db  'POSADAS',0
    BARILOCHE   db  'BARILOCHE',0

section    .text
main:
    sub  rsp,32
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

; funcion que crea los grupos de paquetes
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
        imul    ebx,ecx,2

        mov        rcx,[posFil]
        dec        rcx
        imul    rcx,[TOPE_COL]
        imul    eax,ecx,2

        add ebx,eax

        mov rcx,[TOPE_COL]
        cmp [posCol],rcx        ; Salto por ultimo valor del vector
        jg checkPaquete

        mov        ax,[matNum+ebx]    ;ax = elemento (2 bytes / word)
        cwde                    ;eax= elemento (4 bytes / doble word)
        cdqe                    ;rax= elemento (8 bytes / quad word)

        mov rbx,rax

        cmp rbx,-1          ; Salto por valor usado o invalido
        je iterar

        add rax,[suma]
        cmp rax,[TOPE_PESO]
        jg iterar

        ; ejecuto la suma y reemplazo del valor
        add [suma],rbx

        mov        rcx,[posCol]
        dec        rcx
        imul    ebx,ecx,2

        mov        rcx,[posFil]
        dec        rcx
        imul    rcx,[TOPE_COL]
        imul    eax,ecx,2

        add ebx,eax
        mov        ax,[matNum+ebx]
        cwde
        cdqe
        mov word[matNum+ebx],-1


        sub rsp,32
        mov rcx,msgSuma
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


; funcion para imprimir el contenido de la fila actual
imprimirFila:
    inc qword[posCol]

    mov        rcx,[posCol]    ;rcx = posicion
    dec        rcx                ;(posicion-1)
    imul    ebx,ecx,2        ;(posicion-1)*longElem

    mov        rcx,[posFil]
    dec        rcx
    imul    rcx,[TOPE_COL]
    imul    eax,ecx,2

    add ebx,eax

    mov        ax,[matNum+ebx]    ;ax = elemento (2 bytes / word)
    cwde                    ;eax= elemento (4 bytes / doble word)
    cdqe                    ;rax= elemento (8 bytes / quad word)

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