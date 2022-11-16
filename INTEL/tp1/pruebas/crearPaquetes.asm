global     main
extern     printf

section    .data
    msgSal      db  'Elementos guardados en posicion %i: %i',10,0
    msgInt     db  'NRO: %i',10,0
    msgNuevoPaquete       db  'Nuevo Paquete n %i',10,0
    msgSuma     db  'VAL: %i, SUMA: %i, POS: %i',10,10,10,0
    msgSuma0       db  'RESET ---> SUMA: %i',10,0
    msgSalida       db  'Salida',10,0
    debug       db  'DEBUG',10,0
    vecNum      dw  8,7,6,9,5,11,5,9,4,1,1,1,1,3,5
    tope        dq  15
    posicion    dq  0
    suma        dq  0
    paquetes    dq  0

section    .text
main:
    sub  rsp,32
    call crearPaquetes

fin:
    mov rcx,msgSalida
    call printf
    add  rsp,32
    ret


crearPaquetes:
    nuevoPaquete:
        add qword[paquetes],1
        mov rcx,msgNuevoPaquete
        mov rdx,[paquetes]
        call printf
        mov rbx,0
        mov qword[suma],0
        mov qword[posicion],0
    suma0:
        sub [suma],rbx
        ;mov rcx,msgSuma0
        ;mov rdx,[suma]
        ;call printf
    recorrer:
        ;mov r11,[posicion]
        
        add qword[posicion],1

        mov        rcx,[posicion]    ;rcx = posicion
        dec        rcx                ;(posicion-1)
        imul    ebx,ecx,2        ;(posicion-1)*longElem

        mov        ax,[vecNum+ebx]    ;ax = elemento (2 bytes / word)
        cwde                    ;eax= elemento (4 bytes / doble word)
        cdqe                    ;rax= elemento (8 bytes / quad word)

        imul    ebx,ecx,10        ;(posicion-1)*longElem

        mov rbx,rax

        mov rcx, [tope]
        cmp rcx,[posicion]
        jl checkVacio

        cmp rbx,-1
        je recorrer

        ;mov        rcx,msgSal        ;Param 1: mensaje
        ;mov        rdx,r11    ;Param 2: posicion
        ;mov        r8,rax            ;Param 3: Contenido de la posicion
        ;call    printf

        ;mov rcx,msgInt
        ;mov rdx,[posicion]
        ;call printf
        
        add [suma],rbx

        cmp qword[suma],11
        jg suma0

        mov rcx,msgSuma
        mov rdx,rbx
        mov r8,[suma]
        mov r9,[posicion]
        call printf

        mov        rcx,[posicion]    ;rcx = posicion
        dec        rcx                ;(posicion-1)
        imul    ebx,ecx,2        ;(posicion-1)*longElem

        mov     word[vecNum+ebx],-1

        cmp qword[suma],11
        je nuevoPaquete

        jmp recorrer

    checkVacio:
        cmp qword[suma],0
        jg nuevoPaquete
        mov rcx,debug
        call printf
    ret