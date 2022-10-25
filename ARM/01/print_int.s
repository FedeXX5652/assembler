.text
    mov r0, #5
    mov r1, #7
    add r2, r0, r1
    mov r1, r2      @ r1 entero a imprimir
    mov r0, #1      @ r0 donde imprimir
    swi 0x6b        @ 0x6b imprimir entero
    swi 0x11        @ 0x11 salir del programa