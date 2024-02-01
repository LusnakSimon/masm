TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
Kopec DW 1, 3, 5, 7, 9, 11, 8, 6, 4, 2 
dlzkaKopca DB lengthof Kopec
vypis DB "Pocet kopcov: ", 0


.code
main PROC
	movzx ecx, dlzkaKopca
	sub ecx, 2
	mov esi, 0
	cyklus:

		movzx eax, Kopec[2 * ecx]
		movzx ebx, Kopec[2 * ecx + 2]
		movzx edx, Kopec[2 * ecx - 2]
		cmp eax, ebx
		jbe zaver
		cmp eax, edx
		jbe zaver
		inc esi
		zaver:

	loop cyklus


	mov edx, offset vypis
	call WriteString
	mov eax, esi
	call WriteInt


	exit
main ENDP

END main