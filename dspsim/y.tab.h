#ifndef YYERRCODE
#define YYERRCODE 256
#endif

#define LABEL 257
#define COMMENT 258
#define OFFSET 259
#define OPCODE 260
#define DEC_NUMBER 261
#define BIN_NUMBER 262
#define HEX_NUMBER 263
#define UMINUS 264
#define FRND 265
#define FSS 266
#define FSU 267
#define FUS 268
#define FUU 269
#define FC1 270
#define FC2 271
#define CIF 272
#define CEQC 273
#define CEQ 274
#define CNEC 275
#define CNE 276
#define CGT 277
#define CLE 278
#define CLT 279
#define CGE 280
#define CAVC 281
#define CNOT_AVC 282
#define CAV 283
#define CNOT_AV 284
#define CACC 285
#define CNOT_ACC 286
#define CAC 287
#define CNOT_AC 288
#define CSVC 289
#define CNOT_SVC 290
#define CSV 291
#define CNOT_SV 292
#define CMVC 293
#define CNOT_MVC 294
#define CMV 295
#define CNOT_MV 296
#define CNOT_CE 297
#define CTRUE 298
#define CUMC 299
#define CNOT_UMC 300
#define MCONJ 301
#define FHI 302
#define FLO 303
#define FHIRND 304
#define FLORND 305
#define FNORND 306
#define FHIX 307
#define RCNTR 308
#define RLPEVER 309
#define RCACTL 310
#define RLPSTACK 311
#define RPCSTACK 312
#define RASTATR 313
#define RASTATI 314
#define RASTATC 315
#define RMSTAT 316
#define RSSTAT 317
#define RPX 318
#define RICNTL 319
#define RIMASK 320
#define RIRPTL 321
#define RIVEC0 322
#define RIVEC1 323
#define RIVEC2 324
#define RIVEC3 325
#define RDSTAT0 326
#define RDSTAT1 327
#define RUMCOUNT 328
#define RID 329
#define RIX 330
#define RMX 331
#define RLX 332
#define RBX 333
#define RRX 334
#define RACC 335
#define MSEC_REG 336
#define MBIT_REV 337
#define MAV_LATCH 338
#define MAL_SAT 339
#define MM_MODE 340
#define MTIMER 341
#define MSEC_DAG 342
#define MM_BIAS 343
#define MINT 344
#define KNONE 345
#define KSEPARATOR 346
#define KPM 347
#define KDM 348
#define KUNTIL 349
#define KCE 350
#define KFOREVER 351
#define KPC 352
#define KLOOP 353
#define KSTS 354
#define KPOST 355
#define KPRE 356
typedef union {
    struct sTab *symp;	/* symbol table pointer */
	int	ival;			/* integer value */
	int subtok;			/* keyword */
	int	op;				/* opcode */
	char *tstr;			/* string */
} YYSTYPE;
extern YYSTYPE yylval;
