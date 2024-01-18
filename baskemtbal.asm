TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

Vysledky DB 95, 87, 82, 94, 107, 82
		 DB 92, 81, 85, 94, 86, 82
		 DB 60, 85, 75, 88, 80, 87
		 DB 91, 90, 81, 98, 69, 72
		 DB 98, 82, 77, 92, 72, 68
		 DB 74, 97, 73, 77, 77, 75
		 DB 88, 83, 97, 89, 93, 87
		 DB 105, 93, 77, 72, 91, 74

SNV DB "BK Spisska Nova Ves", 0
IKS DB "Iskra Svit", 0
PL DB "Patrioti Levice", 0
LC DB "BKM Lucenec", 0
PD DB "BC Prievidza", 0
IBA DB "Inter Bratislava", 0
BAH DB "MBK Banik Handlova", 0
KO DB "MBK Komarno", 0

nacitanieCisla DB "Zadaj cislo:"

.code
main PROC
    mov ECX, 24
	mov ESI, 0
	mov EDX, offset nacitanieCisla
	call WriteString
	call WriteString
	call ReadInt
	mov EBX, EAX

	vypisLoop:
	   movzx EAX, Vysledky[ESI]
	   cmp EAX, EBX
	   jna nie
       call WriteInt
	   mov AL, 58
	   call WriteChar
	   movzx EAX, Vysledky[ESI + 1]
       call WriteInt
	   call CRLF
	   nie:
	   add ESI, 2
	   
	loop vypisLoop
	

	exit
main ENDP

END main