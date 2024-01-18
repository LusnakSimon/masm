TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

EleMeno DB "Elena",0
IlkaMeno DB "Ilka", 0
KajsaMeno DB "Kajsa",0
LaraMeno DB "Lara", 0
MikaMeno DB "Mikaela", 0
PriskaMeno DB "Priska", 0

EleRok DD 1991
IlkaRok DD 1990
KajRok DD 1998
LaraRok DD 1991
MikaRok DD 1995
PrisRok DD 1992

EleCas DD 56
IlkaCas DD 64
KajCas DD 64
LaraCas DD 65
MikaCas DD 65
PriCas DD 65

EleCasF DD 56.07
IlkaCasF DD 64.73
KajCasF DD 64.99
LaraCasF DD 65.08
MikaCasF DD 65.12
PriCasF DD 65.15

LyziarkyMena DD EleMeno, IlkaMeno, KajsaMeno, LaraMeno, MikaMeno, PriskaMeno
LyziarkyRoky DD EleRok, IlkaRok, KajRok, LaraRok, MikaRok, PrisRok
LyziarkyCasy DD EleCas, IlkaCas, KajCas, LaraCas, MikaCas, PriCas
LyziarkyCasyF DD EleCasF, IlkaCasF, KajCasF, LaraCasF, MikaCasF, PriCasF

Rok DD 2024
pocetLyziarok DD 6

Msg DB "Je vzostupne",0
Msg1 DB "Neni Vzostupne", 0

.code
MenejAkoNRokov PROC USES EDI EAX EBX ECX EDX
mov EAX, 0
mov ECX, pocetLyziarok
mov EDI, 0
mov EBX, 0
mov EDX, 0
call ReadInt

LoopLyziarky:
	mov EBX, LyziarkyRoky[EDI * 4]
	mov EBX, [EBX]
	mov EDX, offset Rok
	mov EDX, [EDX]
	sub EDX, EBX
	cmp EDX, EAX
	jge maViac
	mov EDX, LyziarkyMena[EDI * 4]
	call WriteString
	call CRLF

	maViac:
	inc EDI

LOOP LoopLyziarky

ret
MenejAkoNRokov ENDP

LepsiAkoNCas PROC USES EDI EAX EBX ECX EDX
mov EAX, 0
mov ECX, pocetLyziarok
mov EDI, 0
mov EBX, 0
mov EDX, 0
call ReadInt

LoopLyziarky:
	mov EBX, LyziarkyCasy[EDI * 4]
	mov EBX, [EBX]
	cmp EBX, EAX
	jge maHorsiCas
	mov EDX, LyziarkyMena[EDI * 4]
	call WriteString
	call CRLF

	maHorsiCas:
	inc EDI

LOOP LoopLyziarky

ret
LepsiAkoNCas ENDP

SkontrolujVzostupnost PROC USES EDI EAX EBX ECX EDX
finit
mov ecx, pocetLyziarok
dec ecx
mov EAX, 0
mov EDI, 1
mov EBX, LyziarkyCasy[0]
mov EBX, [EBX]
push EBX
fild DWORD PTR [esp]
pop EBX

LoopVzostupnost:
	mov EBX, LyziarkyCasyF[EDI * 4]
	mov EBX, [EBX]
	push EBX
	fild DWORD PTR [esp]
	pop EBX
	fcom st(1)
	fnstsw ax
	sahf
	jb AJeMensie
	inc EDI
LOOP LoopVzostupnost

mov edx, offset Msg
call WriteString
jmp endLabel

AJeMensie:
mov edx, offset Msg1
call WriteString
endLabel:
ret
SkontrolujVzostupnost ENDP

main PROC
call Clrscr
call MenejAkoNRokov
call LepsiAkoNCas
call SkontrolujVzostupnost
exit
main ENDP

END main