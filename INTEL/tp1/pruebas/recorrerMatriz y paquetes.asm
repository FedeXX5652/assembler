global     main
extern     printf

section    .data
    msgSal      db  'Elementos guardados en posFil %i: %i',10,0
    msgInt     db  'NRO: %i',10,0
    msgNuevoPaquete       db  '  Nuevo Paquete n %i:',10,0
    msgSuma     db  '    VAL: %i, SUMA: %i, POS: %i',10,10,10,0
    msgSuma0       db  'RESET ---> SUMA: %i',10,0
    msgSeparador    db  '------------------CLUSTER: %i------------------',10,0
    msgSalida       db  'Salida',10,0
    msgSalidaPaquete    db  'Salida paquetes',10,0
    debug       db  'DEBUG',10,0
    msgCiclo    db  'Ciclo de nuevo',10,0
    msgFil      db  'Fila: %i',10,0
    msgTope     db  'Tope: %i',10,0

; times   15      dw      -1
    matNum      dw  8,7,6,9,5,11,5,9,4,1,1,1,1,3,5
                dw  2,9,8,5,6,2,4,7,8,5,4,10,10,4,2
                dw  7,9,1,6,4,2,2,6,1,3,8,1,5,9,7

    TOPE_FIL    dq  3
    TOPE_COL    dq  15

    posFil    dq  0
    pos         dq  0
    suma        dq  0
    paquetes    dq  0

section    .text
main:
    sub  rsp,32
    cicloCol:
        inc qword[posFil]
        mov qword[paquetes],0
        
        sub  rsp,32
        mov rcx,msgSeparador
        mov rdx,[posFil]
        call printf
        add  rsp,32

        ;sub  rsp,32
        ;mov rcx,msgTope
        ;mov rdx,[TOPE_FIL]
        ;call printf
        ;add  rsp,32

        ;sub  rsp,32
        ;mov rcx,msgFil
        ;mov rdx,[posFil]
        ;call printf
        ;add  rsp,32


        call crearPaquetes

        cmp qword[posFil],3
        je fin

        sub  rsp,32
        mov rcx,msgCiclo
        call printf
        add  rsp,32

        jmp cicloCol

fin:
    sub  rsp,32
    mov rcx,msgSalida
    call printf
    add  rsp,32
    ret


crearPaquetes:
    nuevoPaquete:
        inc qword[paquetes]

        sub  rsp,32
        mov rcx,msgNuevoPaquete
        mov rdx,[paquetes]
        call printf
        add  rsp,32

        mov rbx,0
        mov qword[suma],0

        mov        rcx,[posFil]
        dec        rcx
        imul    eax,ecx,2

        mov [pos],eax
    suma0:
        sub [suma],rbx
    recorrer:
        inc qword[pos]

        ; desplazamiento en fila
        mov        rcx,[posFil]
        dec        rcx
        imul    eax,ecx,2
        
        ; desplazamiento en columna
        mov        rcx,[pos]    ;rcx = posicion
        dec        rcx                ;(posicion-1)
        imul    ebx,ecx,2        ;(posicion-1)*longElem

        add ebx,eax

        ; obtengo valor en matriz
        mov        ax,[matNum+ebx]    ;ax = elemento (2 bytes / word)
        cwde                    ;eax= elemento (4 bytes / doble word)
        cdqe                    ;rax= elemento (8 bytes / quad word)

        imul    ebx,ecx,10        ;(posicion-1)*longElem

        mov rbx,rax

        ; chequeo que no se haya pasado de fila
        mov rax,[TOPE_COL]
        imul rax,[posFil]
        mov rcx,rax
        cmp rcx,[pos]
        jl checkVacio

        cmp rbx,-1
        je recorrer
        
        add [suma],rbx

        cmp qword[suma],11
        jg suma0

        sub  rsp,32
        mov rcx,msgSuma
        mov rdx,rbx
        mov r8,[suma]
        mov r9,[pos]
        call printf
        add  rsp,32

        ; desplazamiento en fila
        mov        rcx,[posFil]
        dec        rcx
        imul    eax,ecx,2

        ; desplazamiento en columna
        mov        rcx,[pos]    ;rcx = pos
        dec        rcx                ;(pos-1)
        imul    ebx,ecx,2        ;(pos-1)*longElem

        add ebx,eax

        mov     word[matNum+ebx],-1

        cmp qword[suma],11
        je nuevoPaquete

        jmp recorrer

    checkVacio:
        cmp qword[suma],0
        jle retCrearPaquetes

        jmp nuevoPaquete
    retCrearPaquetes:
        sub  rsp,32
        mov rcx,msgSalidaPaquete
        call printf
        add  rsp,32
        
        ret