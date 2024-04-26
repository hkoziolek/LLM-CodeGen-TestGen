FUNCTION_BLOCK MATRIX
  VAR_INPUT
    X1 : BOOL;
    X2 : BOOL;
    X3 : BOOL;
    X4 : BOOL;
    X5 : BOOL;
    RELEASE : BOOL;
  END_VAR
  VAR_OUTPUT
    CODE : BYTE;
    _TP : BOOL;
    Y1 : BOOL := TRUE;
    Y2 : BOOL;
    Y3 : BOOL;
    Y4 : BOOL;
  END_VAR
  VAR
    line : BYTE;
    x : ARRAY [0..3] OF BYTE;
    l : ARRAY [0..3] OF BYTE;
    i : INT;
    temp : BYTE;
    temp2 : BYTE;
    L_temp : BYTE;
    temp_bit : BOOL;
    in_temp : INT;
  END_VAR

  _TP := FALSE;
  code := BYTE#0;

  (* read scan lines *)
  in_temp := _BYTE_TO_INT(line);
  temp := X[in_temp];  (* X[LINE] umkopieren *)

  temp:=BIT_LOAD_B(temp,X1,0); (* X[line].0 := X1; *)
  temp:=BIT_LOAD_B(temp,X2,1); (* X[line].1 := X2; *)
  temp:=BIT_LOAD_B(temp,X3,2); (* X[line].2 := X3; *)
  temp:=BIT_LOAD_B(temp,X4,3); (* X[line].3 := X4; *)
  temp:=BIT_LOAD_B(temp,X5,4); (* X[line].4 := X5; *)

  X[in_temp] := temp; (* X[LINE] zurückkopieren *)

  (* compare for change *)
  FOR i := 0 TO 3 DO
  	IF X[i] <> L[i] THEN
  		(* scan line information has changed code need to be found and generated *)
  		temp   := x[i] XOR L[i];
          temp2  := X[i];
          L_temp := L[i];

          IF BIT_OF_DWORD(BYTE_TO_DWORD(temp),0) THEN (* temp.l *)
  			code := BYTE#1;
              temp_bit := BIT_OF_DWORD(BYTE_TO_DWORD(temp2),0);   (* X[i].l *)
              code := BIT_LOAD_B(code,temp_bit,7);     			(* code.X7 *)
              L_temp := BIT_LOAD_B(L_temp,temp_bit,0); 			(* L[i].l *)
  		ELSIF BIT_OF_DWORD(BYTE_TO_DWORD(temp),1) THEN          (* temp.X1 *)
  			code := BYTE#2;
              temp_bit := BIT_OF_DWORD(BYTE_TO_DWORD(temp2),1);   (* X[i].X1 *)
              code := BIT_LOAD_B(code,temp_bit,7);     			(* code.X7 *)
              L_temp := BIT_LOAD_B(L_temp,temp_bit,1); 			(* L[i].X1 *)
  		ELSIF BIT_OF_DWORD(BYTE_TO_DWORD(temp),2) THEN          (* temp.X2 *)
  			code := BYTE#3;
              temp_bit := BIT_OF_DWORD(BYTE_TO_DWORD(temp2),2);   (* X[i].X2 *)
              code := BIT_LOAD_B(code,temp_bit,7);     			(* code.X7 *)
              L_temp := BIT_LOAD_B(L_temp,temp_bit,2); 			(* L[i].X2 *)
  		ELSIF BIT_OF_DWORD(BYTE_TO_DWORD(temp),3) THEN          (* temp.X3 *)
  			code := BYTE#4;
              temp_bit := BIT_OF_DWORD(BYTE_TO_DWORD(temp2),3);   (* X[i].X3 *)
              code := BIT_LOAD_B(code,temp_bit,7);     			(* code.X7 *)
              L_temp := BIT_LOAD_B(L_temp,temp_bit,3); 			(* L[i].X3 *)
  		ELSIF BIT_OF_DWORD(BYTE_TO_DWORD(temp),4) THEN          (* temp.X4 *)
  			code := BYTE#5;
              temp_bit := BIT_OF_DWORD(BYTE_TO_DWORD(temp2),4);   (* X[i].X4 *)
              code := BIT_LOAD_B(code,temp_bit,7);     			(* code.X7 *)
              L_temp := BIT_LOAD_B(L_temp,temp_bit,4); 			(* L[i].X4 *)
  		END_IF;
          L[i] := L_temp;
  		_TP := TRUE;
          code := (code AND BYTE#2#1000_1111) OR SHL(LINE AND BYTE#2#0000_0111,4);
          (* obere zeile enspricht: Code.X4 := Line.l; /  Code.X5 := Line.X1; / Code.RELEASE := Line.X2; *)

  		(* check if release codes need to be killed *)
  		IF NOT release AND code < BYTE#127 THEN
  			code := BYTE#0;
  			_TP := FALSE;
  		END_IF;
          EXIT;
  	END_IF;
  END_FOR;

  (* increment scan line every cycle *)
  line := INT_TO_BYTE(_BYTE_TO_INT(line) + 1) AND BYTE#2#0000_0011;
  temp := SHL(BYTE#1,_BYTE_TO_INT(line));

  Y1 := BIT_OF_DWORD(BYTE_TO_DWORD(temp),0); (* temp.0 *)
  Y2 := BIT_OF_DWORD(BYTE_TO_DWORD(temp),1); (* temp.1 *)
  Y3 := BIT_OF_DWORD(BYTE_TO_DWORD(temp),2); (* temp.2 *)
  Y4 := BIT_OF_DWORD(BYTE_TO_DWORD(temp),3); (* temp.3 *)

  (* Fromm Oscat Library, www.oscat.de *)
END_FUNCTION_BLOCK