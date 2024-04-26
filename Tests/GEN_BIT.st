FUNCTION_BLOCK GEN_BIT
  VAR_INPUT
    IN0 : DWORD;
    IN1 : DWORD;
    IN2 : DWORD;
    IN3 : DWORD;
    CLK : BOOL;
    STEPS : INT;
    REP : INT;
    RST : BOOL;
  END_VAR
  VAR_OUTPUT
    Q0 : BOOL;
    Q1 : BOOL;
    Q2 : BOOL;
    Q3 : BOOL;
    CNT : INT;
    RUN : BOOL;
  END_VAR
  VAR
    r0 : DWORD;
    r1 : DWORD;
    r2 : DWORD;
    r3 : DWORD;
    rx : INT := 1;
  END_VAR

  (* check if number of runs is finished or rep = 0 which means continuous *)

  IF clk AND NOT rst THEN
  	run := (rep = 0) OR (rx <= rep);
  	IF run THEN
  		(* check for step counter reached and reset to 0 if cnt = steps *)
  		IF cnt = steps THEN
  			cnt := 0;
  		END_IF;

  		(* when cnt = 0 then reload the inputs into the registers *)
  		IF cnt = 0 THEN
  			r0 := in0;
  			r1 := in1;
  			r2 := in2;
  			r3 := in3;
  		END_IF;

  		(* when cnt < steps, shift the lowest bits to the outputs *)
  		IF (cnt < steps) THEN
              Q0 := BIT_OF_DWORD(r0,0); (* Q0 := r0.X0; *)
              Q1 := BIT_OF_DWORD(r1,0); (* Q1 := r1.X0; *)
              Q2 := BIT_OF_DWORD(r2,0); (* Q2 := r2.X0; *)
              Q3 := BIT_OF_DWORD(r3,0); (* Q3 := r3.X0; *)
  			r0 := SHR(r0,1);
  			r1 := SHR(r1,1);
  			r2 := SHR(r2,1);
  			r3 := SHR(r3,1);
  		END_IF;

  		(* increment the step counter *)
  		cnt := cnt +1;
  		IF (cnt = steps) AND (rep <> 0) THEN rx := rx +1; END_IF;
  		IF (rx > rep) AND (rep <> 0) THEN run := FALSE; END_IF;
  	END_IF;
  ELSE
  	IF rst THEN
  		run := FALSE;
  		Q0 := FALSE;
  		Q1 := FALSE;
  		Q2 := FALSE;
  		Q3 := FALSE;
  		r0 := DWORD#0;
  		r1 := DWORD#0;
  		r2 := DWORD#0;
  		r3 := DWORD#0;
  		cnt := 0;
  		rx := 1;
  	END_IF;
  END_IF;

  (*From OSCAT Library, www.oscat.de *)
END_FUNCTION_BLOCK