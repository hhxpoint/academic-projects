    MOV R0,#00H
LOOP:
    MOV A,80H
    AND A,#0FFH
    JZ DONE
    MOV A,80H
    SUB A,#01H
    MOV 8FH,A
    MOV A,80H
    AND A,8FH
    MOV 80H,A
    ADD R0,#01H
    JMP LOOP
DONE:
    MOV A,R0
    MOV 81H,A
    NOP
    JMP DONE
