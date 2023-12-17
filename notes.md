## level edit 12/16/23

Best So Far! Thoughts

1. Add more lines with the necessary B stages M1, M10, M16, M24. Need a lotta bytes
2. Try to split this between more memory locations. For example JMP inc could go to a theoretical 2nd half with more conditions
3. any new subroutine needs 14 bytes minimum for INC, LDA, CMP, BEQ, JMP ???, RTS. And it handles just one condition.
4. Need to handle 4 more conditions...


### Works! But breaks B-stages :( :(
### Try starting earlier FFDB rom: 01FFEB - 26 bytes
; 0411 is energy tens
; caller needs to JSR 20 DB FF; AD 15 07
inc:
INC $1507   ; EE 15 07
LDA $1507   ; AD 15 07
CMP #$06    ; C9 0A     ; M6
BEQ end     ; F0 0F     ; skip next bytes to label:end
CMP #$10    ; C9 12     ; M10
BEQ end     ; F0 0B     ; skip next bytes to label:end
CMP #$16    ; C9 1E     ; M16
BEQ end     ; F0 07     ; skip next bytes to label:end
CMP #$24    ; C9 2E     ; M24
BEQ end     ; F0 03
JMP inc     ; 4C DB FF  ; jump to INX instruction address
end:
RTS         ; 60

### Others

Insert code at 07:FFE5 in the debugger. 01FFF5 in the rom, gives 11 bytes

Prior to that, at 0f:FFE3 do: Unconditional branch to 07:FFF1 to skip my new code (if necessary)

DEB 07:F525: EE 15 07 => INC $0715 ; repeats on next line 01F538 in ROM
; replace with
JSR $FFE2 ; jump to new subroutine - 20 e2 ff
; replace prev EE 15 07 with something to copy the value into X
LDA $0715 ; AD 15 07

; fn shorter 12 max byte version @ FFE2 (01FFF2)
; currently 15 bytes
;LDX $0715   ; A2 15 07
;LDA $0715   ; AD 15 07 ; Do this before we start
TAX         ; AA
inc:
INX         ; E8
CPX #$06    ; E4 06 ; BAD trying to do memory not literal value
BEQ end     ; F0 03 ; skip next two bytes
JMP inc     ; 4C E3 FF  ; jump to INX instruction address
end:
STX $0715   ; 96 15 07 ; BAD also not right, how do we do it?
RTS         ; 60

### WORK WORK WORK 1 Level
New Verions w/ inc 0715 in place = WORKS!
; fn shorter 12 max byte version @ FFE2 (01FFF2)
; currently 14 bytes
inc:
INC $1507   ; EE 15 07
LDA #$06    ; A9 0A     ; this is mission 6 for some reason...
CMP $1507   ; CD 15 07  ; BAD trying to do memory not literal value
BEQ end     ; F0 03     ; skip next two bytes
JMP inc     ; 4C E2 FF  ; jump to INX instruction address
end:
RTS         ; 60

Try and get more levels in now...
### WORK WORK WORK 2 Levels! 21 Bytes
inc:
INC $1507   ; EE 15 07
LDA #$06    ; A9 0A     ; Load Mission 6
CMP $1507   ; CD 15 07  ; 
BEQ end     ; F0 0A     ; skip next bytes to label:end
LDA #$10    ; A9 12     ; Load Mission 10
CMP $1507   ; CD 15 07  ;
BEQ end     ; F0 03     ; skip next bytes to label:end
JMP inc     ; 4C E2 FF  ; jump to INX instruction address
end:
RTS         ; 60

### Try and simplify the compare 26 bytes
inc:
INC $1507   ; EE 15 07
LDA $1507   ; A9 15 07
CMP #$06    ; C9 0A
BEQ end     ; F0 0F     ; skip next bytes to label:end
CMP #$10    ; C9 12
BEQ end     ; F0 0B     ; skip next bytes to label:end
CMP #$16    ; C9 16
BEQ end     ; F0 07     ; skip next bytes to label:end
CMP #$24    ; C9 20
BEQ end     ; F0 03
JMP inc     ; 4C E2 FF  ; jump to INX instruction address
end:
RTS         ; 60

## Works! But breaks B-stages :( :(
### Try starting earlier FFDB rom: 01FFEB - 26 bytes
; 0411 is energy tens
; caller needs to JSR 20 DB FF; AD 15 07
inc:
INC $1507   ; EE 15 07
LDA $1507   ; AD 15 07
CMP #$06    ; C9 0A     ; M6
BEQ end     ; F0 0F     ; skip next bytes to label:end
CMP #$10    ; C9 12     ; M10
BEQ end     ; F0 0B     ; skip next bytes to label:end
CMP #$16    ; C9 1E     ; M16
BEQ end     ; F0 07     ; skip next bytes to label:end
CMP #$24    ; C9 2E     ; M24
BEQ end     ; F0 03
JMP inc     ; 4C DB FF  ; jump to INX instruction address
end:
RTS         ; 60


### Jump craziness?
inc:
INC $1507   ; EE 15 07
LDA #$24    ; A9 ??     ; Load Mission 24 
LDA #$16    ; A9 ??     ; Load Mission 16
LDA #$10    ; A9 12     ; Load Mission 10
LDA #$06    ; A9 0A     ; Load Mission 6

CMP $1507   ; CD 15 07  ;
BEQ end     ; F0 03     ; skip next bytes to label:end
JMP inc     ; 4C E2 FF  ; jump to INX instruction address
end:
RTS         ; 60

### failed attempts at a subroutine
; sample caller
LDA #$06    ; A9 0A
JSR ?? ??   ; 20 ?? ??
BEQ end
LDA #$10    ; A9 12
JSR ?? ??   ; 20 ?? ??
BEQ end

; routine
INC $1507
CMP $1507
;;; SCRATCH THIS: BMI / BPL to the INC instruction
RTS

; caller





; fn advance to next level 24 bytes
LDX $0715
inc:
INX
CPX #$06
BEQ end
CPX #$10
BEQ end
CPX #$16
BEQ end
CPX #$24
BEQ end
BNE inc
end:
STX $0715
RTS

## Old

0411 10's digit energy - look for this to go < 2
0410 1's digit, don't think we need to worry about it

key breakpoint

address: F48F
condition: $0411==#01

New Code during my frame break sequence

Breakpoint 1 Hit at $F48F: $F48F:EC--X- Condition:$0411==#01
(2658 lines skipped)
A:01 X:00 Y:02 S:FD P:NvUbdIzc   $D56E: A5 87     LDA $87 = #$00
A:00 X:00 Y:02 S:FD P:nvUbdIZc   $D570: D0 06     BNE $D578
A:00 X:00 Y:02 S:FD P:nvUbdIZc   $D572: E6 87     INC $87 = #$00
A:00 X:00 Y:02 S:FD P:nvUbdIzc   $D574: A9 0B     LDA #$0B
A:0B X:00 Y:02 S:FD P:nvUbdIzc   $D576: 85 58     STA $58 = #$F0
(8377 lines skipped)
A:00 X:24 Y:8C S:F9 P:nvUbdIZc       $DD1D: A9 01     LDA #$01
A:01 X:24 Y:8C S:F9 P:nvUbdIzc       $DD1F: 4C 20 C0  JMP $C020
Breakpoint 1 Hit at $F48F: $F48F:EC--X- Condition:$0411==#01
(7012 lines skipped)
A:00 X:24 Y:CC S:FB P:nvUbdIZc     $DCD6: DE 00 05  DEC $0500,X @ $0524 = #$18
A:00 X:24 Y:CC S:FB P:nvUbdIzc     $DCD9: F0 74     BEQ $DD4F
A:00 X:24 Y:CC S:FB P:nvUbdIzc     $DCDB: BD 00 05  LDA $0500,X @ $0524 = #$17
A:17 X:24 Y:CC S:FB P:nvUbdIzc     $DCDE: 4A        LSR
A:0B X:24 Y:CC S:FB P:nvUbdIzC     $DCDF: 4A        LSR
A:05 X:24 Y:CC S:FB P:nvUbdIzC     $DCE0: 0A        ASL
A:0A X:24 Y:CC S:FB P:nvUbdIzc     $DCE1: A8        TAY
A:0A X:24 Y:0A S:FB P:nvUbdIzc     $DCE2: BD 03 05  LDA $0503,X @ $0527 = #$E0
A:E0 X:24 Y:0A S:FB P:NvUbdIzc     $DCE5: 85 03     STA $03 = #$AF
A:E0 X:24 Y:0A S:FB P:NvUbdIzc     $DCE7: BD 05 05  LDA $0505,X @ $0529 = #$C6
A:C6 X:24 Y:0A S:FB P:NvUbdIzc     $DCEA: 85 02     STA $02 = #$5F
Breakpoint 1 Hit at $F48F: $F48F:EC--X- Condition:$0411==#01
Breakpoint 1 Hit at $F48F: $F48F:EC--X- Condition:$0411==#01
Breakpoint 1 Hit at $F48F: $F48F:EC--X- Condition:$0411==#01


1943's soundtrack is amazing, but quickly spoiled when you are below 20 energy and the warning music plays. This hack removes the warning music so you can enjoy Kumi Yamaga's stage music without interruption.






* NES RAM line 03E0 position 3 & 4 are at 20 constantly
    - Not it



    Hi, I'm new to romhacking but I have some high-level programming experience and a tiny bit of assembler from 20 years ago in college (MASM to be exact).

I've been perusing the newbie guides but they are mostly concerned with art & text, but I'm more interested in modifying gameplay. The newbie guides are a bit of a dead end, referring to resources that don't exist like (https://www.romhacking.net/forum/index.php?topic=12539.0)

Can you help me with what tools I should be looking at in 2023 or some good resources?

Specifically what I want to do is hack 1943 NES

* Remove low-energy music (My guess is i can find "20" somewhere and change it to "1" or "0")
* Create some shorter packs of 5 levels. Probably there's a way to modify a jump instruction to go from level 1 to level 5 at the end of a stage. I have no idea how to go about find that. Should I try to dissassemble? Can I edit hex?

Thanks for your consideration.


Things to explore

FCEUX has awesome dev features

https://datacrystal.romhacking.net/wiki/1943:ROM_map



https://datacrystal.romhacking.net/wiki/1943:RAM_map

0x0347 - Number of credits (not exclusively)
0x0402 - Gun selection (also used in ending)
0x0410 - One's digit in energy status
0x0411 - Ten's digit in energy
0x04F6 - One's digit in special weapon status
0x04F7 - Ten's digit in special weapon
0x0416 - Right bullet selection
0x041b - Angle of right bullet
0x0424 - Left bullet selection
0x0429 - Angle of left bullet

Disputed
0x0347 - Number of credits (not exclusively)
0x0347 - How many points you have to power up your plane in the upgrade menu
Note: These descriptions mean the same thing.


0x0412 - Energy MSB
0x0412 - Hundred's digit in energy
Note: These descriptions mean the same thing.


0x04F8 - Weapon time MSB
0x04F8 - Hundred's digit in special weapon