TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

zoznam DD 1991, 1992, 1997, 1994, 1995, 1996
Jozef DB "Jozef", 0
Peter DB "Peter", 0
Pavol DB "Pavol", 0
Milan DB "Milan", 0
Boris DB "Boris", 0
JKS DB "JKS", 0

niger DD Jozef, Peter, Pavol, Milan, Boris, JKS

Msg DB "Zadaj n:", 0
.code
main PROC
    mov EDX, offset Msg
	call WriteString
	call ReadInt
    mov ECX, 6
	cyklus:
		mov EBX, 2023
		sub EBX, zoznam[4*ECX - 4]
		cmp EBX, EAX
		jnb neries
		mov EBX, niger[4*ECX - 4]
		mov EDX, EBX
		call WriteString
		call CRLF
		neries:
	loop cyklus
	exit
main ENDP

END main