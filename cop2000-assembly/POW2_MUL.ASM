    MOV A,80H
    MOV 82H,A
    MOV A,81H
    MOV R0,A
LOOP:
    MOV A,R0
    AND A,#0FFH
    JZ DONE
    MOV A,82H
    RL A
    MOV 82H,A
    MOV A,R0
    SUB A,#01H
    MOV R0,A
    JMP LOOP
DONE:
    NOP
    JMP DONE
