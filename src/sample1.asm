; init level to zero 
LDA #$23
STA $0715

; fn advance to next level
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

; fn sample
LDX $0715
INX
INX 
INX
STX $0725

; sample code
STA $0200
LDA #$05
STA $0201
LDA #$08
STA $05fe
LDA #$08
STA $05ff