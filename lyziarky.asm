TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data


zoznam DD 1991, 1992, 1997, 1994, 1995, 1996

Msg DB "Je vzostupne",0
Msg1 DB "Neni Vzostupne", 0

pocet DD lengthof zoznam
.code
main PROC
    mov ECX, pocet
	dec ECX
	cyklus:
		mov EAX, zoznam[4*ECX]
		mov EBX, zoznam[4*ECX - 4]
		cmp EBX, EAX
		jg vypis

	loop cyklus
	mov EDX, offset Msg
	call WriteString
	ret
	vypis:
	mov EDX, offset Msg1
	call WriteString

	exit
main ENDP

END main