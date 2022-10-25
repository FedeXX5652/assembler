INCLUDE Irvine32.inc
.data
    xValue BYTE "Enter a value for x: ", 0
    cValue BYTE "Enter a value for c: ", 0
    resultText BYTE "f(x) = ", 0
    XX SDWORD ?
    CC SDWORD ?
    result SDWORD ?
.code
main PROC
    mov edx, OFFSET xValue
    call WriteString
    call ReadInt
    mov xx, eax

    mov edx, OFFSET cValue
    call WriteString
    call ReadInt
    mov cd, eax

    mov edx, OFFSET resultText
    call WriteString

    exit
main ENDP
END main