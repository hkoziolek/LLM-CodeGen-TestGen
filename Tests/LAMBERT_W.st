FUNCTION_BLOCK LAMBERT_W
  VAR_INPUT
    X : REAL;
  END_VAR
  VAR_OUTPUT
    OUT : REAL;
  END_VAR
  VAR
    w : REAL;
    i : INT;
    we : REAL;
    w1e : REAL;
    ewx : REAL;
    last : DWORD;
  END_VAR

  IF x < -0.367879441171442 THEN
  	OUT := -1000.0;
  	RETURN;
  (* return 0 if x = 0 *)
  ELSIF x = 0.0 THEN
  	RETURN;
  (* first an estimate is calculated *)
  ELSIF x <= 500.0 THEN
  	w := LN(x + 1.0);
  	w := 0.665 * (1.0 + 0.0195 * w) * w + 0.04;
  ELSE
  	w := LN(x - 4.0) - (1.0 - 1.0/LN(x)) * LN(LN(x));
  END_IF;
  (* use estimate to calculate exact result *)
  FOR i := 0 TO 5 DO
  	ewx := EXP(w);
  	we := w * ewx - x;
  	w1e := (w+1.0) * ewx;
  	last := REAL_TO_DWORD(w) AND DWORD#16#FFFF_FFFC;
  	w := w - (we / (w1e - (w+2.0) * we / (2.0 * w + 2.0)));
  	IF (REAL_TO_DWORD(w) AND DWORD#16#FFFF_FFFC) = last THEN EXIT; END_IF;
  END_FOR;
  OUT := w;
  (* from OSCAT library; www.oscat.de  *)
END_FUNCTION_BLOCK