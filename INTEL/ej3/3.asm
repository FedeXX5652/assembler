global main
extern puts
extern printf
extern fopen
extern fclose
extern fread
extern sscanf
extern fwrite

section .data
    fileListado db "listado.dat",0
    modeListado db "rb",0
    msjErrOpenLis db "Error abriendo archivo listado",0
    handleListado dq 0
    
    fileSeleccion db "seleccion.dat",0
    modeSeleccion db "wb",0
    msjErrOpenSel db "Error abriendo archivo seleccion",0
    handleSeleccion dq 0
    
    ; msjs para debug
    msjAperturaOk db "Apertura Listado OK",0

section .bss

section .text
main:
    mov rcx,fileListado
    mov rdx,modeListado
    sub rsp,32
    call fopen
    add rsp,32
        
    cmp rax,0
    jle errorOpenLis
    mov [handleListado],rax

    mov rcx,msjAperturaOk       ; print apertura listado OK
    sub rsp,32
    call puts
    add rsp,32

    jmp finProg

; RUTINAS INTERNAS

errorOpenLis:
    mov rcx,msjErrOpenLis      ; print apertura listado ERR
    sub rsp,32
    call puts
    add rsp,32


finProg:
ret