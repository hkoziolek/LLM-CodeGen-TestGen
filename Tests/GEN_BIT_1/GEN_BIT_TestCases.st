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

