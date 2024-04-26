FUNCTION_BLOCK FB_TEST_0
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := 0);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("0,0: TestBlock.HexString = '0'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = '0') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := 1);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("1,0: TestBlock.HexString = '1'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = '1') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := 10);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("2,0: TestBlock.HexString = 'A'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = 'A') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := 15);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("3,0: TestBlock.HexString = 'F'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = 'F') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := 16);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("4,0: TestBlock.HexString = '10'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = '10') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := 255);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("5,0: TestBlock.HexString = 'FF'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = 'FF') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := 4095);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("6,0: TestBlock.HexString = 'FFF'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = 'FFF') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := 32767);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("7,0: TestBlock.HexString = '7FFF'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = '7FFF') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := 32768);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("8,0: TestBlock.HexString = '8000'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = '8000') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := 65535);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("9,0: TestBlock.HexString = 'FFFF'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = 'FFFF') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := -32768);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("10,0: TestBlock.HexString = '8000'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = '8000') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := -1);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("11,0: TestBlock.HexString = 'FFFFFFFF'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = 'FFFFFFFF') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := -16);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("12,0: TestBlock.HexString = 'FFFFFFF0'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = 'FFFFFFF0') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := -255);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("13,0: TestBlock.HexString = 'FFFFFF01'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = 'FFFFFF01') THEN Failed := TRUE; END_IF;
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
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := -4095);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("14,0: TestBlock.HexString = 'FFFFF001'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = 'FFFFF001') THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_15
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := -32767);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("15,0: TestBlock.HexString = 'FFFF8001'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = 'FFFF8001') THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_16
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := -32768);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("16,0: TestBlock.HexString = 'FFFF8000'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = 'FFFF8000') THEN Failed := TRUE; END_IF;
      END_IF;
      Finished:=TRUE;
  END_CASE;
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_TEST_17
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : DEC_TO_HEX;
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
    0:
      IF (Timer.Q) THEN
        TestBlock(DecimalValue := -65535);
        TestState:=TestState+1;
      END_IF;
      Timer(IN:=TRUE, PT:=T#0s);
    1:
      IF (Timer.Q) THEN
      {printf("17,0: TestBlock.HexString = 'FFFF0001'  actual=%lf\n", (double)__GET_VAR(data__->TESTBLOCK.HEXSTRING,));}
        IF NOT(TestBlock.HexString = 'FFFF0001') THEN Failed := TRUE; END_IF;
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
  testOutcomeArray : ARRAY [0..17] OF BOOL;
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
  Test_15: FB_TEST_15;
  Test_16: FB_TEST_16;
  Test_17: FB_TEST_17;
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
  IF NOT Test_15.Finished AND NOT Test_15.FAILED THEN totalTests := totalTests + 1; Test_15(); END_IF;
  IF Test_15.Finished THEN testOutcomeArray[15] := TRUE; END_IF;
  IF NOT Test_16.Finished AND NOT Test_16.FAILED THEN totalTests := totalTests + 1; Test_16(); END_IF;
  IF Test_16.Finished THEN testOutcomeArray[16] := TRUE; END_IF;
  IF NOT Test_17.Finished AND NOT Test_17.FAILED THEN totalTests := totalTests + 1; Test_17(); END_IF;
  IF Test_17.Finished THEN testOutcomeArray[17] := TRUE; END_IF;

  passedTests := 0;
  FOR i:=0 TO 17 DO
    IF testOutcomeArray[i]=TRUE THEN passedTests := passedTests+1; END_IF;
  END_FOR;
END_PROGRAM

