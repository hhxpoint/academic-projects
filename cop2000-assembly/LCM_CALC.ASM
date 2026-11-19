    MOV A,80H
    MOV R0,A
    MOV A,81H
    MOV R1,A
LOOP:
    MOV A,R0
    SUB A,R1
    JZ STORE
    JC ADD_R0
    MOV A,81H
    ADD A,R1
    MOV R1,A
    JMP LOOP
ADD_R0:
    MOV A,80H
    ADD A,R0
    MOV R0,A
    JMP LOOP
STORE:
    MOV A,R0
    MOV 82H,A
DONE:
    NOP
    JMP DONE
