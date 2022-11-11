global  main
extern	printf

section .data
	

section .bss
    

section .text
main:
    push ebp
    mov ebp,esp
    mov edx,[ebp+12]

.loop1:
    mov esi,[ebp+8] ;arr ptr
    mov ecx,[ebp+12] ;n number of ints

.loop2:
    mov eax,[esi] ;compare
    mov ebx,[esi+4]
    cmp eax,ebx
    jg .skip

    mov [esi],ebx ;swap
    mov [esi+4],eax

.skip:
    add esi,4 ;perform loop checks
    dec ecx
    cmp ecx,1
    ja .loop2
    dec edx
    ja .loop1

    mov eax,[ebp+8] ;return arr

    mov esp,ebp
    pop ebp
    ret