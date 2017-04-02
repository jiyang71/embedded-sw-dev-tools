;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 
; OFDM DSP RTL Test Program 
; - Ver 0.1 - this is for dspsim ver 1.6+
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Test Type 1b, 4b, 4d, 4f, 4h, 8b, 8d
; Initialization
	LD	I0, 0x1000
	LD	M0, 0x2
	LD	I4, 0x1020
	LD	M4, 0x2
	LD.C	R0,	(0x85C, 0xDA5)
	LD.C	R4,	(0x555, 0xCEF)
	LD.C	R6,	(0x403, 0x17F)
	LD	CNTR,	0x10
;
	DO	ll90	UNTIL CE
	ST.C	DM(I0 += M0), R0
	ST.C	DM(I4 += M4), R4
	ADD.C	R0, R0, R6 
ll90: SUBC.C	R4, R4, R6 
;
; Memory Dump at 0x1000
;--------
;1000: 85C DA5 C5F F24 062 0A3 465 222 868 3A1 C6B 520 06E 69F 471 81E 
;1010: 874 99D C77 B1C 07A C9B 47D E1A 880 F99 C83 118 086 297 489 416 
;1020: 555 CEF 151 B6F D4E 9F0 94A 870 546 6F0 142 570 D3F 3F0 93B 270 
;1030: 537 0F0 133 F70 D30 DF0 92C C70 528 AF0 124 971 D21 7F1 91D 671 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1020
	LD	I5, 0x1040
	LD	I7, 0x1080
	LD	M0, 0x2
	LD	M4, 0x2
	LD	M6, 0x2
	CLRACC.C ACC0
	CLRACC.C ACC2
	LD	CNTR,	0x10
;
	DO	ll91	UNTIL CE
	LD.C	R0, DM(I0 += M0) || LD.C R2, DM(I4 += M4)			; Type 1b
	ADD.C	R4, R0, R2 || LD.C R8, DM(I0 += M0)					; Type 4d
	MAC.C	ACC0, R0, R4 (SS) || LD.C R10, DM(I0 += M0)			; Type 4b
	SUB.C	R6, R0, R2 || CP.C R0, R8							; Type 8d
	MAS.C	ACC2, R0, R4 (SS) || CP.C R2, R10					; Type 8b
	ADDC.C	R4, R0, R2 || ST.C DM(I5 += M4), ACC2.L				; Type 4h
	MAC.C	ACC0, R0, R2 (SS) || ST.C DM(I5 += M4), ACC2.M		; Type 4f
	ST.C	DM(I7 += M6), ACC0.L
ll91: 
	ST.C	DM(I7 += M6), ACC0.M
;
; Memory Dump at 0x1000
;--------
;1000: 85C DA5 C5F F24 062 0A3 465 222 868 3A1 C6B 520 06E 69F 471 81E 
;1010: 874 99D C77 B1C 07A C9B 47D E1A 880 F99 C83 118 086 297 489 416 
;1020: 555 CEF 151 B6F D4E 9F0 94A 870 546 6F0 142 570 D3F 3F0 93B 270 
;1030: 537 0F0 133 F70 D30 DF0 92C C70 528 AF0 124 971 D21 7F1 91D 671 
;1040: 042 E60 F89 D4A 2C4 5A4 3DA 864 450 756 48F 5D9 3E4 630 2B6 814 
;1050: 6F0 CDA 2A2 B3B 856 4D4 141 1C5 8D2 3F4 EB1 AD6 14C B54 0AC 042 
;1060: 178 7D4 160 F96 1C8 3B4 79D EAF 610 538 774 852 738 E80 58D FA1 
;1070: 9D4 6DC AEF 31C 798 234 6FF 34F 45C 504 56D 29B 6A4 1AC 36A 6F5 
;1080: D54 314 080 587 51C 66C 55D F39 2A6 0A2 A4C 145 91C D28 962 A2A 
;1090: 02E 47E B38 318 0F4 7C2 0F0 ED5 358 EA2 34C 8DF 8D6 142 E35 232 
;10a0: B3A 562 9CA 2A7 142 652 958 3BB 6B6 2DA 6A2 D96 098 F02 BA1 081 
;10b0: BE8 18A 3B7 21D 05C 73E 6EF 9A4 F24 1CE 1A5 F11 A1C 274 174 978 
;--------
;
	NOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Test Type 12n, 12p, 14l
; Initialization
	LD	I0, 0x1000
	LD	M0, 0x2
	LD	I4, 0x1020
	LD	M4, 0x2
	LD.C	R0,	(0x85C, 0xDA5)
	LD.C	R4,	(0x555, 0xCEF)
	LD	CNTR,	0x10
;
	DO	ll80	UNTIL CE
	ST.C	DM(I0 += M0), R0
	ST.C	DM(I4 += M4), R4
	ASHIFT.C	R0, R0, -1 (NORND)
ll80: ASHIFT.C	R4, R4, 1 (NORND)
;
; Memory Dump at 0x1000
;--------
;1000: 85C DA5 C2E ED2 E17 F69 F0B FB4 F85 FDA FC2 FED FE1 FF6 FF0 FFB 
;1010: FF8 FFD FFC FFE FFE FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF 
;1020: 555 CEF AAA 9DE 554 3BC AA8 778 550 EF0 AA0 DE0 540 BC0 A80 780 
;1030: 500 F00 A00 E00 400 C00 800 800 000 000 000 000 000 000 000 000
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1020
	LD	I6, 0x1040
	LD	I1, 0x1000
	LD	I5, 0x1020
	LD	I7, 0x1060
	LD	M6, 0x2
	LD	CNTR,	0x10
	LD.C	ACC4.M, DM(I0 += M0) (LO)
;
	DO	ll81	UNTIL CE
	ASHIFT.C ACC0, ACC4, -7 (NORND)
	ST.C	DM(I7 += M6), ACC0.L
	ASHIFT.C ACC0, ACC4, -9 (NORND) || CP.C R2, ACC4.M				; Type 14l
	ST.C	DM(I7 += M6), ACC0.L
	ASHIFT.C ACC0, ACC4, -11 (NORND) || ST.C DM(I6 += M6), R2		; Type 12p
	ST.C	DM(I7 += M6), ACC0.L
	ASHIFT.C ACC0, ACC4, -13 (NORND) || LD.C ACC4.M, DM(I0 += M0)	; Type 12n
ll81: 
	ST.C	DM(I7 += M6), ACC0.L
;
; Memory Dump at 0x1000
;--------
;1000: 85C DA5 C2E ED2 E17 F69 F0B FB4 F85 FDA FC2 FED FE1 FF6 FF0 FFB 
;1010: FF8 FFD FFC FFE FFE FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF 
;1020: 555 CEF AAA 9DE 554 3BC AA8 778 550 EF0 AA0 DE0 540 BC0 A80 780 
;1030: 500 F00 A00 E00 400 C00 800 800 000 000 000 000 000 000 000 000 
;1040: 85C DA5 C2E ED2 E17 F69 F0B FB4 F85 FDA FC2 FED FE1 FF6 FF0 FFB 
;1050: FF8 FFD FFC FFE FFE FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF 
;1060: B80 4A0 2E0 D28 0B8 B4A C2E ED2 5C0 A40 170 690 85C DA4 E17 F69 
;1070: 2E0 D20 0B8 B48 C2E ED2 F0B FB4 160 680 858 DA0 E16 F68 F85 FDA 
;1080: 0A0 B40 C28 ED0 F0A FB4 FC2 FED 840 DA0 E10 F68 F84 FDA FE1 FF6 
;1090: C20 EC0 F08 FB0 FC2 FEC FF0 FFB E00 F60 F80 FD8 FE0 FF6 FF8 FFD 
;10a0: F00 FA0 FC0 FE8 FF0 FFA FFC FFE F80 FC0 FE0 FF0 FF8 FFC FFE FFF 
;10b0: FC0 FE0 FF0 FF8 FFC FFE FFF FFF FE0 FE0 FF8 FF8 FFE FFE FFF FFF 
;10c0: FE0 FE0 FF8 FF8 FFE FFE FFF FFF FE0 FE0 FF8 FF8 FFE FFE FFF FFF 
;10d0: FE0 FE0 FF8 FF8 FFE FFE FFF FFF FE0 FE0 FF8 FF8 FFE FFE FFF FFF 
;--------
;
	NOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Test Type 12f, 12h, 14d
; Initialization
	LD	I0, 0x1000
	LD	M0, 0x2
	LD	I4, 0x1020
	LD	M4, 0x2
	LD.C	R0,	(0x5C7, 0xCEC)
	LD.C	R4,	(0x7C5, 0xCEC)
	LD	CNTR,	0x10
;
	DO	ll70	UNTIL CE
	ST.C	DM(I0 += M0), R0
	ST.C	DM(I4 += M4), R4
	ASHIFT.C	R0, R0, -1 (NORND)
ll70: ASHIFT.C	R4, R4, 1 (NORND)
;
; Memory Dump at 0x1000
;--------
;1000: 5C7 CEC 2E3 E76 171 F3B 0B8 F9D 05C FCE 02E FE7 017 FF3 00B FF9 
;1010: 005 FFC 002 FFE 001 FFF 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 
;1020: 7C5 CEC F8A 9D8 F14 3B0 E28 760 C50 EC0 8A0 D80 140 B00 280 600 
;1030: 500 C00 A00 800 400 000 800 000 000 000 000 000 000 000 000 000 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1020
	LD	I6, 0x1040
	LD	I1, 0x1000
	LD	I5, 0x1020
	LD	I7, 0x1060
	LD	M6, 0x2
	LD	CNTR,	0x10
	LD.C	R0, DM(I0 += M0)
;
	DO	ll71	UNTIL CE
	ASHIFT.C ACC0, R0, 0 (LO)
	ST.C	DM(I7 += M6), ACC0.L
	ASHIFT.C ACC0, R0, -1 (LO) || CP.C R2, R0				; Type 14d
	ST.C	DM(I7 += M6), ACC0.L
	ASHIFT.C ACC0, R0, -2 (LO) || ST.C DM(I6 += M6), R2		; Type 12h
	ST.C	DM(I7 += M6), ACC0.L
	ASHIFT.C ACC0, R0, -3 (LO) || LD.C R0, DM(I0 += M0)		; Type 12f
ll71: 
	ST.C	DM(I7 += M6), ACC0.L
;
; Memory Dump at 0x1000
;--------
;1000: 5C7 CEC 2E3 E76 171 F3B 0B8 F9D 05C FCE 02E FE7 017 FF3 00B FF9 
;1010: 005 FFC 002 FFE 001 FFF 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 
;1020: 7C5 CEC F8A 9D8 F14 3B0 E28 760 C50 EC0 8A0 D80 140 B00 280 600 
;1030: 500 C00 A00 800 400 000 800 000 000 000 000 000 000 000 000 000 
;1040: 5C7 CEC 2E3 E76 171 F3B 0B8 F9D 05C FCE 02E FE7 017 FF3 00B FF9 
;1050: 005 FFC 002 FFE 001 FFF 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 
;1060: 5C7 CEC 2E3 E76 171 F3B 0B8 F9D 2E3 E76 171 F3B 0B8 F9D 05C FCE 
;1070: 171 F3B 0B8 F9D 05C FCE 02E FE7 0B8 F9D 05C FCE 02E FE7 017 FF3 
;1080: 05C FCE 02E FE7 017 FF3 00B FF9 02E FE7 017 FF3 00B FF9 005 FFC 
;1090: 017 FF3 00B FF9 005 FFC 002 FFE 00B FF9 005 FFC 002 FFE 001 FFF 
;10a0: 005 FFC 002 FFE 001 FFF 000 FFF 002 FFE 001 FFF 000 FFF 000 FFF 
;10b0: 001 FFF 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 
;10c0: 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 
;10d0: 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 000 FFF 
;--------
;
	NOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Test Type 1a
; Initialization
	LD	I0, 0x1000
	LD	M0, 0x1
	LD	I4, 0x1010
	LD	M4, 0x1
	LD.C	R0,	(0x855, 0x80)
	LD.C	R4,	(0x574, 0x7F)
	LD	CNTR,	0x10
;
	DO	ll0	UNTIL CE
	ST	DM(I0 += M0), R0
	ST	DM(I4 += M4), R4
	ADD	R0, R0, R1
ll0: SUB	R4, R4, R5
;
; Memory Dump at 0x1000
;--------
;1000: 855 8D5 955 9D5 A55 AD5 B55 BD5 C55 CD5 D55 DD5 E55 ED5 F55 FD5 
;1010: 574 4F5 476 3F7 378 2F9 27A 1FB 17C 0FD 07E FFF F80 F01 E82 E03 
;1020: FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF 
;1030: FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF 
;1040: FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF 
;1050: FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1010
	LD	I6, 0x1020
	LD	I1, 0x1000
	LD	I5, 0x1010
	LD	I7, 0x1040
	LD	M6, 0x1
	LD	CNTR,	0x10
	LD	R0, DM(I0 += M0)
	LD	R2, DM(I4 += M4)
	LD	R4, DM(I1 += M0)
	LD	R6, DM(I5 += M4)
;
	DO	ll1	UNTIL CE
	MPY		ACC0, R0, R2 (SS)	|| LD	 	R0, DM(I0 += M0)	|| LD		R2, DM(I4 += M4)
	ST	DM(I6 += M6), ACC0.L
	ST	DM(I6 += M6), ACC0.M
	MPY		ACC2, R4, R6 (SS)
	ST	DM(I7 += M6), ACC2.L
	ST	DM(I7 += M6), ACC2.M
	LD	R4, DM(I1 += M0)
ll1:
	LD	R6, DM(I5 += M4)
;
; Memory Dump at 0x1000
;--------
;1000: 855 8D5 955 9D5 A55 AD5 B55 BD5 C55 CD5 D55 DD5 E55 ED5 F55 FD5 
;1010: 574 4F5 476 3F7 378 2F9 27A 1FB 17C 0FD 07E FFF F80 F01 E82 E03 
;1020: F08 AC5 FB2 B8E 25C C48 706 CF1 DB0 D8A 65A E14 104 E8E DAE EF7 
;1030: C58 F51 D02 F9B FAC FD5 456 000 B00 01A 3AA 025 E54 01F AFE 00A 
;1040: F08 AC5 FB2 B8E 25C C48 706 CF1 DB0 D8A 65A E14 104 E8E DAE EF7 
;1050: C58 F51 D02 F9B FAC FD5 456 000 B00 01A 3AA 025 E54 01F AFE 00A 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1010
	LD	I6, 0x1020
	LD	I1, 0x1000
	LD	I5, 0x1010
	LD	I7, 0x1040
	LD	M6, 0x1
	LD	CNTR,	0x10
	LD	R0, DM(I0 += M0)
	LD	R2, DM(I4 += M4)
	LD	R4, DM(I1 += M0)
	LD	R6, DM(I5 += M4)
;
	DO	ll2	UNTIL CE
	MPY		ACC0, R0, R2 (RND)	|| LD	 	R0, DM(I0 += M0)	|| LD		R2, DM(I4 += M4)
	ST	DM(I6 += M6), ACC0.L
	ST	DM(I6 += M6), ACC0.M
	MPY		ACC2, R4, R6 (RND)
	ST	DM(I7 += M6), ACC2.L
	ST	DM(I7 += M6), ACC2.M
	LD	R4, DM(I1 += M0)
ll2:
	LD	R6, DM(I5 += M4)
;
; Memory Dump at 0x1000
;--------
;1000: 855 8D5 955 9D5 A55 AD5 B55 BD5 C55 CD5 D55 DD5 E55 ED5 F55 FD5 
;1010: 574 4F5 476 3F7 378 2F9 27A 1FB 17C 0FD 07E FFF F80 F01 E82 E03 
;1020: 708 AC6 7B2 B8F A5C C48 F06 CF1 5B0 D8B E5A E14 904 E8E 5AE EF8 
;1030: 458 F52 502 F9C 7AC FD6 C56 000 300 01B BAA 025 654 020 2FE 00B 
;1040: 708 AC6 7B2 B8F A5C C48 F06 CF1 5B0 D8B E5A E14 904 E8E 5AE EF8 
;1050: 458 F52 502 F9C 7AC FD6 C56 000 300 01B BAA 025 654 020 2FE 00B 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1010
	LD	I6, 0x1020
	LD	I1, 0x1000
	LD	I5, 0x1010
	LD	I7, 0x1040
	LD	M6, 0x1
	LD	CNTR,	0x10
	LD	R0, DM(I0 + M0)
	LD	R2, DM(I4 + M4)
	LD	R4, DM(I1 + M0)
	LD	R6, DM(I5 + M4)
;
	DO	ll3	UNTIL CE
	MPY		ACC0, R0, R2 (UU)	|| LD	 	R0, DM(I0 + M0)	|| LD		R2, DM(I4 + M4)
	ST	DM(I6 += M6), ACC0.L
	ST	DM(I6 += M6), ACC0.M
	MPY		ACC2, R4, R6 (UU)
	ST	DM(I7 += M6), ACC2.L
	ST	DM(I7 += M6), ACC2.M
	LD	R4, DM(I1 + M0)
ll3:
	LD	R6, DM(I5 + M4)
;
; Memory Dump at 0x1000
;--------
;1000: 855 8D5 955 9D5 A55 AD5 B55 BD5 C55 CD5 D55 DD5 E55 ED5 F55 FD5 
;1010: 574 4F5 476 3F7 378 2F9 27A 1FB 17C 0FD 07E FFF F80 F01 E82 E03 
;1020: FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 
;1030: FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 
;1040: FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 
;1050: FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 FB2 578 
;--------
;
	NOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Test Type 1b
; Initialization
	LD	I0, 0x1000
	LD	M0, 0x2
	LD	I4, 0x1020
	LD	M4, 0x2
	LD.C	R0,	(0xFFF, 0x800)
	LD.C	R2,	(0x047, 0x0CF)
	LD.C	R4,	(0x000, 0xFFF)
	LD.C	R6,	(0x080, 0x7FF)
	LD	CNTR,	0x10
;
	DO	ll10	UNTIL CE
	ST.C	DM(I0 += M0), R0
	ST.C	DM(I4 += M4), R4
	ADD.C	R0, R0, R2
ll10: SUB.C	R4, R4, R6
;
; Memory Dump at 0x1000
;--------
;1000: FFF 800 046 8CF 08D 99E 0D4 A6D 11B B3C 162 C0B 1A9 CDA 1F0 DA9 
;1010: 237 E78 27E F47 2C5 016 30C 0E5 353 1B4 39A 283 3E1 352 428 421 
;1020: 000 FFF F80 800 F00 001 E80 802 E00 003 D80 804 D00 005 C80 806 
;1030: C00 007 B80 808 B00 009 A80 80A A00 00B 980 80C 900 00D 880 80E 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1020
	LD	I6, 0x1040
	LD	I1, 0x1000
	LD	I5, 0x1020
	LD	I7, 0x1080
	LD	M6, 0x2
	LD	CNTR,	0x10
	LD.C	R0, DM(I0 += M0)
	LD.C	R2, DM(I4 += M4)
	LD.C	R4, DM(I1 += M0)
	LD.C	R6, DM(I5 += M4)
;
	DO	ll11	UNTIL CE
	MPY.C		ACC0, R0, R2 (SS)	|| LD.C	 	R0, DM(I0 += M0)	|| LD.C		R2, DM(I4 += M4)
	ST.C	DM(I6 += M6), ACC0.L
	ST.C	DM(I6 += M6), ACC0.M
	MPY.C		ACC2, R4, R6 (SS)
	ST.C	DM(I7 += M6), ACC2.L
	ST.C	DM(I7 += M6), ACC2.M
	LD.C	R4, DM(I1 += M0)
ll11:
	LD.C	R6, DM(I5 += M4)
;
; Memory Dump at 0x1000
;--------
;1000: FFF 800 046 8CF 08D 99E 0D4 A6D 11B B3C 162 C0B 1A9 CDA 1F0 DA9 
;1010: 237 E78 27E F47 2C5 016 30C 0E5 353 1B4 39A 283 3E1 352 428 421 
;1020: 000 FFF F80 800 F00 001 E80 802 E00 003 D80 804 D00 005 C80 806 
;1030: C00 007 B80 808 B00 009 A80 80A A00 00B 980 80C 900 00D 880 80E 
;1040: 000 002 FFF 000 A00 100 8CA 02D 2C4 51A FEF 0CC A4C C50 A46 037 
;1050: 098 6A2 FBB 131 5A8 410 B9E FDB 97C 49A F62 12F C14 840 CD1 F17 
;1060: D70 F02 EE5 0C5 D90 8E0 DE0 DEC C74 5DA E44 FF5 A1C 5F0 ECB C5A 
;1070: 688 922 D7F EBD 1B8 F70 F92 A60 BAC 8DA C95 D1E 464 560 034 800 
;1080: 000 002 FFF 000 A00 100 8CA 02D 2C4 51A FEF 0CC A4C C50 A46 037 
;1090: 098 6A2 FBB 131 5A8 410 B9E FDB 97C 49A F62 12F C14 840 CD1 F17 
;10a0: D70 F02 EE5 0C5 D90 8E0 DE0 DEC C74 5DA E44 FF5 A1C 5F0 ECB C5A 
;10b0: 688 922 D7F EBD 1B8 F70 F92 A60 BAC 8DA C95 D1E 464 560 034 800 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1020
	LD	I6, 0x1040
	LD	I1, 0x1000
	LD	I5, 0x1020
	LD	I7, 0x1080
	LD	M6, 0x2
	LD	CNTR,	0x10
	LD.C	R0, DM(I0 += M0)
	LD.C	R2, DM(I4 += M4)
	LD.C	R4, DM(I1 += M0)
	LD.C	R6, DM(I5 += M4)
;
	DO	ll12	UNTIL CE
	MPY.C		ACC0, R0, R2 (RND)	|| LD.C	 	R0, DM(I0 += M0)	|| LD.C		R2, DM(I4 += M4)
	ST.C	DM(I6 += M6), ACC0.L
	ST.C	DM(I6 += M6), ACC0.M
	MPY.C		ACC2, R4, R6 (RND)
	ST.C	DM(I7 += M6), ACC2.L
	ST.C	DM(I7 += M6), ACC2.M
	LD.C	R4, DM(I1 += M0)
ll12:
	LD.C	R6, DM(I5 += M4)
;
; Memory Dump at 0x1000
;--------
;1000: FFF 800 046 8CF 08D 99E 0D4 A6D 11B B3C 162 C0B 1A9 CDA 1F0 DA9 
;1010: 237 E78 27E F47 2C5 016 30C 0E5 353 1B4 39A 283 3E1 352 428 421 
;1020: 000 FFF F80 800 F00 001 E80 802 E00 003 D80 804 D00 005 C80 806 
;1030: C00 007 B80 808 B00 009 A80 80A A00 00B 980 80C 900 00D 880 80E 
;1040: 800 802 FFF 000 200 900 8CB 02D AC4 D1A FEF 0CC 24C 450 A47 038 
;1050: 898 EA2 FBB 131 DA8 C10 B9E FDB 17C C9A F63 12F 414 040 CD2 F18 
;1060: 570 702 EE6 0C6 590 0E0 DE1 DED 474 DDA E45 FF5 21C DF0 ECC C5A 
;1070: E88 122 D7F EBE 9B8 770 F92 A61 3AC 0DA C96 D1F C64 D60 034 800 
;1080: 800 802 FFF 000 200 900 8CB 02D AC4 D1A FEF 0CC 24C 450 A47 038 
;1090: 898 EA2 FBB 131 DA8 C10 B9E FDB 17C C9A F63 12F 414 040 CD2 F18 
;10a0: 570 702 EE6 0C6 590 0E0 DE1 DED 474 DDA E45 FF5 21C DF0 ECC C5A 
;10b0: E88 122 D7F EBE 9B8 770 F92 A61 3AC 0DA C96 D1F C64 D60 034 800 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1020
	LD	I6, 0x1040
	LD	I1, 0x1000
	LD	I5, 0x1020
	LD	I7, 0x1080
	LD	M6, 0x2
	LD	CNTR,	0x10
	LD.C	R0, DM(I0 + M0)
	LD.C	R2, DM(I4 + M4)
	LD.C	R4, DM(I1 + M0)
	LD.C	R6, DM(I5 + M4)
;
	DO	ll13	UNTIL CE
	MPY.C		ACC0, R0, R2 (UU)	|| LD.C	 	R0, DM(I0 + M0)	|| LD.C		R2, DM(I4 + M4)
	ST.C	DM(I6 += M6), ACC0.L
	ST.C	DM(I6 += M6), ACC0.M
	MPY.C		ACC2, R4, R6 (UU)
	ST.C	DM(I7 += M6), ACC2.L
	ST.C	DM(I7 += M6), ACC2.M
	LD.C	R4, DM(I1 + M0)
ll13:
	LD.C	R6, DM(I5 + M4)
;
; Memory Dump at 0x1000
;--------
;1000: FFF 800 046 8CF 08D 99E 0D4 A6D 11B B3C 162 C0B 1A9 CDA 1F0 DA9 
;1010: 237 E78 27E F47 2C5 016 30C 0E5 353 1B4 39A 283 3E1 352 428 421 
;1020: 000 FFF F80 800 F00 001 E80 802 E00 003 D80 804 D00 005 C80 806 
;1030: C00 007 B80 808 B00 009 A80 80A A00 00B 980 80C 900 00D 880 80E 
;1040: A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 
;1050: A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 
;1060: A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 
;1070: A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 
;1080: A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 
;1090: A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 
;10a0: A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 
;10b0: A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 A00 100 7B8 157 
;--------
;
	NOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Test Type 43a
; Initialization
	LD	I0, 0x1000
	LD	M0, 0x1
	LD	I4, 0x1010
	LD	M4, 0x1
	LD.C	R0,	(0x855, 0x80)
	LD.C	R4,	(0x574, 0x7F)
	LD	CNTR,	0x10
;
	DO	ll20	UNTIL CE
	ST	DM(I0 += M0), R0
	ST	DM(I4 += M4), R4
	ADD	R0, R0, R1
ll20: SUB	R4, R4, R5
;
; Memory Dump at 0x1000
;--------
;1000: 855 8D5 955 9D5 A55 AD5 B55 BD5 C55 CD5 D55 DD5 E55 ED5 F55 FD5 
;1010: 574 4F5 476 3F7 378 2F9 27A 1FB 17C 0FD 07E FFF F80 F01 E82 E03 
;1020: FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF 
;1030: FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF 
;1040: FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF 
;1050: FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF FFF 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1010
	LD	I6, 0x1020
	LD	I1, 0x1000
	LD	I5, 0x1010
	LD	I7, 0x1050
	LD	M6, 0x1
	LD	CNTR,	0x10
;
	DO	ll21	UNTIL CE
	LD	R0, DM(I0 += M0)
	LD	R2, DM(I4 += M4)
	LD	R4, DM(I1 += M0)
	LD	R6, DM(I5 += M4)
	ADD	R1, R0, R2 || MPY ACC0, R4, R6 (SS)
	ADD R3, R0, R2
	MPY ACC2, R4, R6 (SS)
	ST	DM(I6 += M6), R1
	ST	DM(I6 += M6), ACC0.L
	ST	DM(I6 += M6), ACC0.M
	ST	DM(I7 += M6), R3
	ST	DM(I7 += M6), ACC2.L
ll21: ST	DM(I7 += M6), ACC2.M
;
; Memory Dump at 0x1000
;--------
;1000: 855 8D5 955 9D5 A55 AD5 B55 BD5 C55 CD5 D55 DD5 E55 ED5 F55 FD5 
;1010: 574 4F5 476 3F7 378 2F9 27A 1FB 17C 0FD 07E FFF F80 F01 E82 E03 
;1020: DC9 F08 AC5 DCA FB2 B8E DCB 25C C48 DCC 706 CF1 DCD DB0 D8A DCE 
;1030: 65A E14 DCF 104 E8E DD0 DAE EF7 DD1 C58 F51 DD2 D02 F9B DD3 FAC 
;1040: FD5 DD4 456 000 DD5 B00 01A DD6 3AA 025 DD7 E54 01F DD8 AFE 00A 
;1050: DC9 F08 AC5 DCA FB2 B8E DCB 25C C48 DCC 706 CF1 DCD DB0 D8A DCE 
;1060: 65A E14 DCF 104 E8E DD0 DAE EF7 DD1 C58 F51 DD2 D02 F9B DD3 FAC 
;1070: FD5 DD4 456 000 DD5 B00 01A DD6 3AA 025 DD7 E54 01F DD8 AFE 00A 
;--------
;
	NOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Test Type 44b
; Initialization
	LD	I0, 0x1000
	LD	M0, 0x1
	LD	I4, 0x1010
	LD	M4, 0x1
	LD.C	R0,	(0x855, 0x13F)
	LD.C	R4,	(0x574, 0xCDE)
	LD	CNTR,	0x10
;
	DO	ll30	UNTIL CE
	ST	DM(I0 += M0), R0
	ST	DM(I4 += M4), R4
	ADD	R0, R0, R1
ll30: SUB	R4, R4, R5
;
; Memory Dump at 0x1000
;--------
;1000: 855 994 AD3 C12 D51 E90 FCF 10E 24D 38C 4CB 60A 749 888 9C7 B06 
;1010: 574 896 BB8 EDA 1FC 51E 840 B62 E84 1A6 4C8 7EA B0C E2E 150 472 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1010
	LD	I6, 0x1020
	LD	I1, 0x1000
	LD	I5, 0x1010
	LD	I7, 0x1050
	LD	M6, 0x1
	LD	CNTR,	0x10
;
	DO	ll31	UNTIL CE
	LD	R0, DM(I0 += M0)
	LD	R2, DM(I4 += M4)
	LD	R4, DM(I1 += M0)
	ADD	R1, R0, R2 || ASHIFT ACC0, R4, -3 (RND)
	ADD R3, R0, R2
	ASHIFT ACC2, R4, -3 (RND)
	ST	DM(I6 += M6), R1
	ST	DM(I6 += M6), ACC0.L
	ST	DM(I6 += M6), ACC0.M
	ST	DM(I7 += M6), R3
	ST	DM(I7 += M6), ACC2.L
ll31: ST	DM(I7 += M6), ACC2.M
;
; Memory Dump at 0x1000
;--------
;1000: 855 994 AD3 C12 D51 E90 FCF 10E 24D 38C 4CB 60A 749 888 9C7 B06 
;1010: 574 896 BB8 EDA 1FC 51E 840 B62 E84 1A6 4C8 7EA B0C E2E 150 472 
;1020: DC9 F0B FFF 22A F33 FFF 68B F5A FFF AEC F82 FFF F4D FAA FFF 3AE 
;1030: FD2 FFF 80F FFA FFF C70 022 000 0D1 04A 000 532 072 000 993 099 
;1040: 000 DF4 0C1 000 255 0E9 000 6B6 F11 FFF B17 F39 FFF F78 F61 FFF 
;1050: DC9 F0B FFF 22A F33 FFF 68B F5A FFF AEC F82 FFF F4D FAA FFF 3AE 
;1060: FD2 FFF 80F FFA FFF C70 022 000 0D1 04A 000 532 072 000 993 099 
;1070: 000 DF4 0C1 000 255 0E9 000 6B6 F11 FFF B17 F39 FFF F78 F61 FFF 
;--------
;
	NOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Test Type 44d
; Initialization
	LD	I0, 0x1000
	LD	M0, 0x1
	LD	I4, 0x1010
	LD	M4, 0x1
	LD.C	R0,	(0xA58, 0xFFF)
	LD.C	R4,	(0x135, 0xCDE)
	LD	CNTR,	0x10
;
	DO	ll40	UNTIL CE
	ST	DM(I0 += M0), R0
	ST	DM(I4 += M4), R4
	ADD	R0, R0, R1
ll40: SUB	R4, R4, R5
;
; Memory Dump at 0x1000
;--------
;1000: A58 A57 A56 A55 A54 A53 A52 A51 A50 A4F A4E A4D A4C A4B A4A A49 
;1010: 135 457 779 A9B DBD 0DF 401 723 A45 D67 089 3AB 6CD 9EF D11 033 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1010
	LD	I6, 0x1020
	LD	I1, 0x1000
	LD	I5, 0x1010
	LD	I7, 0x1050
	LD	M6, 0x1
	LD	CNTR,	0x10
;
	DO	ll41	UNTIL CE
	LD	R0, DM(I0 += M0)
	LD	R2, DM(I4 += M4)
	LD	ACC1.L, DM(I1 += M0)
	LD	ACC1.M, 0x0
	ADD	R1, R0, R2 || ASHIFT ACC0, ACC1, -3 (RND)
	ADD R3, R0, R2
	ASHIFT ACC2, ACC1, -3 (RND)
	ST	DM(I6 += M6), R1
	ST	DM(I6 += M6), ACC0.L
	ST	DM(I6 += M6), ACC0.M
	ST	DM(I7 += M6), R3
	ST	DM(I7 += M6), ACC2.L
ll41: ST	DM(I7 += M6), ACC2.M
;
; Memory Dump at 0x1000
;--------
;1000: A58 A57 A56 A55 A54 A53 A52 A51 A50 A4F A4E A4D A4C A4B A4A A49 
;1010: 135 457 779 A9B DBD 0DF 401 723 A45 D67 089 3AB 6CD 9EF D11 033 
;1020: B8D 14B 000 EAE 14B 000 1CF 14B 000 4F0 14B 000 811 14B 000 B32 
;1030: 14A 000 E53 14A 000 174 14A 000 495 14A 000 7B6 14A 000 AD7 14A 
;1040: 000 DF8 14A 000 119 14A 000 43A 149 000 75B 149 000 A7C 149 000 
;1050: B8D 14B 000 EAE 14B 000 1CF 14B 000 4F0 14B 000 811 14B 000 B32 
;1060: 14A 000 E53 14A 000 174 14A 000 495 14A 000 7B6 14A 000 AD7 14A 
;1070: 000 DF8 14A 000 119 14A 000 43A 149 000 75B 149 000 A7C 149 000 
;--------
;
	NOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Test Type 45b
; Initialization
	LD	I0, 0x1000
	LD	M0, 0x1
	LD	I4, 0x1010
	LD	M4, 0x1
	LD.C	R0,	(0x647, 0x933)
	LD.C	R4,	(0x001, 0x357)
	LD	CNTR,	0x10
;
	DO	ll50	UNTIL CE
	ST	DM(I0 += M0), R0
	ST	DM(I4 += M4), R4
	ADD	R0, R0, R1
ll50: SUB	R4, R4, R5
;
; Memory Dump at 0x1000
;--------
;1000: 647 F7A 8AD 1E0 B13 446 D79 6AC FDF 912 245 B78 4AB DDE 711 044 
;1010: 001 CAA 953 5FC 2A5 F4E BF7 8A0 549 1F2 E9B B44 7ED 496 13F DE8 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1010
	LD	I6, 0x1020
	LD	I1, 0x1000
	LD	I5, 0x1010
	LD	I7, 0x1060
	LD	M6, 0x1
	CLRACC	ACC3
	CLRACC	ACC4
	LD	CNTR,	0x10
;
	DO	ll51	UNTIL CE
	LD	R0, DM(I0 += M0)
	LD	R2, DM(I4 += M4)
	LD	R4, DM(I1 += M0)
	MAC	ACC3, R0, R2 (SS) || ASHIFT ACC0, R4, -1 (RND)
	MAC ACC4, R0, R2 (SS)
	ASHIFT ACC2, R4, -1 (RND)
	ST	DM(I6 += M6), ACC3.L
	ST	DM(I6 += M6), ACC3.M
	ST	DM(I6 += M6), ACC0.L
	ST	DM(I6 += M6), ACC0.M
	ST	DM(I7 += M6), ACC4.L
	ST	DM(I7 += M6), ACC4.M
	ST	DM(I7 += M6), ACC2.L
ll51: ST	DM(I7 += M6), ACC2.M
;
; Memory Dump at 0x1000
;--------
;1000: 647 F7A 8AD 1E0 B13 446 D79 6AC FDF 912 245 B78 4AB DDE 711 044 
;1010: 001 CAA 953 5FC 2A5 F4E BF7 8A0 549 1F2 E9B B44 7ED 496 13F DE8 
;1020: C8E 000 324 000 A96 038 FBD FFF 4C4 655 C57 FFF 5C4 7BC 0F0 000 
;1030: 842 61B D8A FFF 6EA 5BC 223 000 C68 702 EBD FFF 368 0DC 356 000 
;1040: 696 0C6 FF0 FFF 09E F17 C89 FFF C2C EB1 123 000 3EC 160 DBC FFF 
;1050: 28A 600 256 000 2B2 4C7 EEF FFF F10 5E0 389 000 250 5CF 022 000 
;1060: C8E 000 324 000 A96 038 FBD FFF 4C4 655 C57 FFF 5C4 7BC 0F0 000 
;1070: 842 61B D8A FFF 6EA 5BC 223 000 C68 702 EBD FFF 368 0DC 356 000 
;1080: 696 0C6 FF0 FFF 09E F17 C89 FFF C2C EB1 123 000 3EC 160 DBC FFF 
;1090: 28A 600 256 000 2B2 4C7 EEF FFF F10 5E0 389 000 250 5CF 022 000 
;--------
;
	NOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Test Type 45d
; Initialization
	LD	I0, 0x1000
	LD	M0, 0x1
	LD	I4, 0x1010
	LD	M4, 0x1
	LD.C	R0,	(0x100, 0xABC)
	LD.C	R4,	(0x800, 0x080)
	LD	CNTR,	0x10
;
	DO	ll60	UNTIL CE
	ST	DM(I0 += M0), R0
	ST	DM(I4 += M4), R4
	ADD	R0, R0, R1
ll60: SUB	R4, R4, R5
;
; Memory Dump at 0x1000
;--------
;1000: 100 BBC 678 134 BF0 6AC 168 C24 6E0 19C C58 714 1D0 C8C 748 204 
;1010: 800 780 700 680 600 580 500 480 400 380 300 280 200 180 100 080 
;--------
;
	LD	I0, 0x1000
	LD	I4, 0x1010
	LD	I6, 0x1020
	LD	I1, 0x1000
	LD	I5, 0x1010
	LD	I7, 0x1060
	LD	M6, 0x1
	CLRACC	ACC3
	CLRACC	ACC4
	LD	CNTR,	0x10
;
	DO	ll61	UNTIL CE
	LD	R0, DM(I0 += M0)
	LD	R2, DM(I4 += M4)
	LD	ACC1.L, DM(I1 += M0)
	LD	ACC1.M, DM(I5 += M4)
	MAC	ACC3, R0, R2 (SS) || ASHIFT ACC0, ACC1, -1 (RND)
	MAC ACC4, R0, R2 (SS)
	ASHIFT ACC2, ACC1, -1 (RND)
	ST	DM(I6 += M6), ACC3.L
	ST	DM(I6 += M6), ACC3.M
	ST	DM(I6 += M6), ACC0.L
	ST	DM(I6 += M6), ACC0.M
	ST	DM(I7 += M6), ACC4.L
	ST	DM(I7 += M6), ACC4.M
	ST	DM(I7 += M6), ACC2.L
ll61: ST	DM(I7 += M6), ACC2.M
;
; Memory Dump at 0x1000
;--------
;1000: 100 BBC 678 134 BF0 6AC 168 C24 6E0 19C C58 714 1D0 C8C 748 204 
;1010: 800 780 700 680 600 580 500 480 400 380 300 280 200 180 100 080 
;1020: 000 F00 080 C00 400 B00 5DE 3C0 400 0A9 33C 380 800 1A3 09A 340 
;1030: 800 E97 5F8 300 C00 32D 356 2C0 C00 40E 0B4 280 000 1E3 612 240 
;1040: 000 553 370 200 400 607 0CE 1C0 400 4A8 62C 180 800 6DE 38A 140 
;1050: 800 752 0E8 100 C00 6AC 646 0C0 C00 795 3A4 080 000 7B6 102 040 
;1060: 000 F00 080 C00 400 B00 5DE 3C0 400 0A9 33C 380 800 1A3 09A 340 
;1070: 800 E97 5F8 300 C00 32D 356 2C0 C00 40E 0B4 280 000 1E3 612 240 
;1080: 000 553 370 200 400 607 0CE 1C0 400 4A8 62C 180 800 6DE 38A 140 
;1090: 800 752 0E8 100 C00 6AC 646 0C0 C00 795 3A4 080 000 7B6 102 040 
;--------
;
	NOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;