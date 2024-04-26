FUNCTION_BLOCK FB_TEST_0
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : TOOL_CHANGER;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(ToolChangeRequired := TRUE, ToolCarouselPosition := 1, DesiredToolNumber := 2);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("0,0: TestBlock.RotateCarousel = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.ROTATECAROUSEL,));}
      {printf("0,0: TestBlock.LockTool = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.LOCKTOOL,));}
        IF NOT(TestBlock.RotateCarousel = TRUE AND TestBlock.LockTool = FALSE) THEN Failed := TRUE; END_IF;
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
    TestBlock : TOOL_CHANGER;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(ToolChangeRequired := TRUE, ToolCarouselPosition := 2, DesiredToolNumber := 2);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("1,0: TestBlock.RotateCarousel = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.ROTATECAROUSEL,));}
      {printf("1,0: TestBlock.LockTool = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.LOCKTOOL,));}
        IF NOT(TestBlock.RotateCarousel = FALSE AND TestBlock.LockTool = TRUE) THEN Failed := TRUE; END_IF;
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
    TestBlock : TOOL_CHANGER;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(ToolChangeRequired := TRUE, ToolCarouselPosition := 2, DesiredToolNumber := 1);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("2,0: TestBlock.RotateCarousel = TRUE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.ROTATECAROUSEL,));}
      {printf("2,0: TestBlock.LockTool = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.LOCKTOOL,));}
        IF NOT(TestBlock.RotateCarousel = TRUE AND TestBlock.LockTool = FALSE) THEN Failed := TRUE; END_IF;
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
    TestBlock : TOOL_CHANGER;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(ToolChangeRequired := FALSE, ToolCarouselPosition := 1, DesiredToolNumber := 1);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("3,0: TestBlock.RotateCarousel = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.ROTATECAROUSEL,));}
      {printf("3,0: TestBlock.LockTool = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.LOCKTOOL,));}
        IF NOT(TestBlock.RotateCarousel = FALSE AND TestBlock.LockTool = FALSE) THEN Failed := TRUE; END_IF;
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
    TestBlock : TOOL_CHANGER;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(ToolChangeRequired := FALSE, ToolCarouselPosition := 1, DesiredToolNumber := 2);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("4,0: TestBlock.RotateCarousel = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.ROTATECAROUSEL,));}
      {printf("4,0: TestBlock.LockTool = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.LOCKTOOL,));}
        IF NOT(TestBlock.RotateCarousel = FALSE AND TestBlock.LockTool = FALSE) THEN Failed := TRUE; END_IF;
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

