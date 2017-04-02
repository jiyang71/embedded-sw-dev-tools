;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; This is an implementation example for OFDM DSP.
; - Ver 0.1 - this is for dspsim ver 1.6+ 
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Note:
; This is a scalar-only version - no MULTIFUNCTION instruction employed.
; All scaling operations implemented for precise fixed-point arithmetic.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .DATA
	.VAR	x0[128]		; input array (complex pair)			- IWL:0 (0x000)
	.VAR	s1[128]		; stage 1 output (complex pair)			- IWL:1 (0x080)
	.VAR	s2[128]		; stage 2 output (complex pair)			- IWL:2 (0x100)
	.VAR	s3[128]		; stage 3 output (complex pair)			- IWL:3 (0x180)
	.VAR	s4[128]		; stage 4 output (complex pair)			- IWL:4 (0x200)
	.VAR	s5[128]		; stage 5 output (complex pair)			- IWL:5 (0x280)
	.VAR	y6[128]		; output array (complex pair)			- IWL:6 (0x300)
	.VAR	coeff[128]	; W(n)_64 FFT coeff. (complex pair)		- IWL:0 (0x380) - ** Note: we use only half of this table **
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .CODE	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Initialize Coefficients
	LD	I0, coeff		; Coeff. begin address
	LD	M0, 0x1
	NOP					; 1-clock delay needed for Ix/Mx register use
; autogenerated initializing code
	ST	DM(I0+=M0), 0x7FF		; Re of 1.000000	(Coeff.#0, IWL:0)
	ST	DM(I0+=M0), 0x000		; Im of 0.000000
	ST	DM(I0+=M0), 0x7F6		; Re of 0.995185	(Coeff.#1, IWL:0)
	ST	DM(I0+=M0), 0xF38		; Im of -0.098017
	ST	DM(I0+=M0), 0x7D8		; Re of 0.980785	(Coeff.#2, IWL:0)
	ST	DM(I0+=M0), 0xE71		; Im of -0.195090
	ST	DM(I0+=M0), 0x7A7		; Re of 0.956940	(Coeff.#3, IWL:0)
	ST	DM(I0+=M0), 0xDAE		; Im of -0.290285
	ST	DM(I0+=M0), 0x764		; Re of 0.923880	(Coeff.#4, IWL:0)
	ST	DM(I0+=M0), 0xCF1		; Im of -0.382683
	ST	DM(I0+=M0), 0x70E		; Re of 0.881921	(Coeff.#5, IWL:0)
	ST	DM(I0+=M0), 0xC3B		; Im of -0.471397
	ST	DM(I0+=M0), 0x6A6		; Re of 0.831470	(Coeff.#6, IWL:0)
	ST	DM(I0+=M0), 0xB8F		; Im of -0.555570
	ST	DM(I0+=M0), 0x62F		; Re of 0.773010	(Coeff.#7, IWL:0)
	ST	DM(I0+=M0), 0xAED		; Im of -0.634393
	ST	DM(I0+=M0), 0x5A8		; Re of 0.707107	(Coeff.#8, IWL:0)
	ST	DM(I0+=M0), 0xA58		; Im of -0.707107
	ST	DM(I0+=M0), 0x513		; Re of 0.634393	(Coeff.#9, IWL:0)
	ST	DM(I0+=M0), 0x9D1		; Im of -0.773010
	ST	DM(I0+=M0), 0x471		; Re of 0.555570	(Coeff.#10, IWL:0)
	ST	DM(I0+=M0), 0x95A		; Im of -0.831470
	ST	DM(I0+=M0), 0x3C5		; Re of 0.471397	(Coeff.#11, IWL:0)
	ST	DM(I0+=M0), 0x8F2		; Im of -0.881921
	ST	DM(I0+=M0), 0x30F		; Re of 0.382683	(Coeff.#12, IWL:0)
	ST	DM(I0+=M0), 0x89C		; Im of -0.923880
	ST	DM(I0+=M0), 0x252		; Re of 0.290285	(Coeff.#13, IWL:0)
	ST	DM(I0+=M0), 0x859		; Im of -0.956940
	ST	DM(I0+=M0), 0x18F		; Re of 0.195090	(Coeff.#14, IWL:0)
	ST	DM(I0+=M0), 0x828		; Im of -0.980785
	ST	DM(I0+=M0), 0x0C8		; Re of 0.098017	(Coeff.#15, IWL:0)
	ST	DM(I0+=M0), 0x80A		; Im of -0.995185
	ST	DM(I0+=M0), 0x000		; Re of -0.000000	(Coeff.#16, IWL:0)
	ST	DM(I0+=M0), 0x800		; Im of -1.000000
	ST	DM(I0+=M0), 0xF38		; Re of -0.098017	(Coeff.#17, IWL:0)
	ST	DM(I0+=M0), 0x80A		; Im of -0.995185
	ST	DM(I0+=M0), 0xE71		; Re of -0.195090	(Coeff.#18, IWL:0)
	ST	DM(I0+=M0), 0x828		; Im of -0.980785
	ST	DM(I0+=M0), 0xDAE		; Re of -0.290285	(Coeff.#19, IWL:0)
	ST	DM(I0+=M0), 0x859		; Im of -0.956940
	ST	DM(I0+=M0), 0xCF1		; Re of -0.382683	(Coeff.#20, IWL:0)
	ST	DM(I0+=M0), 0x89C		; Im of -0.923880
	ST	DM(I0+=M0), 0xC3B		; Re of -0.471397	(Coeff.#21, IWL:0)
	ST	DM(I0+=M0), 0x8F2		; Im of -0.881921
	ST	DM(I0+=M0), 0xB8F		; Re of -0.555570	(Coeff.#22, IWL:0)
	ST	DM(I0+=M0), 0x95A		; Im of -0.831470
	ST	DM(I0+=M0), 0xAED		; Re of -0.634393	(Coeff.#23, IWL:0)
	ST	DM(I0+=M0), 0x9D1		; Im of -0.773010
	ST	DM(I0+=M0), 0xA58		; Re of -0.707107	(Coeff.#24, IWL:0)
	ST	DM(I0+=M0), 0xA58		; Im of -0.707107
	ST	DM(I0+=M0), 0x9D1		; Re of -0.773010	(Coeff.#25, IWL:0)
	ST	DM(I0+=M0), 0xAED		; Im of -0.634393
	ST	DM(I0+=M0), 0x95A		; Re of -0.831470	(Coeff.#26, IWL:0)
	ST	DM(I0+=M0), 0xB8F		; Im of -0.555570
	ST	DM(I0+=M0), 0x8F2		; Re of -0.881921	(Coeff.#27, IWL:0)
	ST	DM(I0+=M0), 0xC3B		; Im of -0.471397
	ST	DM(I0+=M0), 0x89C		; Re of -0.923880	(Coeff.#28, IWL:0)
	ST	DM(I0+=M0), 0xCF1		; Im of -0.382683
	ST	DM(I0+=M0), 0x859		; Re of -0.956940	(Coeff.#29, IWL:0)
	ST	DM(I0+=M0), 0xDAE		; Im of -0.290285
	ST	DM(I0+=M0), 0x828		; Re of -0.980785	(Coeff.#30, IWL:0)
	ST	DM(I0+=M0), 0xE71		; Im of -0.195090
	ST	DM(I0+=M0), 0x80A		; Re of -0.995185	(Coeff.#31, IWL:0)
	ST	DM(I0+=M0), 0xF38		; Im of -0.098017
	ST	DM(I0+=M0), 0x800		; Re of -1.000000	(Coeff.#32, IWL:0)
	ST	DM(I0+=M0), 0x000		; Im of 0.000000
	ST	DM(I0+=M0), 0x80A		; Re of -0.995185	(Coeff.#33, IWL:0)
	ST	DM(I0+=M0), 0x0C8		; Im of 0.098017
	ST	DM(I0+=M0), 0x828		; Re of -0.980785	(Coeff.#34, IWL:0)
	ST	DM(I0+=M0), 0x18F		; Im of 0.195090
	ST	DM(I0+=M0), 0x859		; Re of -0.956940	(Coeff.#35, IWL:0)
	ST	DM(I0+=M0), 0x252		; Im of 0.290285
	ST	DM(I0+=M0), 0x89C		; Re of -0.923880	(Coeff.#36, IWL:0)
	ST	DM(I0+=M0), 0x30F		; Im of 0.382683
	ST	DM(I0+=M0), 0x8F2		; Re of -0.881921	(Coeff.#37, IWL:0)
	ST	DM(I0+=M0), 0x3C5		; Im of 0.471397
	ST	DM(I0+=M0), 0x95A		; Re of -0.831470	(Coeff.#38, IWL:0)
	ST	DM(I0+=M0), 0x471		; Im of 0.555570
	ST	DM(I0+=M0), 0x9D1		; Re of -0.773010	(Coeff.#39, IWL:0)
	ST	DM(I0+=M0), 0x513		; Im of 0.634393
	ST	DM(I0+=M0), 0xA58		; Re of -0.707107	(Coeff.#40, IWL:0)
	ST	DM(I0+=M0), 0x5A8		; Im of 0.707107
	ST	DM(I0+=M0), 0xAED		; Re of -0.634393	(Coeff.#41, IWL:0)
	ST	DM(I0+=M0), 0x62F		; Im of 0.773010
	ST	DM(I0+=M0), 0xB8F		; Re of -0.555570	(Coeff.#42, IWL:0)
	ST	DM(I0+=M0), 0x6A6		; Im of 0.831470
	ST	DM(I0+=M0), 0xC3B		; Re of -0.471397	(Coeff.#43, IWL:0)
	ST	DM(I0+=M0), 0x70E		; Im of 0.881921
	ST	DM(I0+=M0), 0xCF1		; Re of -0.382683	(Coeff.#44, IWL:0)
	ST	DM(I0+=M0), 0x764		; Im of 0.923880
	ST	DM(I0+=M0), 0xDAE		; Re of -0.290285	(Coeff.#45, IWL:0)
	ST	DM(I0+=M0), 0x7A7		; Im of 0.956940
	ST	DM(I0+=M0), 0xE71		; Re of -0.195090	(Coeff.#46, IWL:0)
	ST	DM(I0+=M0), 0x7D8		; Im of 0.980785
	ST	DM(I0+=M0), 0xF38		; Re of -0.098017	(Coeff.#47, IWL:0)
	ST	DM(I0+=M0), 0x7F6		; Im of 0.995185
	ST	DM(I0+=M0), 0x000		; Re of 0.000000	(Coeff.#48, IWL:0)
	ST	DM(I0+=M0), 0x7FF		; Im of 1.000000
	ST	DM(I0+=M0), 0x0C8		; Re of 0.098017	(Coeff.#49, IWL:0)
	ST	DM(I0+=M0), 0x7F6		; Im of 0.995185
	ST	DM(I0+=M0), 0x18F		; Re of 0.195090	(Coeff.#50, IWL:0)
	ST	DM(I0+=M0), 0x7D8		; Im of 0.980785
	ST	DM(I0+=M0), 0x252		; Re of 0.290285	(Coeff.#51, IWL:0)
	ST	DM(I0+=M0), 0x7A7		; Im of 0.956940
	ST	DM(I0+=M0), 0x30F		; Re of 0.382683	(Coeff.#52, IWL:0)
	ST	DM(I0+=M0), 0x764		; Im of 0.923880
	ST	DM(I0+=M0), 0x3C5		; Re of 0.471397	(Coeff.#53, IWL:0)
	ST	DM(I0+=M0), 0x70E		; Im of 0.881921
	ST	DM(I0+=M0), 0x471		; Re of 0.555570	(Coeff.#54, IWL:0)
	ST	DM(I0+=M0), 0x6A6		; Im of 0.831470
	ST	DM(I0+=M0), 0x513		; Re of 0.634393	(Coeff.#55, IWL:0)
	ST	DM(I0+=M0), 0x62F		; Im of 0.773010
	ST	DM(I0+=M0), 0x5A8		; Re of 0.707107	(Coeff.#56, IWL:0)
	ST	DM(I0+=M0), 0x5A8		; Im of 0.707107
	ST	DM(I0+=M0), 0x62F		; Re of 0.773010	(Coeff.#57, IWL:0)
	ST	DM(I0+=M0), 0x513		; Im of 0.634393
	ST	DM(I0+=M0), 0x6A6		; Re of 0.831470	(Coeff.#58, IWL:0)
	ST	DM(I0+=M0), 0x471		; Im of 0.555570
	ST	DM(I0+=M0), 0x70E		; Re of 0.881921	(Coeff.#59, IWL:0)
	ST	DM(I0+=M0), 0x3C5		; Im of 0.471397
	ST	DM(I0+=M0), 0x764		; Re of 0.923880	(Coeff.#60, IWL:0)
	ST	DM(I0+=M0), 0x30F		; Im of 0.382683
	ST	DM(I0+=M0), 0x7A7		; Re of 0.956940	(Coeff.#61, IWL:0)
	ST	DM(I0+=M0), 0x252		; Im of 0.290285
	ST	DM(I0+=M0), 0x7D8		; Re of 0.980785	(Coeff.#62, IWL:0)
	ST	DM(I0+=M0), 0x18F		; Im of 0.195090
	ST	DM(I0+=M0), 0x7F6		; Re of 0.995185	(Coeff.#63, IWL:0)
	ST	DM(I0+=M0), 0x0C8		; Im of 0.098017
;---------------------------------------------------------------------------
; Function y = fft64(x)
;---------------------------------------------------------------------------
; Function Input: x (IWL = 0)
;---------------------------------------------------------------------------
; Stage 1: N = 2, r = 0, IWL = 1, W(r)_2 = W(32r)_64
; Stage Input: x (IWL = 0), Stage Output: s1 (IWL = 1);
;---------------------------------------------------------------------------
; if size(x) ~= [64 1]
;     error('fft size is not [64 1]')
; else
;	for ii=0:31
;		s1(ii+1:32:64,1) = fft2(x(ii+1:32:64,1));
;		;; s1[ii+ 0] = x[ii+ 0] + x[ii+32]
;		;; s1[ii+32] = x[ii+ 0] - x[ii+32]
;	end
;
		LD	CNTR, 32
;		LD	I0, 0x000				; I0 = &x0[0]
		LD	I0, x0					; I0 = &x0[0]
		LD	M0, 2			
;		LD	I2, 0x040				; I2 = &x0[32]
		LD	I2, x0 + 64				; I2 = &x0[32]
		LD	M2, 2
;		LD	I4, 0x080				; I4 = &s1[0]
		LD	I4, s1					; I4 = &s1[0]
		LD	M4, 2	
;		LD	I6, 0x0C0				; I6 = &s1[32]
		LD	I6, s1 + 64				; I6 = &s1[32]
		LD	M6, 2
;
		DO	ll1	UNTIL	CE
		CLRACC.C	ACC0				; ACC0 <= 0					
		CLRACC.C	ACC2				; ACC2 <= 0					
		LD.C	ACC0.M, DM(I0+=M0) 		; ACC0.M = *I0++;			(IWL:0)
		LD.C	ACC2.M, DM(I2+=M2) 		; ACC2.M = *I2++;			(IWL:0)
		ASHIFT.C	ACC0, ACC0, -1 (NORND) 		; ACC0 = (ACC0>>1); (IWL:0)
		ASHIFT.C	ACC2, ACC2, -1 (NORND) 		; ACC2 = (ACC2>>1); (IWL:0)
		ADD.C	ACC4, ACC0, ACC2		; ACC4 = ACC0 + ACC2;		(IWL:1)
		SUB.C	ACC6, ACC0, ACC2		; ACC6 = ACC0 - ACC2;		(IWL:1)
		ST.C	DM(I4+=M4), ACC4.M		; *I4++ = ACC4.M; 			(IWL:1)
ll1:	ST.C	DM(I6+=M6), ACC6.M		; *I6++ = ACC6.M; 			(IWL:1)
;
;---------------------------------------------------------------------------
; Stage 2: N = 4, r = 0 ~ 1, IWL = 2, W(r)_4 = W(16r)_64
; Stage Input: s1 (IWL = 1), Stage Output: s2 (IWL = 2);
;---------------------------------------------------------------------------
; for jj=0:15
;	for ii=0:1
;		s2(jj+ii*16+1:32:64,1) = fft2(exp(-j*pi*(0:1)'*ii/2).*s1(jj+ii*32+1:16:jj+ii*32+32,1));
; 		;; s2[jj+ii*16+ 0] = s1[jj+ii*32+0] + W(ii*16)_64 * s1[jj+ii*32+16];
; 		;; s2[jj+ii*16+32] = s1[jj+ii*32+0] - W(ii*16)_64 * s1[jj+ii*32+16];
;	end
; end
;
		LD	CNTR, 16
;
;		LD	I1, 0x080				; I1 = &s1[0]
		LD	I1, s1					; I1 = &s1[0]
		CP.C	R22, I1				; backup I1 to R22
;
;		LD	I4, 0x100				; I4 = &s2[0];
		LD	I4, s2					; I4 = &s2[0];
		CP.C	R20, I4				; backup I4 to R20
;
		LD	M1, 32					; for s1[x+16] addressing with s1[x] address
		LD	M5, 64					; for s2[x+32] addressing with s2[x] address
; begin: outer loop
		DO ll20 UNTIL CE
		LD	CNTR, 2
;
		CP.C	I0, R22				; I0 = &s1[jj]
		LD	M0, 64					; M0 = 32*2 (complex pair)
;
;		LD	I7, 0x380				; I7 = &W[0] 
		LD	I7, coeff				; I7 = &W[0] 
		LD	M7, 32					; 16*2 (complex pair)
;
		CP.C	I4, R20				; I4 = &s2[jj]
		LD	M4, 32					; 16*2 (complex pair)
; begin: inner loop
		DO	ll2	UNTIL CE
		LD.C	R2, DM(I0+M1)		; R2  <= s1[jj+ii*32+16] = *(I0+16);			(IWL:1)
		CLRACC.C	ACC0			; ACC0 <= 0					
		LD.C	ACC0.M, DM(I0+=M0)	; ACC0.M  <= s1[jj+ii*32] = *I0, I0 += 32;		(IWL:1)
		CP.C	ACC2, ACC0			; ACC2 <= s1[jj+ii*32] = ACC0;					(IWL:1)
		LD.C	R8, DM(I7+=M7);		; R8  <= W(ii*16)_64, I7 += 16;					(IWL:0)
		ASHIFT.C	ACC6, R8, -1 (HI)		; ACC6.M <= (R8>>1)						(IWL:1)
		CP.C	R8, ACC6.M			; R8 <= ACC6.M									(IWL:1)
		ASHIFT.C	ACC0, ACC0, -1 (NORND)	; ACC0 <= (ACC0>>1);					(IWL:2)
		ASHIFT.C	ACC2, ACC2, -1 (NORND)	; ACC2 <= (ACC2>>1);					(IWL:2)
		MAC.C	ACC0, R2, R8 (SS)	; ACC0 <= ACC0 + (R2 * R8);						(IWL:1+1): Fractional Mode
		MAS.C	ACC2, R2, R8 (SS)	; ACC2 <= ACC2 - (R2 * R8);						(IWL:1+1): Fractional Mode
		ST.C	DM(I4+M5), ACC2.M	; s2[jj+ii*16+32] = *(I4+32) <= ACC2.M;			(IWL:2)
ll2:	ST.C	DM(I4+=M4), ACC0.M	; s2[jj+ii*16   ] = *I4 <= ACC0.M, I4 += 16;	(IWL:2)
; end: inner loop
		ADD	R22, R22, 2				; R22 <= R22 + 2 = &s1[0] + jj, jj++;
ll20:	ADD	R20, R20, 2				; R20 <= R20 + 2 = &s2[0] + jj, jj++;
; end: outer loop
;
;---------------------------------------------------------------------------
; Stage 3: N = 8, r = 0 ~ 3, IWL = 3, W(r)_8 = W(8r)_64
;---------------------------------------------------------------------------
; for jj=0:7
;	for ii=0:3
;		s3(jj+ii*8+1:32:64,1) = fft2(exp(-j*pi*(0:1)'*ii/4).*s2(jj+ii*16+1:8:jj+ii*16+16,1));
; 		;; s3[jj+ii*8+ 0] = s2[jj+ii*16+0] + W(ii*8)_64 * s2[jj+ii*16+8];
; 		;; s3[jj+ii*8+32] = s2[jj+ii*16+0] - W(ii*8)_64 * s2[jj+ii*16+8];
;	end
; end
;
		LD	CNTR, 8
;
;		LD	I1, 0x100				; I1 = &s2[0]
		LD	I1, s2					; I1 = &s2[0]
		CP.C	R22, I1				; backup I1 to R22
;
;		LD	I4, 0x180				; I4 = &s3[0];
		LD	I4, s3					; I4 = &s3[0];
		CP.C	R20, I4				; backup I4 to R20
;
		LD	M1, 16					; for s2[x+ 8] addressing with s2[x] address
;		LD	M5, 64					; for s3[x+32] addressing with s3[x] address
; begin: outer loop
		DO ll30 UNTIL CE
		LD	CNTR, 4
;
		CP.C	I0, R22				; I0 = &s2[jj]
		LD	M0, 32					; M0 = 16*2 (complex pair)
;
;		LD	I7, 0x380				; I7 = &W[0] 
		LD	I7, coeff				; I7 = &W[0] 
		LD	M7, 16					; 8*2 (complex pair)
;
		CP.C	I4, R20				; I4 = &s3[jj]
		LD	M4, 16					; 8*2 (complex pair)
; begin: inner loop
		DO	ll3	UNTIL CE
		LD.C	R2, DM(I0+M1)		; R2  <= s2[jj+ii*16+8] = *(I0+8);				(IWL:2)
		CLRACC.C	ACC0			; ACC0 <= 0					
		LD.C	ACC0.M, DM(I0+=M0)	; ACC0.M  <= s2[jj+ii*16] = *I0, I0 += 16;		(IWL:2)
		CP.C	ACC2, ACC0			; ACC2 <= s2[jj+ii*16] = ACC0;					(IWL:2)
		LD.C	R8, DM(I7+=M7);		; R8  <= W(ii*8)_64, I7 += 8;					(IWL:0)
		ASHIFT.C	ACC6, R8, -1 (HI)		; ACC6.M <= (R8>>1)						(IWL:1)
		CP.C	R8, ACC6.M			; R8 <= ACC6.M									(IWL:1)
		ASHIFT.C	ACC0, ACC0, -1 (NORND)	; ACC0 <= (ACC0>>1);					(IWL:3)
		ASHIFT.C	ACC2, ACC2, -1 (NORND)	; ACC2 <= (ACC2>>1);					(IWL:3)
		MAC.C	ACC0, R2, R8 (SS)	; ACC0 <= ACC0 + (R2 * R8);						(IWL:2+1): Fractional Mode
		MAS.C	ACC2, R2, R8 (SS)	; ACC2 <= ACC2 - (R2 * R8);						(IWL:2+1): Fractional Mode
		ST.C	DM(I4+M5), ACC2.M	; s3[jj+ii*8+32] = *(I4+32) <= ACC2.M;			(IWL:3)
ll3:	ST.C	DM(I4+=M4), ACC0.M	; s3[jj+ii*8   ] = *I4 <= ACC0.M, I4 += 8;		(IWL:3)
; end: inner loop
		ADD	R22, R22, 2				; R22 <= R22 + 2 = &s2[0] + jj, jj++;
ll30:	ADD	R20, R20, 2				; R20 <= R20 + 2 = &s3[0] + jj, jj++;
; end: outer loop
;
;---------------------------------------------------------------------------
; Stage 4: N = 16, r = 0 ~ 7, IWL = 4, W(r)_16 = W(4r)_64
;---------------------------------------------------------------------------
; for jj=0:3
;	for ii=0:7
;		s4(jj+ii*4+1:32:64,1) = fft2(exp(-j*pi*(0:1)'*ii/8).*s3(jj+ii*8+1:4:jj+ii*8+8,1));
; 		;; s4[jj+ii*4+ 0] = s3[jj+ii*8+0] + W(ii*4)_64 * s3[jj+ii*8+4];
; 		;; s4[jj+ii*4+32] = s3[jj+ii*8+0] - W(ii*4)_64 * s3[jj+ii*8+4];
; 	end
; end
;
		LD	CNTR, 4
;
;		LD	I1, 0x180				; I1 = &s3[0]
		LD	I1, s3					; I1 = &s3[0]
		CP.C	R22, I1				; backup I1 to R22
;
;		LD	I4, 0x200				; I4 = &s4[0];
		LD	I4, s4					; I4 = &s4[0];
		CP.C	R20, I4				; backup I4 to R20
;
		LD	M1, 8					; for s3[x+ 4] addressing with s3[x] address
;		LD	M5, 64					; for s4[x+32] addressing with s4[x] address
; begin: outer loop
		DO ll40 UNTIL CE
		LD	CNTR, 8
;
		CP.C	I0, R22				; I0 = &s3[jj]
		LD	M0, 16					; M0 = 8*2 (complex pair)
;
;		LD	I7, 0x380				; I7 = &W[0] 
		LD	I7, coeff				; I7 = &W[0] 
		LD	M7, 8					; 4*2 (complex pair)
;
		CP.C	I4, R20				; I4 = &s4[jj]
		LD	M4, 8					; 4*2 (complex pair)
; begin: inner loop
		DO	ll4	UNTIL CE
		LD.C	R2, DM(I0+M1)		; R2  <= s3[jj+ii*8+4] = *(I0+4);			(IWL:3)
		CLRACC.C	ACC0			; ACC0 <= 0					
		LD.C	ACC0.M, DM(I0+=M0)	; ACC0.M  <= s3[jj+ii*8] = *I0, I0 += 8;	(IWL:3)
		CP.C	ACC2, ACC0			; ACC2 <= s3[jj+ii*8] = ACC0;				(IWL:3)
		LD.C	R8, DM(I7+=M7);		; R8  <= W(ii*4)_64, I7 += 4;				(IWL:0)
		ASHIFT.C	ACC6, R8, -1 (HI)	; ACC6.M <= (R8>>1)						(IWL:1)
		CP.C	R8, ACC6.M			; R8 <= ACC6.M								(IWL:1)
		ASHIFT.C	ACC0, ACC0, -1 (NORND)	; ACC0 <= (ACC0>>1);				(IWL:4)
		ASHIFT.C	ACC2, ACC2, -1 (NORND)	; ACC2 <= (ACC2>>1);				(IWL:4)
		MAC.C	ACC0, R2, R8 (SS)	; ACC0 <= ACC0 + (R2 * R8);					(IWL:3+1): Fractional Mode
		MAS.C	ACC2, R2, R8 (SS)	; ACC2 <= ACC2 - (R2 * R8);					(IWL:3+1): Fractional Mode
		ST.C	DM(I4+M5), ACC2.M	; s4[jj+ii*4+32] = *(I4+32) <= ACC2.M;		(IWL:4)
ll4:	ST.C	DM(I4+=M4), ACC0.M	; s4[jj+ii*4   ] = *I4 <= ACC0.M, I4 += 4;	(IWL:4)
; end: inner loop
		ADD	R22, R22, 2				; R22 <= R22 + 2 = &s3[0] + jj, jj++;
ll40:	ADD	R20, R20, 2				; R20 <= R20 + 2 = &s4[0] + jj, jj++;
; end: outer loop
;
;---------------------------------------------------------------------------
; Stage 5: N = 32, r = 0 ~ 15, IWL = 5, W(r)_32 = W(2r)_64
;---------------------------------------------------------------------------
; for jj=0:1
;   for ii=0:15
;		s5(jj+ii*2+1:32:64,1) = fft2(exp(-j*pi*(0:1)'*ii/16).*s4(jj+ii*4+1:2:jj+ii*4+4,1));
; 		;; s5[jj+ii*2+ 0] = s4[jj+ii*4+0] + W(ii*2)_64 * s4[jj+ii*4+2];
; 		;; s5[jj+ii*2+32] = s4[jj+ii*4+0] - W(ii*2)_64 * s4[jj+ii*4+2];
; 	end
; end
;
		LD	CNTR, 2
;
;		LD	I1, 0x200				; I1 = &s4[0]
		LD	I1, s4					; I1 = &s4[0]
		CP.C	R22, I1				; backup I1 to R22
;
;		LD	I4, 0x280				; I4 = &s5[0];
		LD	I4, s5					; I4 = &s5[0];
		CP.C	R20, I4				; backup I4 to R20
;
		LD	M1, 4					; for s4[x+ 2] addressing with s4[x] address
;		LD	M5, 64					; for s5[x+32] addressing with s5[x] address
; begin: outer loop
		DO ll50 UNTIL CE
		LD	CNTR, 16
;
		CP.C	I0, R22				; I0 = &s4[jj]
		LD	M0, 8					; M0 = 4*2 (complex pair)
;
;		LD	I7, 0x380				; I7 = &W[0] 
		LD	I7, coeff				; I7 = &W[0] 
		LD	M7, 4					; 2*2 (complex pair)
;
		CP.C	I4, R20				; I4 = &s5[jj]
		LD	M4, 4					; 2*2 (complex pair)
; begin: inner loop
		DO	ll5	UNTIL CE
		LD.C	R2, DM(I0+M1)		; R2  <= s4[jj+ii*4+2] = *(I0+2);			(IWL:4)
		CLRACC.C	ACC0			; ACC0 <= 0					
		LD.C	ACC0.M, DM(I0+=M0)	; ACC0.M  <= s4[jj+ii*4] = *I0, I0 += 4;	(IWL:4)
		CP.C	ACC2, ACC0			; ACC2 <= s4[jj+ii*4] = ACC0;				(IWL:4)
		LD.C	R8, DM(I7+=M7);		; R8  <= W(ii*2)_64, I7 += 2;				(IWL:0)
		ASHIFT.C	ACC6, R8, -1 (HI)	; ACC6.M <= (R8>>1)						(IWL:1)
		CP.C	R8, ACC6.M			; R8 <= ACC6.M								(IWL:1)
		ASHIFT.C	ACC0, ACC0, -1 (NORND)	; ACC0 <= (ACC0>>1);				(IWL:5)
		ASHIFT.C	ACC2, ACC2, -1 (NORND)	; ACC2 <= (ACC2>>1);				(IWL:5)
		MAC.C	ACC0, R2, R8 (SS)	; ACC0 <= ACC0 + (R2 * R8);					(IWL:4+1): Fractional Mode
		MAS.C	ACC2, R2, R8 (SS)	; ACC2 <= ACC2 - (R2 * R8);					(IWL:4+1): Fractional Mode
		ST.C	DM(I4+M5), ACC2.M	; s5[jj+ii*2+32] = *(I4+32) <= ACC2.M;		(IWL:5)
ll5:	ST.C	DM(I4+=M4), ACC0.M	; s5[jj+ii*2   ] = *I4 <= ACC0.M, I4 += 2;	(IWL:5)
; end: inner loop
		ADD	R22, R22, 2				; R22 <= R22 + 2 = &s4[0] + jj, jj++;
ll50:	ADD	R20, R20, 2				; R20 <= R20 + 2 = &s5[0] + jj, jj++;
; end: outer loop
;---------------------------------------------------------------------------
; Stage 6: N = 64, r = 0 ~ 31, IWL = 6, W(r)_64
;---------------------------------------------------------------------------
; for ii=0:31
; 	s6(ii+1:32:64,1) = fft2(exp(-j*pi*(0:1)'*ii/32).*s5(ii*2+1:1:ii*2+2,1));
; 		;; s6[ii+ 0] = s5[ii*2+0] + W(ii)_64 * s5[ii*2+1];
; 		;; s6[ii+32] = s5[ii*2+0] - W(ii)_64 * s5[ii*2+1];
; end
; y = s6;
; end
;
		LD	M1, 2					; for s5[x+ 1] addressing with s5[x] address
;		LD	M5, 64					; for y[x+32] addressing with y[x] address
		LD	CNTR, 32
;
;		LD	I0, 0x280				; I0 = &s5[0]
		LD	I0, s5					; I0 = &s5[0]
		LD	M0, 4					; M0 = 2*2 (complex pair)
;
;		LD	I7, 0x380				; I7 = &W[0] 
		LD	I7, coeff				; I7 = &W[0] 
		LD	M7, 2					; 1*2 (complex pair)
;
;		LD	I4, 0x300				; I4 = &y[0];
		LD	I4, y6					; I4 = &y[0];
		LD	M4, 2					; 1*2 (complex pair)
; begin: inner loop
		DO	ll6	UNTIL CE
		LD.C	R2, DM(I0+M1)		; R2  <= s5[ii*2+1] = *(I0+1);				(IWL:5)
		CLRACC.C	ACC0			; ACC0 <= 0					
		LD.C	ACC0.M, DM(I0+=M0)	; ACC0.M  <= s5[ii*2] = *I0, I0 += 2;		(IWL:5)
		CP.C	ACC2, ACC0			; ACC2 <= s5[ii*2] = ACC0;					(IWL:5)
		LD.C	R8, DM(I7+=M7);		; R8  <= W(ii*1)_64, I7 += 1;				(IWL:0)
		ASHIFT.C	ACC6, R8, -1 (HI)	; ACC6.M <= (R8>>1)						(IWL:1)
		CP.C	R8, ACC6.M			; R8 <= ACC6.M								(IWL:1)
		ASHIFT.C	ACC0, ACC0, -1 (NORND)	; ACC0 <= (ACC0>>1);				(IWL:6)
		ASHIFT.C	ACC2, ACC2, -1 (NORND)	; ACC2 <= (ACC2>>1);				(IWL:6)
		MAC.C	ACC0, R2, R8 (SS)	; ACC0 <= ACC0 + (R2 * R8);					(IWL:5+1): Fractional Mode
		MAS.C	ACC2, R2, R8 (SS)	; ACC2 <= ACC2 - (R2 * R8);					(IWL:5+1): Fractional Mode
		ST.C	DM(I4+M5), ACC2.M	; y[ii*1+32] = *(I4+32) <= ACC2.M;			(IWL:6)
ll6:	ST.C	DM(I4+=M4), ACC0.M	; y[ii*1   ] = *I4 <= ACC0.M, I4 += 1;		(IWL:6)
; end: inner loop
;---------------------------------------------------------------------------
; Output: y (IWL = 6)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; * Simulator paramters:
;
; dspsim fft64_scalar.asm -if fft64_w.dat -of fft64_wout1.dat -oa 000 -os 1024 -c -q >! fft64_scalar.dspsim.txt
; binsim fft64_scalar.out -if fft64_w.dat -of fft64_wout2.dat -oa 000 -os 1024 -c -q >! fft64_scalar.binsim.txt
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; * Simulator version:
;
; dspsim: OFDM DSP Simulator 1.61
; All Rights Reserved.
; Last Built: Sep  4 2009 19:43:43
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; * Simulator output:
;
;----------------------------------
;** Simulator Statistics Summary **
;----------------------------------
;Time: 2887 cycles for 1 iteration
;Overflow: 0 times
;
; * Note: 2887 - 131(Coeff init.) - 8(ending NOPs) = 2748 cycles
;
