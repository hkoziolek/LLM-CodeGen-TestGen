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

FUNCTION_BLOCK MATRIX
  VAR_INPUT
    X1 : BOOL;
    X2 : BOOL;
    X3 : BOOL;
    X4 : BOOL;
    X5 : BOOL;
    RELEASE : BOOL;
  END_VAR
  VAR_OUTPUT
    CODE : BYTE;
    _TP : BOOL;
    Y1 : BOOL := TRUE;
    Y2 : BOOL;
    Y3 : BOOL;
    Y4 : BOOL;
  END_VAR
  VAR
    line : BYTE;
    x : ARRAY [0..3] OF BYTE;
    l : ARRAY [0..3] OF BYTE;
    i : INT;
    temp : BYTE;
    temp2 : BYTE;
    L_temp : BYTE;
    temp_bit : BOOL;
    in_temp : INT;
  END_VAR

  _TP := FALSE;
  code := BYTE#0;

  (* read scan lines *)
  in_temp := _BYTE_TO_INT(line);
  temp := X[in_temp];  (* X[LINE] umkopieren *)

  temp:=BIT_LOAD_B(temp,X1,0); (* X[line].0 := X1; *)
  temp:=BIT_LOAD_B(temp,X2,1); (* X[line].1 := X2; *)
  temp:=BIT_LOAD_B(temp,X3,2); (* X[line].2 := X3; *)
  temp:=BIT_LOAD_B(temp,X4,3); (* X[line].3 := X4; *)
  temp:=BIT_LOAD_B(temp,X5,4); (* X[line].4 := X5; *)

  X[in_temp] := temp; (* X[LINE] zurückkopieren *)

  (* compare for change *)
  FOR i := 0 TO 3 DO
  	IF X[i] <> L[i] THEN
  		(* scan line information has changed code need to be found and generated *)
  		temp   := x[i] XOR L[i];
          temp2  := X[i];
          L_temp := L[i];

          IF BIT_OF_DWORD(BYTE_TO_DWORD(temp),0) THEN (* temp.l *)
  			code := BYTE#1;
              temp_bit := BIT_OF_DWORD(BYTE_TO_DWORD(temp2),0);   (* X[i].l *)
              code := BIT_LOAD_B(code,temp_bit,7);     			(* code.X7 *)
              L_temp := BIT_LOAD_B(L_temp,temp_bit,0); 			(* L[i].l *)
  		ELSIF BIT_OF_DWORD(BYTE_TO_DWORD(temp),1) THEN          (* temp.X1 *)
  			code := BYTE#2;
              temp_bit := BIT_OF_DWORD(BYTE_TO_DWORD(temp2),1);   (* X[i].X1 *)
              code := BIT_LOAD_B(code,temp_bit,7);     			(* code.X7 *)
              L_temp := BIT_LOAD_B(L_temp,temp_bit,1); 			(* L[i].X1 *)
  		ELSIF BIT_OF_DWORD(BYTE_TO_DWORD(temp),2) THEN          (* temp.X2 *)
  			code := BYTE#3;
              temp_bit := BIT_OF_DWORD(BYTE_TO_DWORD(temp2),2);   (* X[i].X2 *)
              code := BIT_LOAD_B(code,temp_bit,7);     			(* code.X7 *)
              L_temp := BIT_LOAD_B(L_temp,temp_bit,2); 			(* L[i].X2 *)
  		ELSIF BIT_OF_DWORD(BYTE_TO_DWORD(temp),3) THEN          (* temp.X3 *)
  			code := BYTE#4;
              temp_bit := BIT_OF_DWORD(BYTE_TO_DWORD(temp2),3);   (* X[i].X3 *)
              code := BIT_LOAD_B(code,temp_bit,7);     			(* code.X7 *)
              L_temp := BIT_LOAD_B(L_temp,temp_bit,3); 			(* L[i].X3 *)
  		ELSIF BIT_OF_DWORD(BYTE_TO_DWORD(temp),4) THEN          (* temp.X4 *)
  			code := BYTE#5;
              temp_bit := BIT_OF_DWORD(BYTE_TO_DWORD(temp2),4);   (* X[i].X4 *)
              code := BIT_LOAD_B(code,temp_bit,7);     			(* code.X7 *)
              L_temp := BIT_LOAD_B(L_temp,temp_bit,4); 			(* L[i].X4 *)
  		END_IF;
          L[i] := L_temp;
  		_TP := TRUE;
          code := (code AND BYTE#2#1000_1111) OR SHL(LINE AND BYTE#2#0000_0111,4);
          (* obere zeile enspricht: Code.X4 := Line.l; /  Code.X5 := Line.X1; / Code.RELEASE := Line.X2; *)

  		(* check if release codes need to be killed *)
  		IF NOT release AND code < BYTE#127 THEN
  			code := BYTE#0;
  			_TP := FALSE;
  		END_IF;
          EXIT;
  	END_IF;
  END_FOR;

  (* increment scan line every cycle *)
  line := INT_TO_BYTE(_BYTE_TO_INT(line) + 1) AND BYTE#2#0000_0011;
  temp := SHL(BYTE#1,_BYTE_TO_INT(line));

  Y1 := BIT_OF_DWORD(BYTE_TO_DWORD(temp),0); (* temp.0 *)
  Y2 := BIT_OF_DWORD(BYTE_TO_DWORD(temp),1); (* temp.1 *)
  Y3 := BIT_OF_DWORD(BYTE_TO_DWORD(temp),2); (* temp.2 *)
  Y4 := BIT_OF_DWORD(BYTE_TO_DWORD(temp),3); (* temp.3 *)

  (* Fromm Oscat Library, www.oscat.de *)
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_0
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : MATRIX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X1 := TRUE, X2 := FALSE, X3 := TRUE, X4 := FALSE, X5 := TRUE, RELEASE := FALSE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("0,0: TestBlock.CODE = 1  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.CODE,));}
      {printf("0,0: TestBlock._TP = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK._TP,));}
      {printf("0,0: TestBlock.Y1 = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y1,));}
      {printf("0,0: TestBlock.Y2 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y2,));}
      {printf("0,0: TestBlock.Y3 = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y3,));}
      {printf("0,0: TestBlock.Y4 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y4,));}
        IF NOT(TestBlock.CODE = 1 AND TestBlock._TP = FALSE AND TestBlock.Y1 = TRUE AND TestBlock.Y2 = FALSE AND TestBlock.Y3 = TRUE AND TestBlock.Y4 = FALSE) THEN Failed := TRUE; END_IF;
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
    TestBlock : MATRIX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X1 := FALSE, X2 := TRUE, X3 := FALSE, X4 := TRUE, X5 := FALSE, RELEASE := TRUE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("1,0: TestBlock.CODE = 2  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.CODE,));}
      {printf("1,0: TestBlock._TP = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK._TP,));}
      {printf("1,0: TestBlock.Y1 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y1,));}
      {printf("1,0: TestBlock.Y2 = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y2,));}
      {printf("1,0: TestBlock.Y3 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y3,));}
      {printf("1,0: TestBlock.Y4 = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y4,));}
        IF NOT(TestBlock.CODE = 2 AND TestBlock._TP = TRUE AND TestBlock.Y1 = FALSE AND TestBlock.Y2 = TRUE AND TestBlock.Y3 = FALSE AND TestBlock.Y4 = TRUE) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_2
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : MATRIX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X1 := TRUE, X2 := TRUE, X3 := TRUE, X4 := TRUE, X5 := TRUE, RELEASE := FALSE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("2,0: TestBlock.CODE = 3  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.CODE,));}
      {printf("2,0: TestBlock._TP = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK._TP,));}
      {printf("2,0: TestBlock.Y1 = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y1,));}
      {printf("2,0: TestBlock.Y2 = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y2,));}
      {printf("2,0: TestBlock.Y3 = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y3,));}
      {printf("2,0: TestBlock.Y4 = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y4,));}
        IF NOT(TestBlock.CODE = 3 AND TestBlock._TP = FALSE AND TestBlock.Y1 = TRUE AND TestBlock.Y2 = TRUE AND TestBlock.Y3 = TRUE AND TestBlock.Y4 = TRUE) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_3
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : MATRIX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X1 := FALSE, X2 := FALSE, X3 := FALSE, X4 := FALSE, X5 := FALSE, RELEASE := TRUE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("3,0: TestBlock.CODE = 0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.CODE,));}
      {printf("3,0: TestBlock._TP = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK._TP,));}
      {printf("3,0: TestBlock.Y1 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y1,));}
      {printf("3,0: TestBlock.Y2 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y2,));}
      {printf("3,0: TestBlock.Y3 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y3,));}
      {printf("3,0: TestBlock.Y4 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y4,));}
        IF NOT(TestBlock.CODE = 0 AND TestBlock._TP = TRUE AND TestBlock.Y1 = FALSE AND TestBlock.Y2 = FALSE AND TestBlock.Y3 = FALSE AND TestBlock.Y4 = FALSE) THEN Failed := TRUE; END_IF;
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
  testOutcomeArray : ARRAY [0..3] OF BOOL;
  Test_0: FB_TEST_0;
  Test_1: FB_TEST_1;
  Test_2: FB_TEST_2;
  Test_3: FB_TEST_3;
END_VAR

  IF NOT Test_0.Finished AND NOT Test_0.FAILED THEN totalTests := totalTests + 1; Test_0(); END_IF;
  IF Test_0.Finished THEN testOutcomeArray[0] := TRUE; END_IF;
  IF NOT Test_1.Finished AND NOT Test_1.FAILED THEN totalTests := totalTests + 1; Test_1(); END_IF;
  IF Test_1.Finished THEN testOutcomeArray[1] := TRUE; END_IF;
  IF NOT Test_2.Finished AND NOT Test_2.FAILED THEN totalTests := totalTests + 1; Test_2(); END_IF;
  IF Test_2.Finished THEN testOutcomeArray[2] := TRUE; END_IF;
  IF NOT Test_3.Finished AND NOT Test_3.FAILED THEN totalTests := totalTests + 1; Test_3(); END_IF;
  IF Test_3.Finished THEN testOutcomeArray[3] := TRUE; END_IF;

  passedTests := 0;
  FOR i:=0 TO 3 DO
    IF testOutcomeArray[i]=TRUE THEN passedTests := passedTests+1; END_IF;
  END_FOR;
END_PROGRAM



CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#100ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : TestRunnerProgram;
  END_RESOURCE
END_CONFIGURATION


