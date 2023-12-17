; 0411 is energy tens

; caller needs to JSR 20 DB FF; AD 15 07
; insert at $F528 ROM: 01F538
LDA $0715   ; AD 15 07 ; $F525
JSR $FFDB   ; 20 DB FF ; $F528

; main subroutine
; Insert at: FFDB rom: 01FFEB - 26 bytes
inc:
INC $0715   ; EE 15 07
LDA $0715   ; AD 15 07
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