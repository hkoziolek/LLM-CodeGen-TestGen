FUNCTION_BLOCK FB_TEST_0
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : FT_PIDWL;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(IN := 0.0, KP := 1.0, TN := 1.0, TV := 1.0, LIM_L := -1.0E38, LIM_H := 1.0E38, RST := TRUE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("0,0: TestBlock.Y = 0.0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y,));}
      {printf("0,0: TestBlock.LIM = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.LIM,));}
        IF NOT (TestBlock.Y = 0.0 AND TestBlock.LIM = FALSE) THEN Failed := TRUE; END_IF;
        TestBlock(IN := 1.0, KP := 1.0, TN := 0.0, TV := 1.0, LIM_L := -1.0E38, LIM_H := 1.0E38, RST := FALSE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    2:
      IF (Timer.Q) THEN
      {printf("0,1: TestBlock.Y = 1.0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y,));}
      {printf("0,1: TestBlock.LIM = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.LIM,));}
        IF NOT (TestBlock.Y = 1.0 AND TestBlock.LIM = FALSE) THEN Failed := TRUE; END_IF;
        TestBlock(IN := 1.0, KP := 2.0, TN := 1.0, TV := 1.0, LIM_L := -1.0E38, LIM_H := 1.0E38, RST := FALSE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    3:
      IF (Timer.Q) THEN
      {printf("0,2: TestBlock.Y = 2.0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y,));}
      {printf("0,2: TestBlock.LIM = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.LIM,));}
        IF NOT(TestBlock.Y = 2.0 AND TestBlock.LIM = FALSE) THEN Failed := TRUE; END_IF;
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
    TestBlock : FT_PIDWL;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(IN := 0.0, KP := 1.0, TN := 1.0, TV := 2.0, LIM_L := -1.0E38, LIM_H := 1.0E38, RST := TRUE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("1,0: TestBlock.Y = 0.0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y,));}
      {printf("1,0: TestBlock.LIM = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.LIM,));}
        IF NOT (TestBlock.Y = 0.0 AND TestBlock.LIM = FALSE) THEN Failed := TRUE; END_IF;
        TestBlock(IN := 1.0, KP := 1.0, TN := 1.0, TV := 2.0, LIM_L := -1.0E38, LIM_H := 1.0E38, RST := FALSE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    2:
      IF (Timer.Q) THEN
      {printf("1,1: TestBlock.Y = 1.0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Y,));}
      {printf("1,1: TestBlock.LIM = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.LIM,));}
        IF NOT(TestBlock.Y = 1.0 AND TestBlock.LIM = FALSE) THEN Failed := TRUE; END_IF;
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

