FUNCTION_BLOCK FB_TEST_0
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := -0.5);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("0,0: TestBlock.OUT = -1000.0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = -1000.0) THEN Failed := TRUE; END_IF;
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
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := 0.0);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("1,0: TestBlock.OUT = 0.0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = 0.0) THEN Failed := TRUE; END_IF;
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
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := 0.5);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("2,0: TestBlock.OUT = 0.35173371124919584  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = 0.35173371124919584) THEN Failed := TRUE; END_IF;
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
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := 500.0);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("3,0: TestBlock.OUT = 5.249602852401596  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = 5.249602852401596) THEN Failed := TRUE; END_IF;
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
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := 501.0);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("4,0: TestBlock.OUT = 5.252322176165984  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = 5.252322176165984) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_5
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := 1000.0);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("5,0: TestBlock.OUT = 5.249999989522481  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = 5.249999989522481) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_6
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := -0.367879441171442);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("6,0: TestBlock.OUT = -1000.0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = -1000.0) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_7
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := -0.367879441171443);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("7,0: TestBlock.OUT = -1000.0  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = -1000.0) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_8
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := -0.367879441171441);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("8,0: TestBlock.OUT = -0.35173371124919584  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = -0.35173371124919584) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_9
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := 1.0);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("9,0: TestBlock.OUT = 0.5671432904097838  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = 0.5671432904097838) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_10
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := 2.0);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("10,0: TestBlock.OUT = 0.8526055020137255  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = 0.8526055020137255) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_11
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := -0.1);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("11,0: TestBlock.OUT = -0.11183255915839141  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = -0.11183255915839141) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_12
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := -0.01);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("12,0: TestBlock.OUT = -0.010050167084167949  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = -0.010050167084167949) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_13
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := -0.001);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("13,0: TestBlock.OUT = -0.0010005003335835344  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = -0.0010005003335835344) THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_14
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : LAMBERT_W;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(X := -0.0001);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("14,0: TestBlock.OUT = -0.00010000500033334732  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.OUT,));}
        IF NOT(TestBlock.OUT = -0.00010000500033334732) THEN Failed := TRUE; END_IF;
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
  testOutcomeArray : ARRAY [0..14] OF BOOL;
  Test_0: FB_TEST_0;
  Test_1: FB_TEST_1;
  Test_2: FB_TEST_2;
  Test_3: FB_TEST_3;
  Test_4: FB_TEST_4;
  Test_5: FB_TEST_5;
  Test_6: FB_TEST_6;
  Test_7: FB_TEST_7;
  Test_8: FB_TEST_8;
  Test_9: FB_TEST_9;
  Test_10: FB_TEST_10;
  Test_11: FB_TEST_11;
  Test_12: FB_TEST_12;
  Test_13: FB_TEST_13;
  Test_14: FB_TEST_14;
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
  IF NOT Test_5.Finished AND NOT Test_5.FAILED THEN totalTests := totalTests + 1; Test_5(); END_IF;
  IF Test_5.Finished THEN testOutcomeArray[5] := TRUE; END_IF;
  IF NOT Test_6.Finished AND NOT Test_6.FAILED THEN totalTests := totalTests + 1; Test_6(); END_IF;
  IF Test_6.Finished THEN testOutcomeArray[6] := TRUE; END_IF;
  IF NOT Test_7.Finished AND NOT Test_7.FAILED THEN totalTests := totalTests + 1; Test_7(); END_IF;
  IF Test_7.Finished THEN testOutcomeArray[7] := TRUE; END_IF;
  IF NOT Test_8.Finished AND NOT Test_8.FAILED THEN totalTests := totalTests + 1; Test_8(); END_IF;
  IF Test_8.Finished THEN testOutcomeArray[8] := TRUE; END_IF;
  IF NOT Test_9.Finished AND NOT Test_9.FAILED THEN totalTests := totalTests + 1; Test_9(); END_IF;
  IF Test_9.Finished THEN testOutcomeArray[9] := TRUE; END_IF;
  IF NOT Test_10.Finished AND NOT Test_10.FAILED THEN totalTests := totalTests + 1; Test_10(); END_IF;
  IF Test_10.Finished THEN testOutcomeArray[10] := TRUE; END_IF;
  IF NOT Test_11.Finished AND NOT Test_11.FAILED THEN totalTests := totalTests + 1; Test_11(); END_IF;
  IF Test_11.Finished THEN testOutcomeArray[11] := TRUE; END_IF;
  IF NOT Test_12.Finished AND NOT Test_12.FAILED THEN totalTests := totalTests + 1; Test_12(); END_IF;
  IF Test_12.Finished THEN testOutcomeArray[12] := TRUE; END_IF;
  IF NOT Test_13.Finished AND NOT Test_13.FAILED THEN totalTests := totalTests + 1; Test_13(); END_IF;
  IF Test_13.Finished THEN testOutcomeArray[13] := TRUE; END_IF;
  IF NOT Test_14.Finished AND NOT Test_14.FAILED THEN totalTests := totalTests + 1; Test_14(); END_IF;
  IF Test_14.Finished THEN testOutcomeArray[14] := TRUE; END_IF;

  passedTests := 0;
  FOR i:=0 TO 14 DO
    IF testOutcomeArray[i]=TRUE THEN passedTests := passedTests+1; END_IF;
  END_FOR;
END_PROGRAM

