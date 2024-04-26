FUNCTION_BLOCK TOOL_CHANGER

VAR_INPUT
    ToolChangeRequired : BOOL; (** True if tool change is required **)
    ToolCarouselPosition : INT; (** Current position of the tool carousel **)
    DesiredToolNumber : INT; (** Number of the desired tool **)
END_VAR

VAR_OUTPUT
    RotateCarousel : BOOL; (** Rotate the tool carousel **)
    LockTool : BOOL; (** Lock the tool in the spindle **)
END_VAR

VAR
    ToolChangeState : INT; (**0=Idle, 1=RotatingCarousel, 2=LockingTool**)
END_VAR

IF ToolChangeRequired THEN
    CASE ToolChangeState OF
        0:
            (** Check if carousel needs to rotate **)
            IF ToolCarouselPosition <> DesiredToolNumber THEN
                RotateCarousel := TRUE;
                ToolChangeState := 1;
            ELSE
                LockTool := TRUE;
                ToolChangeState := 2;
            END_IF;

        1:
            (** Wait for carousel to reach desired position **)
            IF ToolCarouselPosition = DesiredToolNumber THEN
                RotateCarousel := FALSE;
                LockTool := TRUE;
                ToolChangeState := 2;
            END_IF;

        2:
            (** Wait for tool to be locked **)
            LockTool := FALSE;
            ToolChangeState := 0;
    END_CASE;
END_IF;

END_FUNCTION_BLOCK