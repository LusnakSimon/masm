TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

timeStamp DW 0000100000100001b
menuMsg1 DB "1. Sekundy", 0
menuMsg2 DB "2. Minuty", 0
menuMsg3 DB "3. Hodiny", 0
menuMsg4 DB "4. Cas", 0
menuMsg5 DB "5. Exit program", 0

.code
putEAXHours PROC USES ECX
	movzx EAX, timeStamp
	mov ECX, 1111100000000000b
	AND EAX, ECX
	shr EAX, 11
ret 
putEAXHours ENDP

putEAXMins PROC USES ECX
	movzx EAX, timeStamp
	mov ECX, 11111100000b
	AND EAX, ECX
	shr EAX, 5
ret 
putEAXMins ENDP

putEAXSekundy PROC USES ECX
	movzx EAX, timeStamp
	mov ECX, 11111b
	AND EAX, ECX
ret
putEAXSekundy ENDP

casVSekundach PROC USES ECX EDX EBX
	mov ecx, 0
	call putEAXSekundy
	add ECX, eax

	call putEAXMins
	mov edx, 60
	mul edx
	add ecx, eax
	
	call putEAXHours
	mov edx, 60
	mul edx
	mov edx, 60
	mul edx
	add ecx, eax

	mov eax, ecx
	call WriteInt
ret
casVSekundach ENDP

main PROC

Start:
	mov edx, offset menuMsg1
	call WriteString
	call CRLF
	mov edx, offset menuMsg2
	call WriteString
	call CRLF
	mov edx, offset menuMsg3
	call WriteString
	call CRLF
	mov edx, offset menuMsg4
	call WriteString
	call CRLF
	mov edx, offset menuMsg5
	call WriteString
	call CRLF

	call ReadInt
	cmp eax, 1
	jne nieSekundy
	push EAX
	call putEAXSekundy
	call WriteInt
	pop EAX
	
nieSekundy:
	cmp eax, 2
	jne nieMinuty
	push eax
	call putEAXMins
	call WriteInt
	pop eax

nieMinuty:
	cmp eax, 3
	jne nieHodiny
	push eax
	call putEAXHours
	call WriteInt
	pop eax

nieHodiny:
	cmp eax, 4
	jne nieCas
	push eax
	call casVSekundach
	pop eax
nieCas:
	
	cmp eax, 5
	je koniec
	call CRLF
	jmp Start

koniec:

exit
main ENDP
END main