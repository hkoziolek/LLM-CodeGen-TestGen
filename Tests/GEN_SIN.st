FUNCTION_BLOCK GEN_SIN
  VAR_INPUT
    PT : TIME;
    AM : REAL := 1.0;
    OS : REAL;
    DL : REAL;
  END_VAR
  VAR_OUTPUT
    Q : BOOL;
    OUT : REAL;
  END_VAR
  VAR
    tx : TIME;
    last : TIME;
    init : BOOL;
    temp : REAL;
  END_VAR

  tx:= UDINT_TO_TIME(T_PLC_MS(en:=true)) - last;

  DL := modR(dl,1.0);
  IF dl < 0.0 THEN dl := 1.0 - dl; END_IF;

  (* init section *)
  IF NOT init THEN
  	init := TRUE;
  	last := tx;
  	tx := t#0s;
  END_IF;

  (* add last if one cycle is finished *)
  IF tx >= pt THEN
  	last := last + pt;
  	tx := tx - pt;
  END_IF;

  (* generate sine wave *)
  IF pt > t#0s THEN temp := SIN(6.283185307179586476 * TIME_TO_REAL(tx + multime(pt, dl)) / TIME_TO_REAL(pt)); END_IF;
  out := am * 0.5 *  temp + os;

  (* boolean output Q *)
  q := NOT sign_R(temp);

  (* From OSCAT Library, www.oscat.de *)
  (* T_PLC_MS, SIGN_R required*)
END_FUNCTION_BLOCK
