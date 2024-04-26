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

