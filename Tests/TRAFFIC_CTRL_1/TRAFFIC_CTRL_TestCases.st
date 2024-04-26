FUNCTION_BLOCK FB_TEST_0
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : TRAFFIC_CTRL;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(PedestrianButton1 := FALSE, PedestrianButton2 := FALSE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("0,0: TestBlock.NorthSouthRed = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.NORTHSOUTHRED,));}
      {printf("0,0: TestBlock.NorthSouthYellow = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.NORTHSOUTHYELLOW,));}
      {printf("0,0: TestBlock.NorthSouthGreen = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.NORTHSOUTHGREEN,));}
      {printf("0,0: TestBlock.EastWestRed = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.EASTWESTRED,));}
      {printf("0,0: TestBlock.EastWestYellow = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.EASTWESTYELLOW,));}
      {printf("0,0: TestBlock.EastWestGreen = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.EASTWESTGREEN,));}
      {printf("0,0: TestBlock.PedestrianLight1 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.PEDESTRIANLIGHT1,));}
      {printf("0,0: TestBlock.PedestrianLight2 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.PEDESTRIANLIGHT2,));}
        IF NOT(TestBlock.NorthSouthRed = FALSE AND TestBlock.NorthSouthYellow = FALSE AND TestBlock.NorthSouthGreen = TRUE AND TestBlock.EastWestRed = TRUE AND TestBlock.EastWestYellow = FALSE AND TestBlock.EastWestGreen = FALSE AND TestBlock.PedestrianLight1 = FALSE AND TestBlock.PedestrianLight2 = FALSE) THEN Failed := TRUE; END_IF;
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
    TestBlock : TRAFFIC_CTRL;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(PedestrianButton1 := TRUE, PedestrianButton2 := FALSE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("1,0: TestBlock.NorthSouthRed = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.NORTHSOUTHRED,));}
      {printf("1,0: TestBlock.NorthSouthYellow = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.NORTHSOUTHYELLOW,));}
      {printf("1,0: TestBlock.NorthSouthGreen = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.NORTHSOUTHGREEN,));}
      {printf("1,0: TestBlock.EastWestRed = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.EASTWESTRED,));}
      {printf("1,0: TestBlock.EastWestYellow = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.EASTWESTYELLOW,));}
      {printf("1,0: TestBlock.EastWestGreen = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.EASTWESTGREEN,));}
      {printf("1,0: TestBlock.PedestrianLight1 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.PEDESTRIANLIGHT1,));}
      {printf("1,0: TestBlock.PedestrianLight2 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.PEDESTRIANLIGHT2,));}
        IF NOT(TestBlock.NorthSouthRed = FALSE AND TestBlock.NorthSouthYellow = TRUE AND TestBlock.NorthSouthGreen = FALSE AND TestBlock.EastWestRed = TRUE AND TestBlock.EastWestYellow = FALSE AND TestBlock.EastWestGreen = FALSE AND TestBlock.PedestrianLight1 = FALSE AND TestBlock.PedestrianLight2 = FALSE) THEN Failed := TRUE; END_IF;
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
    TestBlock : TRAFFIC_CTRL;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(PedestrianButton1 := FALSE, PedestrianButton2 := TRUE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("2,0: TestBlock.NorthSouthRed = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.NORTHSOUTHRED,));}
      {printf("2,0: TestBlock.NorthSouthYellow = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.NORTHSOUTHYELLOW,));}
      {printf("2,0: TestBlock.NorthSouthGreen = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.NORTHSOUTHGREEN,));}
      {printf("2,0: TestBlock.EastWestRed = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.EASTWESTRED,));}
      {printf("2,0: TestBlock.EastWestYellow = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.EASTWESTYELLOW,));}
      {printf("2,0: TestBlock.EastWestGreen = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.EASTWESTGREEN,));}
      {printf("2,0: TestBlock.PedestrianLight1 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.PEDESTRIANLIGHT1,));}
      {printf("2,0: TestBlock.PedestrianLight2 = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.PEDESTRIANLIGHT2,));}
        IF NOT(TestBlock.NorthSouthRed = TRUE AND TestBlock.NorthSouthYellow = FALSE AND TestBlock.NorthSouthGreen = FALSE AND TestBlock.EastWestRed = TRUE AND TestBlock.EastWestYellow = FALSE AND TestBlock.EastWestGreen = TRUE AND TestBlock.PedestrianLight1 = FALSE AND TestBlock.PedestrianLight2 = TRUE) THEN Failed := TRUE; END_IF;
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
    TestBlock : TRAFFIC_CTRL;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(PedestrianButton1 := TRUE, PedestrianButton2 := TRUE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("3,0: TestBlock.NorthSouthRed = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.NORTHSOUTHRED,));}
      {printf("3,0: TestBlock.NorthSouthYellow = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.NORTHSOUTHYELLOW,));}
      {printf("3,0: TestBlock.NorthSouthGreen = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.NORTHSOUTHGREEN,));}
      {printf("3,0: TestBlock.EastWestRed = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.EASTWESTRED,));}
      {printf("3,0: TestBlock.EastWestYellow = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.EASTWESTYELLOW,));}
      {printf("3,0: TestBlock.EastWestGreen = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.EASTWESTGREEN,));}
      {printf("3,0: TestBlock.PedestrianLight1 = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.PEDESTRIANLIGHT1,));}
      {printf("3,0: TestBlock.PedestrianLight2 = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.PEDESTRIANLIGHT2,));}
        IF NOT(TestBlock.NorthSouthRed = TRUE AND TestBlock.NorthSouthYellow = FALSE AND TestBlock.NorthSouthGreen = FALSE AND TestBlock.EastWestRed = TRUE AND TestBlock.EastWestYellow = TRUE AND TestBlock.EastWestGreen = FALSE AND TestBlock.PedestrianLight1 = TRUE AND TestBlock.PedestrianLight2 = TRUE) THEN Failed := TRUE; END_IF;
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

