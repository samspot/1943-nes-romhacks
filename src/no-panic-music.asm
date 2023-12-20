; $D56E ROM: 01D57E
; I don't remember exactly what I changed. Probably just adjusted something from STA to NOP or RTS

; Original ROM Code
D0 06 - BNE $D578
E6 87 - INC $87
A9 0B  - LDA #$0B
85 58 - ST $58 
60 - RTS

; Modded to (My notes have a mistake here)
D0 06 - BNE $D578
E6 87 - INC $87
A9 0B  - LDA #$0B
85 58 - ST $58 
60 - RTS