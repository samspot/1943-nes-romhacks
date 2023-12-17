; Run this in the simulator @ https://skilldrick.github.io/easy6502/

LDA #$17
STA $0715
JSR inc
LDA $0715
BRK

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

; main subroutine
; Insert at: FFDB rom: 01FFEB - 23 bytes
; first long fn goes through M1, M1-B, M6, M6-B, M10
inc:
JSR incloada ; ?? ?? ??
CMP #$01     ; ?? ??     ; M1-B
BEQ end1     ; ?? ??
CMP #$06     ; C9 0A     ; M6
BEQ end1     ; F0 0F     ; skip next bytes to 
CMP #$10     ; C9 12     ; M10
BEQ end1     ; F0 0B     ; skip next bytes to label:end
CMP #$11     ; ?? ??     ; M10-B
BEQ end1     ; ?? ??
JMP  part2   ; ?? ?? ??
end1:
RTS          ; ??
;JMP endrts   ; ?? ?? ??

; 12 Bytes for M10-B, M16, M16-B
; Insert (==TODO==) found 10 bytes at $FD8B, $E886, 
; Other sus locs $D9C3
; 64 bytes at $C4F3 ROM: 01C503
part2:

CMP #$16     ; C9 1E     ; M16
BEQ end2     ; ?? ??
CMP #$17     ; C9 1F     ; M16-B
BEQ end2     ; ?? ??
JMP part3    ; ?? ?? ??
end2:
RTS          ; ??
;JMP endrts   ; ?? ?? ??


; 12 Bytes for M24, M24-B
part3:
CMP #$24     ; C9 2E     ; M24
BEQ end3     ; F0 07     ; skip next bytes to label:end
CMP #$25     ; C9 2F     ; M24-B
BEQ end3     ; F0 03
JMP inc      ; 4C DB FF  ; jump to INX instruction address
end3:
;;; endrts:
RTS          ; 60

; 7 Bytes
; Insert at: $FFAD rom: 01FFBD
incloada:
INC $0715    ; ?? ?? ??
LDA $0715    ; ?? ?? ??
RTS          ; ??

