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

FUNCTION_BLOCK SEQUENCE_8
  VAR_INPUT
    IN0 : BOOL := TRUE;
    IN1 : BOOL := TRUE;
    IN2 : BOOL := TRUE;
    IN3 : BOOL := TRUE;
    IN4 : BOOL := TRUE;
    IN5 : BOOL := TRUE;
    IN6 : BOOL := TRUE;
    IN7 : BOOL := TRUE;
    START : BOOL;
    RST : BOOL;
    WAIT0 : TIME;
    DELAY0 : TIME;
    WAIT1 : TIME;
    DELAY1 : TIME;
    WAIT2 : TIME;
    DELAY2 : TIME;
    WAIT3 : TIME;
    DELAY3 : TIME;
    WAIT4 : TIME;
    DELAY4 : TIME;
    WAIT5 : TIME;
    DELAY5 : TIME;
    WAIT6 : TIME;
    DELAY6 : TIME;
    WAIT7 : TIME;
    DELAY7 : TIME;
    STOP_ON_ERROR : BOOL;
  END_VAR
  VAR_OUTPUT
    Q0 : BOOL;
    Q1 : BOOL;
    Q2 : BOOL;
    Q3 : BOOL;
    Q4 : BOOL;
    Q5 : BOOL;
    Q6 : BOOL;
    Q7 : BOOL;
    QX : BOOL;
    RUN : BOOL;
    _STEP : INT := -1;
    STATUS : BYTE;
  END_VAR
  VAR
    last : TIME;
    edge : BOOL;
    tx : TIME;
    init : BOOL;
  END_VAR

  tx:= UDINT_TO_TIME(T_PLC_MS(en:=true));

  (* initialize on startup *)
  IF NOT init THEN
  	last := tx;
  	init := TRUE;
  	status := BYTE#110;
  END_IF;

  (* asynchronous reset *)
  IF rst THEN
  	_step := -1;
  	Q0 := FALSE;
  	Q1 := FALSE;
  	Q2 := FALSE;
  	Q3 := FALSE;
  	Q4 := FALSE;
  	Q5 := FALSE;
  	Q6 := FALSE;
  	Q7 := FALSE;
  	status := BYTE#110;
  	run := FALSE;

  (* edge on start input restarts the sequencer *)
  ELSIF start AND NOT edge THEN
  	_step := 0;
  	last := tx;
  	status := BYTE#111;
  	Q0 := FALSE;
  	Q1 := FALSE;
  	Q2 := FALSE;
  	Q3 := FALSE;
  	Q4 := FALSE;
  	Q5 := FALSE;
  	Q6 := FALSE;
  	Q7 := FALSE;
  	run := TRUE;
  END_IF;
  edge := start;

  (* check if stop on error is necessary *)
  IF status > BYTE#0 AND status < BYTE#100 AND stop_on_error THEN RETURN; END_IF;

  (* sequence is running *)
  IF run AND _step = 0 THEN
  	IF NOT q0 AND in0 AND tx - last <= wait0 THEN
  		Q0 := TRUE;
  		last := tx;
  	ELSIF NOT q0 AND tx - last > wait0 THEN
  		status := BYTE#1;
  		run := FALSE;
  	ELSIF q0 AND tx - last >= delay0 THEN
  		_step := 1;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 1 THEN
  	IF NOT q1 AND in1 AND tx - last <= wait1 THEN
  		Q0 := FALSE;
  		Q1 := TRUE;
  		last := tx;
  	ELSIF NOT q1 AND Tx - last > wait1 THEN
  		status := BYTE#2;
  		q0 := FALSE;
  		run := FALSE;
  	ELSIF q1 AND tx - last >= delay1 THEN
  		_step := 2;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 2 THEN
  	IF NOT q2 AND in2 AND tx - last <= wait2 THEN
  		Q1 := FALSE;
  		Q2 := TRUE;
  		last := tx;
  	ELSIF NOT q2 AND Tx - last > wait2 THEN
  		status := BYTE#3;
  		q1 := FALSE;
  		run := FALSE;
  	ELSIF q2 AND tx - last >= delay2 THEN
  		_step := 3;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 3 THEN
  	IF NOT q3 AND in3 AND tx - last <= wait3 THEN
  		Q2 := FALSE;
  		Q3 := TRUE;
  		last := tx;
  	ELSIF NOT q3 AND Tx - last > wait3 THEN
  		status := BYTE#4;
  		q2 := FALSE;
  		run := FALSE;
  	ELSIF q3 AND tx - last >= delay3 THEN
  		_step := 4;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 4 THEN
  	IF NOT q4 AND in4 AND tx - last <= wait4 THEN
  		Q3 := FALSE;
  		Q4 := TRUE;
  		last := tx;
  	ELSIF NOT q4 AND Tx - last > wait4 THEN
  		status := BYTE#5;
  		q3 := FALSE;
  		run := FALSE;
  	ELSIF q4 AND tx - last >= WAIT4 THEN
  		_step := 5;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 5 THEN
  	IF NOT q5 AND in5 AND tx - last <= DELAY4 THEN
  		Q4 := FALSE;
  		Q5 := TRUE;
  		last := tx;
  	ELSIF NOT q5 AND Tx - last > DELAY4 THEN
  		status := BYTE#6;
  		q4 := FALSE;
  		run := FALSE;
  	ELSIF q5 AND tx - last >= WAIT5 THEN
  		_step := 6;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 6 THEN
  	IF NOT q6 AND in6 AND tx - last <= DELAY5 THEN
  		Q5 := FALSE;
  		Q6 := TRUE;
  		last := tx;
  	ELSIF NOT q6 AND Tx - last > DELAY5 THEN
  		status := BYTE#7;
  		q5 := FALSE;
  		run := FALSE;
  	ELSIF q6 AND tx - last >= WAIT6 THEN
  		_step := 7;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 7 THEN
  	IF NOT q7 AND in7 AND tx - last <= DELAY6 THEN
  		Q6 := FALSE;
  		Q7 := TRUE;
  		last := tx;
  	ELSIF NOT q7 AND Tx - last > DELAY6 THEN
  		status := BYTE#8;
  		q6 := FALSE;
  		run := FALSE;
  	ELSIF q7 AND tx - last >= WAIT7 THEN
  		_step := -1;
  		Q7 := FALSE;
  		Run := FALSE;
  		status := BYTE#110;
  	END_IF;
  END_IF;
  QX := q0 OR q1 OR q2 OR q3 OR q4 OR q5 OR q6 OR q7;

  (*From OSCAT Library, www.oscat.de *)
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_0
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : SEQUENCE_8;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(IN0 := TRUE, IN1 := TRUE, IN2 := TRUE, IN3 := TRUE, IN4 := TRUE, IN5 := TRUE, IN6 := TRUE, IN7 := TRUE, START := FALSE, RST := TRUE, STOP_ON_ERROR := TRUE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("0,0: TestBlock.Q0 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q0,));}
      {printf("0,0: TestBlock.Q1 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q1,));}
      {printf("0,0: TestBlock.Q2 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q2,));}
      {printf("0,0: TestBlock.Q3 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q3,));}
      {printf("0,0: TestBlock.Q4 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q4,));}
      {printf("0,0: TestBlock.Q5 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q5,));}
      {printf("0,0: TestBlock.Q6 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q6,));}
      {printf("0,0: TestBlock.Q7 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q7,));}
      {printf("0,0: TestBlock.QX = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.QX,));}
      {printf("0,0: TestBlock.RUN = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.RUN,));}
      {printf("0,0: TestBlock._STEP = -1  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK._STEP,));}
      {printf("0,0: TestBlock.STATUS = 110  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.STATUS,));}
        IF NOT(TestBlock.Q0 = FALSE AND TestBlock.Q1 = FALSE AND TestBlock.Q2 = FALSE AND TestBlock.Q3 = FALSE AND TestBlock.Q4 = FALSE AND TestBlock.Q5 = FALSE AND TestBlock.Q6 = FALSE AND TestBlock.Q7 = FALSE AND TestBlock.QX = FALSE AND TestBlock.RUN = FALSE AND TestBlock._STEP = -1 AND TestBlock.STATUS = 110) THEN Failed := TRUE; END_IF;
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
    TestBlock : SEQUENCE_8;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(IN0 := TRUE, IN1 := TRUE, IN2 := TRUE, IN3 := TRUE, IN4 := TRUE, IN5 := TRUE, IN6 := TRUE, IN7 := TRUE, START := TRUE, RST := FALSE, STOP_ON_ERROR := FALSE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("1,0: TestBlock.Q0 = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q0,));}
      {printf("1,0: TestBlock.Q1 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q1,));}
      {printf("1,0: TestBlock.Q2 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q2,));}
      {printf("1,0: TestBlock.Q3 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q3,));}
      {printf("1,0: TestBlock.Q4 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q4,));}
      {printf("1,0: TestBlock.Q5 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q5,));}
      {printf("1,0: TestBlock.Q6 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q6,));}
      {printf("1,0: TestBlock.Q7 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q7,));}
      {printf("1,0: TestBlock.QX = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.QX,));}
      {printf("1,0: TestBlock.RUN = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.RUN,));}
      {printf("1,0: TestBlock._STEP = 0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK._STEP,));}
      {printf("1,0: TestBlock.STATUS = 111  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.STATUS,));}
        IF NOT(TestBlock.Q0 = TRUE AND TestBlock.Q1 = FALSE AND TestBlock.Q2 = FALSE AND TestBlock.Q3 = FALSE AND TestBlock.Q4 = FALSE AND TestBlock.Q5 = FALSE AND TestBlock.Q6 = FALSE AND TestBlock.Q7 = FALSE AND TestBlock.QX = TRUE AND TestBlock.RUN = TRUE AND TestBlock._STEP = 0 AND TestBlock.STATUS = 111) THEN Failed := TRUE; END_IF;
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


