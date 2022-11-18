global     main
extern     printf

section    .data
    msgSal      db  'Elementos guardados en posicion %i: %i - ',10,10,0
    vecNum      dw  8,7,6,9,5,11,5,9,4,1,1,1,1,3,5
    tope        dq  5
    posicion    dq  0
    sigo       db  'SIGO CON PROGRAMA',0
    salidaRecorrer  db  'SALGO DE RECORRER',0

section    .text
main:

    call recorrer

    sub  rsp,32
    mov rcx,sigo
    call printf
    add  rsp,32

fin:
ret ; FIN DEL PROGRAMA PRINCIPAL

;-----------------------------------------------------------------
;                       RUTINAS INTERNAS
;-----------------------------------------------------------------

recorrer:
    add qword[posicion],1

    mov rcx, [tope]
    cmp rcx,[posicion]
    jl finRecorrer

    mov        rcx,[posicion]    ;rcx = posicion
    dec        rcx                ;(posicion-1)
    imul    ebx,ecx,2        ;(posicion-1)*longElem

    mov        ax,[vecNum+ebx]    ;ax = elemento (2 bytes / word)
    cwde                    ;eax= elemento (4 bytes / doble word)
    cdqe                    ;rax= elemento (8 bytes / quad word)

    imul    ebx,ecx,10        ;(posicion-1)*longElem

    sub        rsp,32
    mov        rcx,msgSal        ;Param 1: Direccion del mensaje a imprimir
    mov        rdx,[posicion]    ;Param 2: Direccion del primer dato a imprimir (numero)
    mov        r8,rax            ;Param 3: Contenido del segundo dato a imprimir (numero)
    call    printf
    add        rsp,32

    jmp recorrer

finRecorrer:
    sub        rsp,32
    mov rcx,salidaRecorrer
    call printf
    add        rsp,32
    ret