FUNCTION_BLOCK TRAFFIC_CTRL


VAR_INPUT
    PedestrianButton1 : BOOL;
    PedestrianButton2 : BOOL;
END_VAR

VAR_OUTPUT
    NorthSouthRed : BOOL;
    NorthSouthYellow : BOOL;
    NorthSouthGreen : BOOL;
    EastWestRed : BOOL;
    EastWestYellow : BOOL;
    EastWestGreen : BOOL;
    PedestrianLight1 : BOOL;
    PedestrianLight2 : BOOL;
END_VAR

VAR
    LightState : INT := 0; (* 0: North-South Green, 1: North-South Yellow, 2: East-West Green, 3: East-West Yellow *)
    PedestrianRequest1 : BOOL := FALSE;
    PedestrianRequest2 : BOOL := FALSE;
    PedestrianCrossing : BOOL := FALSE;
    Timer : TON;
END_VAR

(* Check for pedestrian requests *)
IF PedestrianButton1 THEN
    PedestrianRequest1 := TRUE;
END_IF;

IF PedestrianButton2 THEN
    PedestrianRequest2 := TRUE;
END_IF;

(* Traffic light state machine *)
CASE LightState OF
    0: (* North-South Green *)
        NorthSouthGreen := TRUE;
        EastWestRed := TRUE;
        IF PedestrianRequest1 OR PedestrianRequest2 THEN
            Timer(IN := TRUE, PT := T#2s); (* Pedestrian crossing grace period *)
            IF Timer.Q THEN
                Timer(IN := FALSE);
                LightState := 1;
            END_IF;
        END_IF;

    1: (* North-South Yellow *)
        NorthSouthYellow := TRUE;
        EastWestRed := TRUE;
        Timer(IN := TRUE, PT := T#2s); (* Yellow light duration *)
        IF Timer.Q THEN
            Timer(IN := FALSE);
            LightState := 2;
        END_IF;

    2: (* East-West Green *)
        EastWestGreen := TRUE;
        NorthSouthRed := TRUE;
        IF PedestrianRequest1 THEN
            PedestrianLight1 := TRUE;
            PedestrianCrossing := TRUE;
        END_IF;
        IF PedestrianRequest2 THEN
            PedestrianLight2 := TRUE;
            PedestrianCrossing := TRUE;
        END_IF;
        IF PedestrianCrossing THEN
            Timer(IN := TRUE, PT := T#2s); (* Pedestrian crossing period *)
            IF Timer.Q THEN
                Timer(IN := FALSE);
                PedestrianRequest1 := FALSE;
                PedestrianRequest2 := FALSE;
                PedestrianLight1 := FALSE;
                PedestrianLight2 := FALSE;
                PedestrianCrossing := FALSE;
                LightState := 3;
            END_IF;
        END_IF;

    3: (* East-West Yellow *)
        EastWestYellow := TRUE;
        NorthSouthRed := TRUE;
        Timer(IN := TRUE, PT := T#2s); (* Yellow light duration *)
        IF Timer.Q THEN
            Timer(IN := FALSE);
            LightState := 0;
        END_IF;

END_CASE;

END_FUNCTION_BLOCK