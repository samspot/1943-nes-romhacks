; 0411 is energy tens


; Skips Needed
;
; M1-A (value = 00)
; M1-B (value = 01)
; M6-A (value = 0A)
; M10-A (value = 12)
; M10-B TODO
; M16-A (value = 1E)
; M16-B TODO
; M24-A (value = 2E)
; M24-B TODO

; caller needs to JSR 20 DB FF; AD 15 07
; insert at $F528 ROM: 01F538
LDA $0715   ; AD 15 07 ; $F525
;;;; JSR $FFDB   ; 20 DB FF ; $F528
JSR $C4F3   ; 20 F3 C4 ; $C4F3

; main subroutine
; Insert at: C4F3 rom: 01C503 - 42 bytes
inc:        ; address is: $C4F3
INC $0715   ; EE 15 07
LDA $0715   ; AD 15 07
CMP #$01    ; C9 01     ; M1-B
BEQ end     ; F0 1F
CMP #$06    ; C9 0A     ; M6
BEQ end     ; F0 1B     ; skip ?? bytes to label:end
CMP #$10    ; C9 12     ; M10
BEQ end     ; F0 17     ; skip ?? bytes to label:end
CMP #$11    ; C9 13     ; M10-B
BEQ end     ; F0 13     ; skip ??
CMP #$16    ; C9 1E     ; M16
BEQ end     ; F0 0F     ; skip next bytes to label:end
CMP #$17    ; C9 1F     ; M16-B
BEQ end     ; F0 0B
CMP #$24    ; C9 2E     ; M24
BEQ end     ; F0 07
CMP #$25    ; C9 2F     ; M24-B
BEQ end     ; F0 03
JMP inc     ; 4C F3 C4  ; jump to INX instruction address
end:
RTS         ; 60