TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

MaticaSusednosti DB 01101100b
				 DB 10110111b
				 DB 11010000b
                 DB 01100000b
                 DB 10000110b
                 DB 11001010b
                 DB 01001101b
                 DB 01000010b
                 
Nem DB "Nemecko ", 0
Rak DB "Rakusko ", 0
Sva DB "Svajciarsko ", 0
Lic DB "Lichtenstajnsko ", 0
Pol DB "Polsko ", 0
Czk DB "Cesko ", 0
Svk DB "Slovensko ", 0
Mad DB "Madarsko ", 0

KrajinyNazvy DD Nem, Rak, Sva, Lic, Pol, Czk, Svk, Mad

pocetKrajin EQU 8

Msg1 DB "Krajina s najvacsim poctom susedov: ", 0
Msg2 DB "Zvolene krajiny susedia", 0
Msg3 DB "Zvolene krajiny nesusedia", 0

.code
susedovANajviac PROC USES EAX EBX ECX EDX EDI ; tato procedura riesi cast A) a C)
    mov EDI, 0              ;index krajiny ktoru teraz spracuva
    mov ECX, pocetKrajin    ;pocitadlo pre loop
    mov EAX, 0              ;hladanie krajiny s najvacsim poctom susedov
    mov EBX, 0              ;nacita riadko matice a aj 1 aby sme si and-dom z nej mohli vybrat hodnotu

    LoopCezVsetky:
        mov bh, MaticaSusednosti[EDI]
        push ECX
        mov ECX, pocetKrajin
        mov EDX, 0

        LoopRiadok:
            mov bl, 1
            and bl, bh
            cmp bl, 1
            jne nesusedia
                inc edx
            nesusedia:
            shr bh, 1
        LOOP LoopRiadok

        pop ecx
        cmp ah, dl
        jge nieJeViac
            mov eax, edi ; ulozi index krajiny s najviac susedmi do eax
            mov ah, dl   ; ulozi pocet susedov do vrchnej casti ax, tak neprepise index krajiny v spodnej casti
        nieJeViac:

        push EAX ; odlozime si info o docasne najvacsiej krajine
        push EDX ; odlozime si pocet susedov momentalnej krajiny
        mov EDX, KrajinyNazvy[EDI * 4]
        call WriteString
        pop EAX ; zoberieme si pocet susedov momentalnej krajiny
        call WriteInt
        pop EAX ; zoberie si info o docasne najvacsiej krajine
        call CRLF
        
        inc EDI
        LOOP LoopCezVsetky
    mov EDX, offset Msg1
    call WriteString
    movzx EDX, AL
    mov EDX, KrajinyNazvy[EDX * 4]
    call WriteString
    call CRLF
        
ret
susedovANajviac ENDP

SusediaZIndexu PROC uses EAX EBX ECX EDX
    call ReadInt
    mov EBX, EAX ; naciatany index si ulozime
    call ReadInt

    mov ECX, pocetKrajin - 1 ; treba odcítat 1 lebo chceme index krajiny a indexy su (0..7) napr 8 - 5 = 3 co by odobralo 3 ale my chceme aby odobralo po 5 cize 2 takze 7-5 = 2
    SUB ECX, EAX ; odcitame index od konca, aby sme vedeli kolko razy shiftnut aby sme sa dostali ku danemu bitu

    mov bh, MaticaSusednosti[EBX]
    
    cmp EBX, 0
    je loopSaNekona ; lebo loop sa vzdy vykona aspon raz
    
    ;treba sa dostat ku danemu bitu ktory drzi informaciu o susednosti
    LoopPosuvania:
        shr bh, 1
    Loop LoopPosuvania
    loopSaNekona:

    mov bl, 1
    and bl, bh
    cmp bl, 1
    
    jne nesusedia
    mov edx, offset Msg2
   
    jmp koniec
    nesusedia:
    mov edx, offset Msg3

    koniec:
    call WriteString

ret
SusediaZIndexu ENDP

main PROC
    call susedovANajviac
    call SusediaZIndexu

exit
main ENDP
END main