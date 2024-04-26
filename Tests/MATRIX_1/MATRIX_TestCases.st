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

