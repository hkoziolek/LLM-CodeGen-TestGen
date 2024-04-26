FUNCTION_BLOCK CRC_GEN
  VAR_IN_OUT
    PT : ARRAY [0..249] OF BYTE;
  END_VAR
  VAR_INPUT
    SIZE : UINT;
    PL : UINT;
    PN : DWORD;
    INIT : DWORD;
    REV_IN : BOOL;
    REV_OUT : BOOL;
    XOR_OUT : DWORD;
  END_VAR
  VAR_OUTPUT
    _CRC_GEN : DWORD;
  END_VAR
  VAR
    pos : INT;
    shift : INT;
    bits : INT;
    dx : BYTE;
  END_VAR

  shift := 32 - UINT_TO_INT(PL);
  PN := SHL(PN, shift);

  (* load first 4 bytes into register minimum message size is 4 bytes
  	for smaller messages fill with 0#s at the beginning*)
  FOR pos := 0 TO 3 DO
  	IF REV_IN THEN _CRC_GEN := SHL(_CRC_GEN, 8) OR BYTE_TO_DWORD(REVERSE(PT[pos])); ELSE _CRC_GEN := SHL(_CRC_GEN, 8) OR BYTE_TO_DWORD(PT[pos]); END_IF;
  END_FOR;
  pos := 4;

  (* xor with init value *)
  _CRC_GEN := _CRC_GEN XOR SHL(init, shift);

  (* calculate CRC for each byte *)
  WHILE pos < UINT_TO_INT(size) DO
  	IF REV_IN THEN DX := REVERSE(PT[pos]); ELSE DX := PT[pos]; END_IF;
  	pos := pos + 1;
  	(* crc calculation for one byte *)
  	FOR bits := 0 TO 7 DO
  		IF (_CRC_GEN AND DWORD#16#8000_0000) > DWORD#0 THEN (* CRC_GEN.31 *)
  			_CRC_GEN := (SHL(_CRC_GEN, 1) OR BOOL_TO_DWORD((DX AND BYTE#16#80) > BYTE#0)) XOR PN; (* DX.7 *)
  		ELSE
  			_CRC_GEN := SHL(_CRC_GEN, 1) OR BOOL_TO_DWORD((DX AND BYTE#16#80) > BYTE#0); (* DX.7 *)
  		END_IF;
  		dx := SHL(dx, 1);
  	END_FOR;
  END_WHILE;

  (* all bytes are processed, need to finish the registers 32 bits *)
  FOR bits := 0 TO 31 DO
  	IF (_CRC_GEN AND DWORD#16#8000_0000) > DWORD#0 THEN (* CRC_GEN.31 *)
  		_CRC_GEN := (SHL(_CRC_GEN, 1) OR BOOL_TO_DWORD((DX AND BYTE#16#80) > BYTE#0)) XOR PN; (* DX.7 *)
  	ELSE
  		_CRC_GEN := SHL(_CRC_GEN, 1) OR BOOL_TO_DWORD((DX AND BYTE#16#80) > BYTE#0); (* DX.7 *)
  	END_IF;
  END_FOR;

  (* final XOR *)
  _CRC_GEN := SHR(_CRC_GEN, shift) XOR XOR_OUT;

  (* reverse the crc_out put if necessary *)
  IF REV_OUT THEN _CRC_GEN := REFLECT(_CRC_GEN, UINT_TO_INT(PL)); END_IF;


  (* typical crc polynoms

  CRC-4-ITU 			x4 + x + 1 					(ITU G.704, p. 12) 	0x3 or 0xC (0x9)
  CRC-5-ITU 			x5 + x4 + x2 + 1 			(ITU G.704, p. 9) 	0x15 or 0x15 (0x0B) Bluetooth
  CRC-5-USB 			x5 + x2 + 1 				(use: USB token packets) 	0x05 or 0x14 (0x9)
  CRC-6-ITU 			x6 + x + 1 					(ITU G.704, p. 3) 	0x03 or 0x30 (0x21)
  CRC-7 				x7 + x3 + 1 				(use: telecom systems, MMC) 	0x09 or 0x48 (0x11)
  CRC-8-ATM 			x8 + x2 + x + 1 				(use: ATM HEC) 	0x07 or 0xE0 (0xC1)
  CRC-8-CCITT 		x8 + x7 + x3 + x2 + 1 		(use: 1-Wire bus) 	0x8D or 0xB1 (0x63)
  CRC-8-Dallas/Maxim 	x8 + x5 + x4 + 1 			(use: 1-Wire bus) 	0x31 or 0x8C (0x19)
  CRC-8 				x8 + x7 + x6 + x4 + x2 + 1 	0xD5 or 0xAB (0x57)
  CRC-8-SAE J1850 	x8 + x4 + x3 + x2 + 1 		0x1D or 0xB8
  CRC-10 				x10 + x9 + x5 + x4 + x + 1 	0x233 or 0x331 (0x263)
  CRC-12 				x12 + x11 + x3 + x2 + x + 1 (use: telecom systems) 	0x80F or 0xF01 (0xE03)
  CRC-15-CAN 			x15 + x14 + x10 + x8 + x7 + x4 + x3 + 1 	0x4599 or 0x4CD1 (0x19A3)
  CRC-16-Fletcher 	Not a CRC; see Fletchers checksum 	Used in Adler-32 A & B CRCs
  CRC-16-CCITT 	x16 + x12 + x5 + 1 (XMODEM,X.25, V.41, Bluetooth, PPP, IrDA; known as "CRC-CCITT") 	0x1021 or 0x8408 (0x0811)
  CRC-16-IBM 	x16 + x15 + x2 + 1 (USB, many others; also known as "CRC-16") 	0x8005 or 0xA001 (0x4003)
  CRC-24-Radix-64 	x24 + x23 + x18 + x17 + x14 + x11 + x10 + x7 + x6 + x5 + x4 + x3 + x + 1 	0x864CFB or 0xDF3261 (0xBE64C3)
  CRC-32-Adler 	Not a CRC; see Adler-32 	See Adler-32
  CRC-32-MPEG2 	x32 + x26 + x23 + x22 + x16 + x12 + x11 + x10 + x8 + x7 + x5 + x4 + x2 + x + 1 	0x04C11DB7 or 0xEDB88320 (0xDB710641) Also used in IEEE 802.3
  CRC-32-IEEE 802.3 	x32 + x26 + x23 + x22 + x16 + x12 + x11 + x10 + x8 + x7 + x5 + x4 + x2 + x + 1 (V.42) 	0x04C11DB7 or 0xEDB88320 (0xDB710641)
  CRC-32C (Castagnoli) 	x32 + x28 + x27 + x26 + x25 + x23 + x22 + x20 + x19 + x18 + x14 + x13 + x11 + x10 + x9 + x8 + x6 + 1 	0x1EDC6F41 or 0x82F63B78 (0x05EC76F1)
  CRC-64-ISO 	x64 + x4 + x3 + x + 1 (use: ISO 3309) 	0x000000000000001B or 0xD800000000000000 (0xB000000000000001)
  CRC-64-ECMA-182 	x64 + x62 + x57 + x55 + x54 + x53 + x52 + x47 + x46 + x45 + x40 + x39 + x38 + x37 + x35 + x33 + x32 + x31 + x29 + x27 + x24 + x23 + x22 + x21 + x19 + x17 + x13 + x12 + x10 + x9 + x7 + x4 + x + 1
  (as described in ECMA-182 p.63) 	0x42F0E1EBA9EA3693 or 0xC96C5795D7870F42 (0x92D8AF2BAF0E1E85)
  *)
END_FUNCTION_BLOCK