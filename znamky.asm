TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

Znamky DB 27, 20, 34, 17, 52, 29
	   DB 46, 17, 37, 11, 44, 40
	   DB 63, 22, 13, 14, 22, 37
	   DB 29, 27, 16, 15, 39, 29
	   DB 30, 18, 13, 17, 38, 39

msg1 DB "Zadajte rok: ", 0
msg2 DB "Pocet studentov: ", 0


.code
main PROC
	mov edx, offset msg1
	call WriteString
	call ReadInt
	sub eax, 2018
	mov ecx, 6
	mov esi, 0
	cyklus:
		mov edx, eax
		mov edi, 6
		mul edi
		mov edi, eax
		sub eax, ecx
		mov eax, edx
		movzx ebx, Znamky[edi]
		pop eax
		mov eax, ebx
		call WriteInt
		push eax
		add esi, ebx
	loop cyklus
	mov edx, offset msg2
	call WriteString
	mov eax, esi
	call WriteInt
	exit
main ENDP

END main