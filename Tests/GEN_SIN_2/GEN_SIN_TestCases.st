FUNCTION_BLOCK FB_TEST_0
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : GEN_SIN;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(PT := t#5000ms, AM := 2.0, OS := 0.5, DL := 0.1);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("0,0: TestBlock.Q = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q,));}
      {printf("0,0: TestBlock.OUT = 1.5  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT (TestBlock.Q = TRUE AND TestBlock.OUT = 1.5) THEN Failed := TRUE; END_IF;
        TestBlock(PT := t#5000ms, AM := 2.0, OS := 0.5, DL := 0.3);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    2:
      IF (Timer.Q) THEN
      {printf("0,1: TestBlock.Q = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q,));}
      {printf("0,1: TestBlock.OUT = 0.9  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.Q = FALSE AND TestBlock.OUT = 0.9) THEN Failed := TRUE; END_IF;
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
    TestBlock : GEN_SIN;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(PT := t#10000ms, AM := 1.0, OS := 1.0, DL := 0.5);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("1,0: TestBlock.Q = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q,));}
      {printf("1,0: TestBlock.OUT = 1.5  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT (TestBlock.Q = TRUE AND TestBlock.OUT = 1.5) THEN Failed := TRUE; END_IF;
        TestBlock(PT := t#10000ms, AM := 1.0, OS := 1.0, DL := 0.7);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    2:
      IF (Timer.Q) THEN
      {printf("1,1: TestBlock.Q = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q,));}
      {printf("1,1: TestBlock.OUT = 0.7  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.Q = FALSE AND TestBlock.OUT = 0.7) THEN Failed := TRUE; END_IF;
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
    TestBlock : GEN_SIN;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(PT := t#0ms, AM := 0.0, OS := 0.0, DL := 0.0);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("2,0: TestBlock.Q = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q,));}
      {printf("2,0: TestBlock.OUT = 0.0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT (TestBlock.Q = TRUE AND TestBlock.OUT = 0.0) THEN Failed := TRUE; END_IF;
        TestBlock(PT := t#0ms, AM := 0.0, OS := 0.0, DL := 1.0);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    2:
      IF (Timer.Q) THEN
      {printf("2,1: TestBlock.Q = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q,));}
      {printf("2,1: TestBlock.OUT = 0.0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.Q = FALSE AND TestBlock.OUT = 0.0) THEN Failed := TRUE; END_IF;
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

