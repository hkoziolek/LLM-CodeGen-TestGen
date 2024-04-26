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
        TestBlock(PT := t#500ms, AM := 2.0, OS := 1.0, DL := 0.5);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("0,0: TestBlock.Q = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q,));}
      {printf("0,0: TestBlock.OUT = 1.7071067811865475  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.Q = FALSE AND TestBlock.OUT = 1.7071067811865475) THEN Failed := TRUE; END_IF;
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
        TestBlock(PT := t#1000ms, AM := 1.0, OS := 0.0, DL := 0.0);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("1,0: TestBlock.Q = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q,));}
      {printf("1,0: TestBlock.OUT = 0.0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.Q = TRUE AND TestBlock.OUT = 0.0) THEN Failed := TRUE; END_IF;
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
        TestBlock(PT := t#2000ms, AM := 3.0, OS := 0.5, DL := 0.25);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("2,0: TestBlock.Q = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q,));}
      {printf("2,0: TestBlock.OUT = 2.0606601717798214  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.Q = FALSE AND TestBlock.OUT = 2.0606601717798214) THEN Failed := TRUE; END_IF;
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
    TestBlock : GEN_SIN;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(PT := t#1500ms, AM := 0.5, OS := 0.25, DL := 0.75);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("3,0: TestBlock.Q = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q,));}
      {printf("3,0: TestBlock.OUT = 0.5  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.Q = TRUE AND TestBlock.OUT = 0.5) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_4
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
        TestBlock(PT := t#500ms, AM := 2.5, OS := 1.5, DL := 1.0);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("4,0: TestBlock.Q = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q,));}
      {printf("4,0: TestBlock.OUT = 2.8531695488854605  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.Q = FALSE AND TestBlock.OUT = 2.8531695488854605) THEN Failed := TRUE; END_IF;
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
  testOutcomeArray : ARRAY [0..4] OF BOOL;
  Test_0: FB_TEST_0;
  Test_1: FB_TEST_1;
  Test_2: FB_TEST_2;
  Test_3: FB_TEST_3;
  Test_4: FB_TEST_4;
END_VAR

  IF NOT Test_0.Finished AND NOT Test_0.FAILED THEN totalTests := totalTests + 1; Test_0(); END_IF;
  IF Test_0.Finished THEN testOutcomeArray[0] := TRUE; END_IF;
  IF NOT Test_1.Finished AND NOT Test_1.FAILED THEN totalTests := totalTests + 1; Test_1(); END_IF;
  IF Test_1.Finished THEN testOutcomeArray[1] := TRUE; END_IF;
  IF NOT Test_2.Finished AND NOT Test_2.FAILED THEN totalTests := totalTests + 1; Test_2(); END_IF;
  IF Test_2.Finished THEN testOutcomeArray[2] := TRUE; END_IF;
  IF NOT Test_3.Finished AND NOT Test_3.FAILED THEN totalTests := totalTests + 1; Test_3(); END_IF;
  IF Test_3.Finished THEN testOutcomeArray[3] := TRUE; END_IF;
  IF NOT Test_4.Finished AND NOT Test_4.FAILED THEN totalTests := totalTests + 1; Test_4(); END_IF;
  IF Test_4.Finished THEN testOutcomeArray[4] := TRUE; END_IF;

  passedTests := 0;
  FOR i:=0 TO 4 DO
    IF testOutcomeArray[i]=TRUE THEN passedTests := passedTests+1; END_IF;
  END_FOR;
END_PROGRAM

