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
        TestBlock(IN0 := TRUE, IN1 := TRUE, IN2 := TRUE, IN3 := TRUE, IN4 := TRUE, IN5 := TRUE, IN6 := TRUE, IN7 := TRUE, START := TRUE, RST := FALSE, WAIT0 := T#5s, DELAY0 := T#1s, WAIT1 := T#5s, DELAY1 := T#1s, WAIT2 := T#5s, DELAY2 := T#1s, WAIT3 := T#5s, DELAY3 := T#1s, WAIT4 := T#5s, DELAY4 := T#1s, WAIT5 := T#5s, DELAY5 := T#1s, WAIT6 := T#5s, DELAY6 := T#1s, WAIT7 := T#5s, DELAY7 := T#1s, STOP_ON_ERROR := FALSE);
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
        TestBlock(IN0 := TRUE, IN1 := TRUE, IN2 := TRUE, IN3 := TRUE, IN4 := TRUE, IN5 := TRUE, IN6 := TRUE, IN7 := TRUE, START := FALSE, RST := TRUE, WAIT0 := T#5s, DELAY0 := T#1s, WAIT1 := T#5s, DELAY1 := T#1s, WAIT2 := T#5s, DELAY2 := T#1s, WAIT3 := T#5s, DELAY3 := T#1s, WAIT4 := T#5s, DELAY4 := T#1s, WAIT5 := T#5s, DELAY5 := T#1s, WAIT6 := T#5s, DELAY6 := T#1s, WAIT7 := T#5s, DELAY7 := T#1s, STOP_ON_ERROR := FALSE);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("1,0: TestBlock.Q0 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q0,));}
      {printf("1,0: TestBlock.Q1 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q1,));}
      {printf("1,0: TestBlock.Q2 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q2,));}
      {printf("1,0: TestBlock.Q3 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q3,));}
      {printf("1,0: TestBlock.Q4 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q4,));}
      {printf("1,0: TestBlock.Q5 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q5,));}
      {printf("1,0: TestBlock.Q6 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q6,));}
      {printf("1,0: TestBlock.Q7 = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.Q7,));}
      {printf("1,0: TestBlock.QX = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.QX,));}
      {printf("1,0: TestBlock.RUN = FALSE  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.RUN,));}
      {printf("1,0: TestBlock._STEP = -1  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK._STEP,));}
      {printf("1,0: TestBlock.STATUS = 110  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.STATUS,));}
        IF NOT(TestBlock.Q0 = FALSE AND TestBlock.Q1 = FALSE AND TestBlock.Q2 = FALSE AND TestBlock.Q3 = FALSE AND TestBlock.Q4 = FALSE AND TestBlock.Q5 = FALSE AND TestBlock.Q6 = FALSE AND TestBlock.Q7 = FALSE AND TestBlock.QX = FALSE AND TestBlock.RUN = FALSE AND TestBlock._STEP = -1 AND TestBlock.STATUS = 110) THEN Failed := TRUE; END_IF;
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

