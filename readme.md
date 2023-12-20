
My First NES Romhack has 2 goals:

1. 1943's soundtrack is amazing, but quickly spoiled when you are below 20 energy and the warning music plays. This hack removes the warning music so you can enjoy Kumi Yamaga's stage music without interruption.
2. The original game has 24 levels, which I consider far too long. Modern SHMUPS typically have a 5 level structure and can be completed in about 30 minutes. This hack molds 1943 into that structure.

TODO: News post https://www.romhacking.net/news/addentrypage/

## Misc. Notes

m3 bomber no 3b
m9 bomber no 9b

0411 10's digit energy - look for this to go < 2
0410 1's digit, don't think we need to worry about it

key breakpoint

address: F48F
condition: $0411==#01

## Change upgrade points

$0347 is upgrade points

code:
06:A5BE ; A9 03 ; Sets points to always be 3 on start & pickup

### New Code during my frame break sequence

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

### ROM Info found online

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