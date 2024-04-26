FUNCTION_BLOCK DEC_TO_HEX
  VAR_INPUT
    DecimalValue : DINT;
  END_VAR
  VAR_OUTPUT
    HexString : STRING;
  END_VAR
  VAR
    i : INT;
    hexDigits : ARRAY [0..15] OF STRING := ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'];
    digitIndex : INT;
    hexDigit : STRING;
    significantDigitFound : BOOL := FALSE;
    digitValue : DINT;
    powerOfInteger : DINT;
  END_VAR

  HexString := ''; 

  IF DecimalValue = 0 THEN
      HexString := '0';
      RETURN;
  END_IF;

  significantDigitFound := FALSE; 

  FOR digitIndex := 0 TO 7 DO
      
      powerOfInteger:=1;
      FOR i := 1 TO 7 - digitIndex DO
        powerOfInteger := powerOfInteger * 16;
      END_FOR;
     
      digitValue := DIV(DecimalValue, powerOfInteger) MOD 16;
      hexDigit := hexDigits[digitValue];
      
      IF hexDigit <> '0' OR significantDigitFound OR (7 - digitIndex) = 0 THEN
          significantDigitFound := TRUE;
          HexString := CONCAT(HexString, hexDigit);
      END_IF;
              
  END_FOR;
END_FUNCTION_BLOCK