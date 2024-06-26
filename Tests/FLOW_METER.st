FUNCTION_BLOCK FLOW_METER
  VAR_INPUT
    VX : REAL;
    _E : BOOL;
    RST : BOOL;
    PULSE_MODE : BOOL;
    UPDATE_TIME : TIME := t#1s;
  END_VAR
  VAR_OUTPUT
    F : REAL;
  END_VAR
  VAR_IN_OUT
    X : REAL;
    Y : UDINT;
  END_VAR
  VAR
    tx : TIME;
    tl : TIME;
    int1 : INTEGRATE;
    init : BOOL;
    e_last : BOOL;
    tmp : INT;
    x_last : REAL;
    y_last : UDINT;
  END_VAR

  IF NOT init THEN	(* init on power up *)
  	init := TRUE;
  	tl := tx;
  	x_last := X;
  	y_last := Y;
  	int1.K := 2.7777777777777777E-4;
  END_IF;

  (* run integrator *)
  int1(_E := NOT (RST OR PULSE_MODE) AND _E, X := VX, Y := X);	(* gated operation *)
  X := int1.Y;

  IF RST THEN		(* reset *)
  	X := 0.0;
  	Y := UDINT#0;
  	tl := tx;
  	x_last := 0.0;
  	y_last := UDINT#0;
  ELSIF _E AND PULSE_MODE THEN	(* check for pulse mode *)
  	IF NOT e_last THEN X := X + VX; END_IF;
  END_IF;
  e_last := _E;

  (* reduce X to be less than 1 and increase Y respectively *)
  IF X > 1.0 THEN
  	tmp := FLOOR(X);
  	Y := Y + INT_TO_UDINT(tmp);
  	X := X - INT_TO_REAL(tmp);
  END_IF;

  (* calculate the current flow *)
  tx := UDINT_TO_TIME(T_PLC_MS(en:=true));
  IF tx - tl >= UPDATE_TIME AND UPDATE_TIME > t#0s THEN
  	F := (UDINT_TO_REAL(Y - y_last) + X - x_last) / TIME_TO_REAL(tx - tl) * 3.6E6;
  	y_last := Y;
  	x_last := X;
  	tl := tx;
  END_IF;

  (* From OSCAT Library, www.oscat.de *)
  (* T_PLC_MS, FLOOR, INTEGRATE required *)
END_FUNCTION_BLOCK