TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

Matica DB 0, 1, 1, 0, 1, 1, 0, 0, 0
       DB 1, 0, 1, 1, 0, 1, 1, 1, 1
       DB 1, 1, 0, 1, 0, 0, 0, 0, 0
       DB 0, 1, 1, 0, 0, 0, 0, 0, 0
       DB 1, 0, 0, 0, 0, 1, 1, 0, 0
       DB 1, 1, 0, 0, 1, 0, 1, 0, 0
       DB 0, 1, 0, 0, 1, 1, 0, 1, 0
       DB 0, 1, 0, 0, 0, 0, 1, 0, 1
       DB 0, 1, 0, 0, 0, 0, 0, 1, 0

Nem DB "Nemecko", 0
Rak DB "Rakusko", 0
Svajc DB "Svajciarsko", 0
Licht DB "Lichtenstajnsko", 0
Pl DB "Polsko", 0
Cz DB "Cesko", 0
Sk DB "Slovensko", 0
Mad DB "Madarsko", 0
SL DB "Slovinsko", 0

PocetKrajin EQU 9

KrajinyNazvy DD Nem, Rak, Svajc, Licht, Pl, Cz, Sk, Mad, SL

Msg1 DB " pocet susedov: ", 0
Msg2 DB "Index statu s naviac susedmi", 0
Msg3 DB "Vlozte index krajiny ktorej susedov chcete vypisat ", 0
Msg4 DB "Susedia krajiny: ", 0
Rozdelovac DB ", ", 0

.code
PocetSusedov PROC USES ECX EAX EDX EBX ESI
    mov EBX, 0
    mov ECX, PocetKrajin
    mov ESI, 0
    PocetSusedovLoop:
        push ECX
        mov ECX, PocetKrajin
        mov EAX, 0

        KrajinaLoop:
            cmp Matica[ESI], 1
            jne nesusedi
            inc EAX
            
            nesusedi:
            inc ESI
        Loop KrajinaLoop
        
        mov EDX, krajinyNazvy[EBX * 4]
        call WriteString
        mov EDX, offset Msg1
        call WriteString
        call WriteInt
        call CRLF

        pop ECX
        inc EBX
    Loop PocetSusedovLoop

ret
PocetSusedov ENDP

NajvacSusedov PROC USES EAX EBX ESI EDX ECX EDI
    mov AL, 0
    mov ECX, pocetKrajin
    mov ESI, 0
    mov EBX, 0

    LoopRiadky:
        push ECX
        mov AH, 0

        mov ECX, pocetKrajin
        LoopStlpce:
            cmp Matica[ESI], 1
            jne nesusedi
            inc AH
            nesusedi:
            inc ESI
        Loop LoopStlpce
        
        cmp AH, BH
        jle maMenej 
        mov BL, AL
        mov BH, AH
        maMenej:

        pop ecx
        inc AL
    Loop LoopRiadky

    mov EDX, offset Msg2
    call WriteString
    movsx EAX, BL
    call WriteInt
    call CRLF


ret
NajvacSusedov ENDP

VypisSusedovKrajiny PROC USES EAX EBX ECX EDX ESI
    mov EDX, offset Msg3
    call WriteString
    call ReadInt
    mov EDX, offset Msg4
    call WriteString
    mov EBX, pocetKrajin
    mul EBX
    mov ESI, EAX
    mov EBX, 0
    mov ECX, pocetKrajin

    LoopHladajAVypis:
        
        cmp Matica[ESI], 1
        jne nesusedi
            mov EDX, KrajinyNazvy[EBX * 4]
            call WriteString
            mov EDX, offset Rozdelovac
            call WriteString
        nesusedi:
        inc ESI
        inc EBX
    Loop LoopHladajAVypis
    call CRLF
ret
VypisSusedovKrajiny ENDP


main PROC
	call Clrscr
    call PocetSusedov
    call CRLF
    call NajvacSusedov
    call CRLF
    call VypisSusedovKrajiny
	exit
main ENDP

END main