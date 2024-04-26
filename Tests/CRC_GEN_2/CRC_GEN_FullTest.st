FUNCTION BIT_OF_DWORD : BOOL
  VAR_INPUT
    IN : DWORD;
    N : INT;
  END_VAR

  BIT_OF_DWORD := (SHR(in,N) AND 16#00000001) > 0;
  (* from OSCAT library; www.oscat.de  *)
END_FUNCTION

FUNCTION SIGN_R : BOOL
  VAR_INPUT
    IN : REAL;
  END_VAR

  SIGN_R := in < 0.0;
  (* from OSCAT library; www.oscat.de  *)
END_FUNCTION

FUNCTION FLOOR : INT
  VAR_INPUT
    x : REAL;
  END_VAR

  FLOOR := REAL_TO_INT(X);
  IF INT_TO_REAL(FLOOR) > X THEN
  	floor := floor - 1;
  END_IF;
  (* from OSCAT library; www.oscat.de  *)
END_FUNCTION

FUNCTION FLOOR2 : DINT
  VAR_INPUT
    x : REAL;
  END_VAR

  FLOOR2 := REAL_TO_DINT(X);
  IF DINT_TO_REAL(FLOOR2) > X THEN
  	FLOOR2 := FLOOR2 - DINT#1;
  END_IF;
  (* from OSCAT library; www.oscat.de  *)
END_FUNCTION

FUNCTION MODR : REAL
  VAR_INPUT
    IN : REAL;
    DIVI : REAL;
  END_VAR

  IF divi = 0.0 THEN
  	MODR := 0.0;
  ELSE
  	MODR := in - DINT_TO_REAL(FLOOR2(in / divi)) * divi;
  END_IF;
  (* from OSCAT library; www.oscat.de  *)
  (* FC FLOOR2 required *)
END_FUNCTION

FUNCTION REVERSE : BYTE
  VAR_INPUT
    IN : BYTE;
  END_VAR

  reverse := SHL(in,7) OR SHR(in,7) OR (ROR(in,3) AND BYTE#2#01000100) OR (ROL(in,3) AND BYTE#2#00100010)
  	OR (SHL(in,1) AND BYTE#2#00010000) OR (SHR(in,1) AND BYTE#2#00001000);


  (* Fromm Oscat Library, www.oscat.de *)
END_FUNCTION

FUNCTION REFLECT : DWORD
  VAR_INPUT
    DI : DWORD;
    L : INT;
  END_VAR
  VAR
    i : INT;
    _d : DWORD;
  END_VAR

  _d := DI;
  FOR i := 1 TO L DO
  	REFLECT := SHL(REFLECT, 1) OR BOOL_TO_DWORD((_d AND DWORD#2#0000_0001) > DWORD#0); (* D.0 *)
  	_d := SHR(_d, 1);
  END_FOR;
  REFLECT := REFLECT OR SHL(_d, L);


  (* Fromm Oscat Library, www.oscat.de *)
END_FUNCTION


FUNCTION BIT_LOAD_B : BYTE
  VAR_INPUT
    IN : BYTE;
    VAL : BOOL;
    POS : INT;
  END_VAR

  IF VAL THEN
  	BIT_LOAD_B := in OR SHL(BYTE#1,pos);
  ELSE
  	BIT_LOAD_B := in AND (NOT SHL(BYTE#1,pos));
  END_IF;

  (*From OSCAT Library, www.oscat.de*)
END_FUNCTION

FUNCTION _BYTE_TO_INT : INT
  VAR_INPUT
    IN : BYTE;
  END_VAR

  _BYTE_TO_INT := USINT_TO_INT(BYTE_TO_USINT(IN));

  (*From OSCAT Library, www.oscat.de*)
END_FUNCTION

FUNCTION T_PLC_MS : UDINT
  VAR
    tx : UDINT;
  END_VAR
  VAR_INPUT
    debug : BOOL;
  END_VAR
  VAR
    N : INT := 0;
    offset : UDINT := 0;
    temp : DWORD := 1;
  END_VAR

  tx := 0;
  {extern unsigned long __tick;
  extern unsigned long long common_ticktime__;
  unsigned long long ticktime_ms = (common_ticktime__)/1000000;
  UDINT plc_time = (UDINT)(ticktime_ms * (unsigned long long)__tick);
  TX = plc_time}
  T_PLC_MS := tx;
  IF debug THEN
  	T_PLC_MS := (DWORD_TO_UDINT(SHL(UDINT_TO_DWORD(T_PLC_MS),N) OR SHL(temp,N))-1) + OFFSET;
  END_IF;
  

  IF debug THEN
  	T_PLC_MS := (DWORD_TO_UDINT(SHL(UDINT_TO_DWORD(T_PLC_MS),N) OR SHL(temp,N))-1) + OFFSET;
  END_IF;

  (* Original Code:
  tx := TIME();
  T_PLC_MS := TIME_TO_DWORD(Tx);
  IF debug THEN
  	T_PLC_MS := (SHL(T_PLC_MS,N) OR SHL(DWORD#1,N)-1) + OFFSET;
  END_IF;
  *)

  (* From OSCAT library, www.oscat.de

  this is a temporary T_PLC_MS FB until OpenPLC gets it´s own time() functionality *)

  (* PLC_TIME and Global variables PLC_SCAN_CYCL and PLC_CYCL_TIME required *)
END_FUNCTION


FUNCTION T_PLC_US : UDINT
  VAR
    tx : UDINT;
  END_VAR
  VAR_INPUT
    debug : BOOL;
  END_VAR
  VAR
    N : INT := 0;
    offset : UDINT := 0;
    temp : DWORD := 1;
  END_VAR

  T_PLC_US := tx*1000;
  IF debug THEN
  	T_PLC_US := (DWORD_TO_UDINT(SHL(UDINT_TO_DWORD(T_PLC_US),N) OR SHL(temp,N))-1) + OFFSET;
  END_IF;

  (* Original Code:
  tx := TIME();
  T_PLC_US := TIME_TO_DWORD(Tx)*1000;
  IF debug THEN
  	T_PLC_US := (SHL(T_PLC_US,N) OR SHL(DWORD#1,N)-1) + OFFSET;
  END_IF;
  *)

  (* From OSCAT library, www.oscat.de

  this is a temporary T_PLC_US FB until OpenPLC gets it´s own time() functionality *)

  (* PLC_TIME and Global variables PLC_SCAN_CYCL and PLC_CYCL_TIME required *)
END_FUNCTION



FUNCTION_BLOCK FT_DERIV
  VAR_INPUT
    IN : REAL;
    K : REAL := 1.0;
    RUN : BOOL := TRUE;
  END_VAR
  VAR_OUTPUT
    OUT : REAL;
  END_VAR
  VAR
    old : REAL;
    tx : UDINT;
    last : UDINT;
    init : BOOL;
    tc : REAL;
  END_VAR

  tx:= T_PLC_US(en:=true);
  tc := UDINT_TO_REAL(tx - last);

  (* init on firsat startup *)
  IF NOT init THEN
  	init := TRUE;
  	old := in;
  ELSIF run AND tc > 0.0 THEN
  	out := (in - old) / tc * 1000000.0 * K;
  	old := in;
  ELSE
  	out := 0.0;
  END_IF;

  last := tx;

  (* From OSCAT Library, www.oscat.de *)
  (* T_PLC_US, required *)
END_FUNCTION_BLOCK


FUNCTION_BLOCK FT_PIWL
  VAR_INPUT
    IN : REAL;
    KP : REAL := 1.0;
    KI : REAL := 1.0;
    LIM_L : REAL := -1.0E38;
    LIM_H : REAL := 1.0E38;
    RST : BOOL;
  END_VAR
  VAR_OUTPUT
    Y : REAL;
    LIM : BOOL;
  END_VAR
  VAR
    init : BOOL;
    tx : UDINT;
    tc : REAL;
    t_last : UDINT;
    in_last : REAL;
    i : REAL;
    p : REAL;
  END_VAR

  IF NOT init OR RST THEN
  	init := TRUE;
  	in_last := in;
  		t_last := T_PLC_US(en:=true);
  	i := 0.0;
  	tc := 0.0;
  ELSE
  	(* read last cycle time in Microseconds *)
  		tx := T_PLC_US(en:=true);
  	tc := UDINT_TO_REAL(tx - t_last);
  	t_last := tx;

  	(* calculate proportional part *)
  	p := KP * IN;

  	(* run integrator *)
  	i := (IN + in_last) * 5.0E-7 * KI * tc + i;
  	in_last := IN;

  	(* calculate output Y *)
  	Y := p + i;

  	(* check output for limits *)
  	IF Y >= LIM_H THEN
  		Y := LIM_H;
  		IF ki <> 0.0 THEN
  			i := LIM_H - p;
  		ELSE
  			i := 0.0;
  		END_IF;
  		LIM := TRUE;
  	ELSIF Y <= LIM_L THEN
  		Y := LIM_L;
  		IF ki <> 0.0 THEN
  			i := LIM_L - p;
  		ELSE
  			i := 0.0;
  		END_IF;
  		LIM := TRUE;
  	ELSE
  		LIM := FALSE;
  	END_IF;
  END_IF;

  (* From OSCAT Library, www.oscat.de *)
  (* T_PLC_US required *)
END_FUNCTION_BLOCK


FUNCTION_BLOCK INTEGRATE
  VAR_INPUT
    _E : BOOL := TRUE;
    X : REAL;
    K : REAL := 1.0;
  END_VAR
  VAR_IN_OUT
    Y : REAL;
  END_VAR
  VAR
    x_last : REAL;
    init : BOOL;
    last : UDINT;
    tx : UDINT;
  END_VAR

  tx:= T_PLC_MS(en:=true);

  IF NOT init THEN
  	init := TRUE;
  	X_last := X;
  ELSIF _E THEN
  	Y := (X + X_LAST) * 0.5E-3 * UDINT_TO_REAL(tx-last) * K + Y;
  	X_last := X;
  END_IF;
  last := tx;

  (* From OSCAT Library, www.oscat.de *)
  (* T_PLC_MS required *)
END_FUNCTION_BLOCK

FUNCTION_BLOCK CRC_GEN
  VAR_IN_OUT
    PT : ARRAY [0..249] OF BYTE;
  END_VAR
  VAR_INPUT
    SIZE : UINT;
    PL : UINT;
    PN : DWORD;
    INIT : DWORD;
    REV_IN : BOOL;
    REV_OUT : BOOL;
    XOR_OUT : DWORD;
  END_VAR
  VAR_OUTPUT
    _CRC_GEN : DWORD;
  END_VAR
  VAR
    pos : INT;
    shift : INT;
    bits : INT;
    dx : BYTE;
  END_VAR

  shift := 32 - UINT_TO_INT(PL);
  PN := SHL(PN, shift);

  (* load first 4 bytes into register minimum message size is 4 bytes
  	for smaller messages fill with 0#s at the beginning*)
  FOR pos := 0 TO 3 DO
  	IF REV_IN THEN _CRC_GEN := SHL(_CRC_GEN, 8) OR BYTE_TO_DWORD(REVERSE(PT[pos])); ELSE _CRC_GEN := SHL(_CRC_GEN, 8) OR BYTE_TO_DWORD(PT[pos]); END_IF;
  END_FOR;
  pos := 4;

  (* xor with init value *)
  _CRC_GEN := _CRC_GEN XOR SHL(init, shift);

  (* calculate CRC for each byte *)
  WHILE pos < UINT_TO_INT(size) DO
  	IF REV_IN THEN DX := REVERSE(PT[pos]); ELSE DX := PT[pos]; END_IF;
  	pos := pos + 1;
  	(* crc calculation for one byte *)
  	FOR bits := 0 TO 7 DO
  		IF (_CRC_GEN AND DWORD#16#8000_0000) > DWORD#0 THEN (* CRC_GEN.31 *)
  			_CRC_GEN := (SHL(_CRC_GEN, 1) OR BOOL_TO_DWORD((DX AND BYTE#16#80) > BYTE#0)) XOR PN; (* DX.7 *)
  		ELSE
  			_CRC_GEN := SHL(_CRC_GEN, 1) OR BOOL_TO_DWORD((DX AND BYTE#16#80) > BYTE#0); (* DX.7 *)
  		END_IF;
  		dx := SHL(dx, 1);
  	END_FOR;
  END_WHILE;

  (* all bytes are processed, need to finish the registers 32 bits *)
  FOR bits := 0 TO 31 DO
  	IF (_CRC_GEN AND DWORD#16#8000_0000) > DWORD#0 THEN (* CRC_GEN.31 *)
  		_CRC_GEN := (SHL(_CRC_GEN, 1) OR BOOL_TO_DWORD((DX AND BYTE#16#80) > BYTE#0)) XOR PN; (* DX.7 *)
  	ELSE
  		_CRC_GEN := SHL(_CRC_GEN, 1) OR BOOL_TO_DWORD((DX AND BYTE#16#80) > BYTE#0); (* DX.7 *)
  	END_IF;
  END_FOR;

  (* final XOR *)
  _CRC_GEN := SHR(_CRC_GEN, shift) XOR XOR_OUT;

  (* reverse the crc_out put if necessary *)
  IF REV_OUT THEN _CRC_GEN := REFLECT(_CRC_GEN, UINT_TO_INT(PL)); END_IF;


  (* typical crc polynoms

  CRC-4-ITU 			x4 + x + 1 					(ITU G.704, p. 12) 	0x3 or 0xC (0x9)
  CRC-5-ITU 			x5 + x4 + x2 + 1 			(ITU G.704, p. 9) 	0x15 or 0x15 (0x0B) Bluetooth
  CRC-5-USB 			x5 + x2 + 1 				(use: USB token packets) 	0x05 or 0x14 (0x9)
  CRC-6-ITU 			x6 + x + 1 					(ITU G.704, p. 3) 	0x03 or 0x30 (0x21)
  CRC-7 				x7 + x3 + 1 				(use: telecom systems, MMC) 	0x09 or 0x48 (0x11)
  CRC-8-ATM 			x8 + x2 + x + 1 				(use: ATM HEC) 	0x07 or 0xE0 (0xC1)
  CRC-8-CCITT 		x8 + x7 + x3 + x2 + 1 		(use: 1-Wire bus) 	0x8D or 0xB1 (0x63)
  CRC-8-Dallas/Maxim 	x8 + x5 + x4 + 1 			(use: 1-Wire bus) 	0x31 or 0x8C (0x19)
  CRC-8 				x8 + x7 + x6 + x4 + x2 + 1 	0xD5 or 0xAB (0x57)
  CRC-8-SAE J1850 	x8 + x4 + x3 + x2 + 1 		0x1D or 0xB8
  CRC-10 				x10 + x9 + x5 + x4 + x + 1 	0x233 or 0x331 (0x263)
  CRC-12 				x12 + x11 + x3 + x2 + x + 1 (use: telecom systems) 	0x80F or 0xF01 (0xE03)
  CRC-15-CAN 			x15 + x14 + x10 + x8 + x7 + x4 + x3 + 1 	0x4599 or 0x4CD1 (0x19A3)
  CRC-16-Fletcher 	Not a CRC; see Fletchers checksum 	Used in Adler-32 A & B CRCs
  CRC-16-CCITT 	x16 + x12 + x5 + 1 (XMODEM,X.25, V.41, Bluetooth, PPP, IrDA; known as "CRC-CCITT") 	0x1021 or 0x8408 (0x0811)
  CRC-16-IBM 	x16 + x15 + x2 + 1 (USB, many others; also known as "CRC-16") 	0x8005 or 0xA001 (0x4003)
  CRC-24-Radix-64 	x24 + x23 + x18 + x17 + x14 + x11 + x10 + x7 + x6 + x5 + x4 + x3 + x + 1 	0x864CFB or 0xDF3261 (0xBE64C3)
  CRC-32-Adler 	Not a CRC; see Adler-32 	See Adler-32
  CRC-32-MPEG2 	x32 + x26 + x23 + x22 + x16 + x12 + x11 + x10 + x8 + x7 + x5 + x4 + x2 + x + 1 	0x04C11DB7 or 0xEDB88320 (0xDB710641) Also used in IEEE 802.3
  CRC-32-IEEE 802.3 	x32 + x26 + x23 + x22 + x16 + x12 + x11 + x10 + x8 + x7 + x5 + x4 + x2 + x + 1 (V.42) 	0x04C11DB7 or 0xEDB88320 (0xDB710641)
  CRC-32C (Castagnoli) 	x32 + x28 + x27 + x26 + x25 + x23 + x22 + x20 + x19 + x18 + x14 + x13 + x11 + x10 + x9 + x8 + x6 + 1 	0x1EDC6F41 or 0x82F63B78 (0x05EC76F1)
  CRC-64-ISO 	x64 + x4 + x3 + x + 1 (use: ISO 3309) 	0x000000000000001B or 0xD800000000000000 (0xB000000000000001)
  CRC-64-ECMA-182 	x64 + x62 + x57 + x55 + x54 + x53 + x52 + x47 + x46 + x45 + x40 + x39 + x38 + x37 + x35 + x33 + x32 + x31 + x29 + x27 + x24 + x23 + x22 + x21 + x19 + x17 + x13 + x12 + x10 + x9 + x7 + x4 + x + 1
  (as described in ECMA-182 p.63) 	0x42F0E1EBA9EA3693 or 0xC96C5795D7870F42 (0x92D8AF2BAF0E1E85)
  *)
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_0
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : CRC_GEN;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(SIZE := 10, PL := 3, PN := 2, INIT := 1, REV_IN := FALSE, REV_OUT := TRUE, XOR_OUT := 5);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("0,0: TestBlock._CRC_GEN = 7  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK._CRC_GEN,));}
        IF NOT (TestBlock._CRC_GEN = 7) THEN Failed := TRUE; END_IF;
        TestBlock(SIZE := 11, PL := 4, PN := 3, INIT := 2, REV_IN := TRUE, REV_OUT := FALSE, XOR_OUT := 6);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    2:
      IF (Timer.Q) THEN
      {printf("0,1: TestBlock._CRC_GEN = 8  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK._CRC_GEN,));}
        IF NOT(TestBlock._CRC_GEN = 8) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_1
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : CRC_GEN;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(SIZE := 10, PL := 5, PN := 4, INIT := 3, REV_IN := FALSE, REV_OUT := TRUE, XOR_OUT := 7);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("1,0: TestBlock._CRC_GEN = 9  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK._CRC_GEN,));}
        IF NOT (TestBlock._CRC_GEN = 9) THEN Failed := TRUE; END_IF;
        TestBlock(SIZE := 10, PL := 6, PN := 5, INIT := 4, REV_IN := TRUE, REV_OUT := FALSE, XOR_OUT := 8);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    2:
      IF (Timer.Q) THEN
      {printf("1,1: TestBlock._CRC_GEN = 10  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK._CRC_GEN,));}
        IF NOT(TestBlock._CRC_GEN = 10) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK


PROGRAM TestRunnerProgram
VAR
  testResult AT %QX0.0 : BOOL := FALSE;
END_VAR
VAR
  totalTests AT %QW0 : INT := 0;
  passedTests AT %QW1 : INT := 0;
END_VAR
VAR
  i: INT := 0;
  testOutcomeArray : ARRAY [0..1] OF BOOL;
  Test_0: FB_TEST_0;
  Test_1: FB_TEST_1;
END_VAR

  IF NOT Test_0.Finished AND NOT Test_0.FAILED THEN totalTests := totalTests + 1; Test_0(); END_IF;
  IF Test_0.Finished THEN testOutcomeArray[0] := TRUE; END_IF;
  IF NOT Test_1.Finished AND NOT Test_1.FAILED THEN totalTests := totalTests + 1; Test_1(); END_IF;
  IF Test_1.Finished THEN testOutcomeArray[1] := TRUE; END_IF;

  passedTests := 0;
  FOR i:=0 TO 1 DO
    IF testOutcomeArray[i]=TRUE THEN passedTests := passedTests+1; END_IF;
  END_FOR;
END_PROGRAM



CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#100ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : TestRunnerProgram;
  END_RESOURCE
END_CONFIGURATION


