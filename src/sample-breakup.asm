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



LDA #$16
STA $0715
JSR inc
LDA $0715
BRK

; main subroutine
; Insert at: FFDB rom: 01FFEB - 26 bytes (25 bytes shortend)
; first long fn goes through M1, M1-B, M6, M6-B, M10
inc:
JSR incloada ; ?? ?? ??
CMP #$01     ; ?? ??     ; M1-B
BEQ end1     ; ?? ??
CMP #$06     ; C9 0A     ; M6
BEQ end1     ; F0 0F     ; skip next bytes to 
CMP #$07     ; ?? ??
BEQ end1     ; ?? ??
label:end
CMP #$10     ; C9 12     ; M10
BEQ end1     ; F0 0B     ; skip next bytes to label:end
JMP  part2   ; ?? ?? ??
end1:
JMP endrts   ; ?? ?? ??

; 12 Bytes for M16, M24
part2:
CMP #$16     ; C9 1E     ; M16
BEQ end2     ; F0 07     ; skip next bytes to label:end
CMP #$24     ; C9 2E     ; M24
BEQ end2     ; F0 03
JMP inc      ; 4C DB FF  ; jump to INX instruction address
end2:
endrts:
RTS          ; 60

; 7 Bytes
incloada:
INC $0715    ; ?? ?? ??
LDA $0715    ; ?? ?? ??
RTS          ; ??
