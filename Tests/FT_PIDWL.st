FUNCTION_BLOCK FT_PIDWL
  VAR_INPUT
    IN : REAL;
    KP : REAL := 1.0;
    TN : REAL := 1.0;
    TV : REAL := 1.0;
    LIM_L : REAL := -1.0E38;
    LIM_H : REAL := 1.0E38;
    RST : BOOL;
  END_VAR
  VAR_OUTPUT
    Y : REAL;
    LIM : BOOL;
  END_VAR
  VAR
    piwl : FT_PIWL;
    diff : FT_DERIV;
  END_VAR

  IF rst THEN
  	piwl(rst := TRUE);
  	piwl.RST := FALSE;
  ELSE
  	(* run PIWL controller first *)
  	(* we need to check if TN = 0 and do alternative calls *)
  	IF TN = 0.0 THEN
  		piwl(in := IN * KP, KP := 1.0, KI := 0.0, LIM_L := LIM_L, LIM_H := LIM_H);
  	ELSE
  		piwl(in := IN * KP, KP := 1.0, KI := 1.0 / TN, LIM_L := LIM_L, LIM_H := LIM_H);
  	END_IF;

  	(* run differentiator and add_to_output *)
  	diff(IN := IN, K := KP * TV);
  	Y := piwl.Y + diff.out;

  	(* limit the output *)
  	IF Y < LIM_L THEN
  		LIM := TRUE;
  		Y := LIM_L;
  	ELSIF Y > LIM_H THEN
  		LIM := TRUE;
  		Y := LIM_H;
  	ELSE
  		LIM := FALSE;
  	END_IF;
  END_IF;

  (* From OSCAT Library, www.oscat.de *)
  (* T_PLC_US, FT_DERIV required *)
END_FUNCTION_BLOCK




