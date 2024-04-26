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

FUNCTION_BLOCK GEN_BIT
  VAR_INPUT
    IN0 : DWORD;
    IN1 : DWORD;
    IN2 : DWORD;
    IN3 : DWORD;
    CLK : BOOL;
    STEPS : INT;
    REP : INT;
    RST : BOOL;
  END_VAR
  VAR_OUTPUT
    Q0 : BOOL;
    Q1 : BOOL;
    Q2 : BOOL;
    Q3 : BOOL;
    CNT : INT;
    RUN : BOOL;
  END_VAR
  VAR
    r0 : DWORD;
    r1 : DWORD;
    r2 : DWORD;
    r3 : DWORD;
    rx : INT := 1;
  END_VAR

  (* check if number of runs is finished or rep = 0 which means continuous *)

  IF clk AND NOT rst THEN
  	run := (rep = 0) OR (rx <= rep);
  	IF run THEN
  		(* check for step counter reached and reset to 0 if cnt = steps *)
  		IF cnt = steps THEN
  			cnt := 0;
  		END_IF;

  		(* when cnt = 0 then reload the inputs into the registers *)
  		IF cnt = 0 THEN
  			r0 := in0;
  			r1 := in1;
  			r2 := in2;
  			r3 := in3;
  		END_IF;

  		(* when cnt < steps, shift the lowest bits to the outputs *)
  		IF (cnt < steps) THEN
              Q0 := BIT_OF_DWORD(r0,0); (* Q0 := r0.X0; *)
              Q1 := BIT_OF_DWORD(r1,0); (* Q1 := r1.X0; *)
              Q2 := BIT_OF_DWORD(r2,0); (* Q2 := r2.X0; *)
              Q3 := BIT_OF_DWORD(r3,0); (* Q3 := r3.X0; *)
  			r0 := SHR(r0,1);
  			r1 := SHR(r1,1);
  			r2 := SHR(r2,1);
  			r3 := SHR(r3,1);
  		END_IF;

  		(* increment the step counter *)
  		cnt := cnt +1;
  		IF (cnt = steps) AND (rep <> 0) THEN rx := rx +1; END_IF;
  		IF (rx > rep) AND (rep <> 0) THEN run := FALSE; END_IF;
  	END_IF;
  ELSE
  	IF rst THEN
  		run := FALSE;
  		Q0 := FALSE;
  		Q1 := FALSE;
  		Q2 := FALSE;
  		Q3 := FALSE;
  		r0 := DWORD#0;
  		r1 := DWORD#0;
  		r2 := DWORD#0;
  		r3 := DWORD#0;
  		cnt := 0;
  		rx := 1;
  	END_IF;
  END_IF;

  (*From OSCAT Library, www.oscat.de *)
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_0
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : GEN_BIT;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(IN0 := 3, IN1 := 2, IN2 := 1, IN3 := 4, CLK := TRUE, STEPS := 1, REP := 2, RST := FALSE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("0,0: TestBlock.Q0 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q0,));}
      {printf("0,0: TestBlock.Q1 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q1,));}
      {printf("0,0: TestBlock.Q2 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q2,));}
      {printf("0,0: TestBlock.Q3 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q3,));}
      {printf("0,0: TestBlock.CNT = 0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.CNT,));}
      {printf("0,0: TestBlock.RUN = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.RUN,));}
        IF NOT(TestBlock.Q0 = FALSE AND TestBlock.Q1 = FALSE AND TestBlock.Q2 = FALSE AND TestBlock.Q3 = FALSE AND TestBlock.CNT = 0 AND TestBlock.RUN = TRUE) THEN Failed := TRUE; END_IF;
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
    TestBlock : GEN_BIT;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(IN0 := 5, IN1 := 6, IN2 := 7, IN3 := 8, CLK := FALSE, STEPS := 0, REP := 1, RST := TRUE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("1,0: TestBlock.Q0 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q0,));}
      {printf("1,0: TestBlock.Q1 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q1,));}
      {printf("1,0: TestBlock.Q2 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q2,));}
      {printf("1,0: TestBlock.Q3 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q3,));}
      {printf("1,0: TestBlock.CNT = 0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.CNT,));}
      {printf("1,0: TestBlock.RUN = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.RUN,));}
        IF NOT(TestBlock.Q0 = FALSE AND TestBlock.Q1 = FALSE AND TestBlock.Q2 = FALSE AND TestBlock.Q3 = FALSE AND TestBlock.CNT = 0 AND TestBlock.RUN = FALSE) THEN Failed := TRUE; END_IF;
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
    TestBlock : GEN_BIT;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(IN0 := 10, IN1 := 9, IN2 := 8, IN3 := 7, CLK := TRUE, STEPS := 2, REP := 0, RST := FALSE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("2,0: TestBlock.Q0 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q0,));}
      {printf("2,0: TestBlock.Q1 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q1,));}
      {printf("2,0: TestBlock.Q2 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q2,));}
      {printf("2,0: TestBlock.Q3 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q3,));}
      {printf("2,0: TestBlock.CNT = 0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.CNT,));}
      {printf("2,0: TestBlock.RUN = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.RUN,));}
        IF NOT(TestBlock.Q0 = FALSE AND TestBlock.Q1 = FALSE AND TestBlock.Q2 = FALSE AND TestBlock.Q3 = FALSE AND TestBlock.CNT = 0 AND TestBlock.RUN = TRUE) THEN Failed := TRUE; END_IF;
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
  testOutcomeArray : ARRAY [0..2] OF BOOL;
  Test_0: FB_TEST_0;
  Test_1: FB_TEST_1;
  Test_2: FB_TEST_2;
END_VAR

  IF NOT Test_0.Finished AND NOT Test_0.FAILED THEN totalTests := totalTests + 1; Test_0(); END_IF;
  IF Test_0.Finished THEN testOutcomeArray[0] := TRUE; END_IF;
  IF NOT Test_1.Finished AND NOT Test_1.FAILED THEN totalTests := totalTests + 1; Test_1(); END_IF;
  IF Test_1.Finished THEN testOutcomeArray[1] := TRUE; END_IF;
  IF NOT Test_2.Finished AND NOT Test_2.FAILED THEN totalTests := totalTests + 1; Test_2(); END_IF;
  IF Test_2.Finished THEN testOutcomeArray[2] := TRUE; END_IF;

  passedTests := 0;
  FOR i:=0 TO 2 DO
    IF testOutcomeArray[i]=TRUE THEN passedTests := passedTests+1; END_IF;
  END_FOR;
END_PROGRAM



CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#100ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : TestRunnerProgram;
  END_RESOURCE
END_CONFIGURATION


