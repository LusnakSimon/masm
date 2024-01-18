TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

preteky DB 2, 100, 1, 6, 6, 3, 100
        DB 4, 4, 28, 8, 3, 100, 3
        DB 1, 1, 5, 2, 1, 1, 2
        DB 3, 3, 4, 3, 4, 2, 1
        DB 5, 2, 1, 1, 5, 4, 4

Msg DB "Zadajte poradove cislo pretekar:", 0


.code
main PROC
    mov EDX, offset Msg
    call WriteString
    call ReadInt
    dec EAX
    mov EBX, 7
    mul EBX
    mov ECX, 7
    mov EDX, 0
    cyklus:
        movzx EBX, preteky[ECX - 1 + EAX]
        cmp EBX, 3
        ja neries
        inc EDX
        neries:
    loop cyklus
    mov EAX, EDX
    call WriteInt
	exit
main ENDP

END main