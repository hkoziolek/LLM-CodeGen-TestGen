FUNCTION_BLOCK SEQUENCE_8
  VAR_INPUT
    IN0 : BOOL := TRUE;
    IN1 : BOOL := TRUE;
    IN2 : BOOL := TRUE;
    IN3 : BOOL := TRUE;
    IN4 : BOOL := TRUE;
    IN5 : BOOL := TRUE;
    IN6 : BOOL := TRUE;
    IN7 : BOOL := TRUE;
    START : BOOL;
    RST : BOOL;
    WAIT0 : TIME;
    DELAY0 : TIME;
    WAIT1 : TIME;
    DELAY1 : TIME;
    WAIT2 : TIME;
    DELAY2 : TIME;
    WAIT3 : TIME;
    DELAY3 : TIME;
    WAIT4 : TIME;
    DELAY4 : TIME;
    WAIT5 : TIME;
    DELAY5 : TIME;
    WAIT6 : TIME;
    DELAY6 : TIME;
    WAIT7 : TIME;
    DELAY7 : TIME;
    STOP_ON_ERROR : BOOL;
  END_VAR
  VAR_OUTPUT
    Q0 : BOOL;
    Q1 : BOOL;
    Q2 : BOOL;
    Q3 : BOOL;
    Q4 : BOOL;
    Q5 : BOOL;
    Q6 : BOOL;
    Q7 : BOOL;
    QX : BOOL;
    RUN : BOOL;
    _STEP : INT := -1;
    STATUS : BYTE;
  END_VAR
  VAR
    last : TIME;
    edge : BOOL;
    tx : TIME;
    init : BOOL;
  END_VAR

  tx:= UDINT_TO_TIME(T_PLC_MS(en:=true));

  (* initialize on startup *)
  IF NOT init THEN
  	last := tx;
  	init := TRUE;
  	status := BYTE#110;
  END_IF;

  (* asynchronous reset *)
  IF rst THEN
  	_step := -1;
  	Q0 := FALSE;
  	Q1 := FALSE;
  	Q2 := FALSE;
  	Q3 := FALSE;
  	Q4 := FALSE;
  	Q5 := FALSE;
  	Q6 := FALSE;
  	Q7 := FALSE;
  	status := BYTE#110;
  	run := FALSE;

  (* edge on start input restarts the sequencer *)
  ELSIF start AND NOT edge THEN
  	_step := 0;
  	last := tx;
  	status := BYTE#111;
  	Q0 := FALSE;
  	Q1 := FALSE;
  	Q2 := FALSE;
  	Q3 := FALSE;
  	Q4 := FALSE;
  	Q5 := FALSE;
  	Q6 := FALSE;
  	Q7 := FALSE;
  	run := TRUE;
  END_IF;
  edge := start;

  (* check if stop on error is necessary *)
  IF status > BYTE#0 AND status < BYTE#100 AND stop_on_error THEN RETURN; END_IF;

  (* sequence is running *)
  IF run AND _step = 0 THEN
  	IF NOT q0 AND in0 AND tx - last <= wait0 THEN
  		Q0 := TRUE;
  		last := tx;
  	ELSIF NOT q0 AND tx - last > wait0 THEN
  		status := BYTE#1;
  		run := FALSE;
  	ELSIF q0 AND tx - last >= delay0 THEN
  		_step := 1;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 1 THEN
  	IF NOT q1 AND in1 AND tx - last <= wait1 THEN
  		Q0 := FALSE;
  		Q1 := TRUE;
  		last := tx;
  	ELSIF NOT q1 AND Tx - last > wait1 THEN
  		status := BYTE#2;
  		q0 := FALSE;
  		run := FALSE;
  	ELSIF q1 AND tx - last >= delay1 THEN
  		_step := 2;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 2 THEN
  	IF NOT q2 AND in2 AND tx - last <= wait2 THEN
  		Q1 := FALSE;
  		Q2 := TRUE;
  		last := tx;
  	ELSIF NOT q2 AND Tx - last > wait2 THEN
  		status := BYTE#3;
  		q1 := FALSE;
  		run := FALSE;
  	ELSIF q2 AND tx - last >= delay2 THEN
  		_step := 3;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 3 THEN
  	IF NOT q3 AND in3 AND tx - last <= wait3 THEN
  		Q2 := FALSE;
  		Q3 := TRUE;
  		last := tx;
  	ELSIF NOT q3 AND Tx - last > wait3 THEN
  		status := BYTE#4;
  		q2 := FALSE;
  		run := FALSE;
  	ELSIF q3 AND tx - last >= delay3 THEN
  		_step := 4;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 4 THEN
  	IF NOT q4 AND in4 AND tx - last <= wait4 THEN
  		Q3 := FALSE;
  		Q4 := TRUE;
  		last := tx;
  	ELSIF NOT q4 AND Tx - last > wait4 THEN
  		status := BYTE#5;
  		q3 := FALSE;
  		run := FALSE;
  	ELSIF q4 AND tx - last >= WAIT4 THEN
  		_step := 5;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 5 THEN
  	IF NOT q5 AND in5 AND tx - last <= DELAY4 THEN
  		Q4 := FALSE;
  		Q5 := TRUE;
  		last := tx;
  	ELSIF NOT q5 AND Tx - last > DELAY4 THEN
  		status := BYTE#6;
  		q4 := FALSE;
  		run := FALSE;
  	ELSIF q5 AND tx - last >= WAIT5 THEN
  		_step := 6;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 6 THEN
  	IF NOT q6 AND in6 AND tx - last <= DELAY5 THEN
  		Q5 := FALSE;
  		Q6 := TRUE;
  		last := tx;
  	ELSIF NOT q6 AND Tx - last > DELAY5 THEN
  		status := BYTE#7;
  		q5 := FALSE;
  		run := FALSE;
  	ELSIF q6 AND tx - last >= WAIT6 THEN
  		_step := 7;
  		last := tx;
  	END_IF;
  END_IF;
  IF run AND _step = 7 THEN
  	IF NOT q7 AND in7 AND tx - last <= DELAY6 THEN
  		Q6 := FALSE;
  		Q7 := TRUE;
  		last := tx;
  	ELSIF NOT q7 AND Tx - last > DELAY6 THEN
  		status := BYTE#8;
  		q6 := FALSE;
  		run := FALSE;
  	ELSIF q7 AND tx - last >= WAIT7 THEN
  		_step := -1;
  		Q7 := FALSE;
  		Run := FALSE;
  		status := BYTE#110;
  	END_IF;
  END_IF;
  QX := q0 OR q1 OR q2 OR q3 OR q4 OR q5 OR q6 OR q7;

  (*From OSCAT Library, www.oscat.de *)
END_FUNCTION_BLOCK