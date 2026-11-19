    MOV A,80H
LOOP:
    SUB A,#03H
    JC REM
    JNZ LOOP
    JMP IS_ZERO
REM:
    ADD A,#03H
    AND A,#0FFH
    JZ IS_ZERO
    MOV 81H,#00H
    JMP END
IS_ZERO:
    MOV 81H,#01H
END:
    NOP
    JMP END
