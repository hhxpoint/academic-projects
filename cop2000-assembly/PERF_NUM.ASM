    MOV A,80H
    MOV R0,#0
    MOV A,80H
    SUB A,#2
    JC DONE
    MOV R3,#0
HLIM:
    MOV A,80H
    SUB A,R3
    SUB A,R3
    JC GOT_LIM
    ADD R3,#1
    JMP HLIM
GOT_LIM:
    MOV R1,#1
DIV_LOOP:
    MOV A,R1
    SUB A,R3
    JC CHK_PERF
    SUB A,#1
    JC CHK_PERF
    MOV A,80H
    MOV R2,A
CHK_LOOP:
    SUB A,R1
    JC NOT_DIV
    MOV A,R2
    SUB A,R1
    MOV R2,A
    JZ IS_DIV
    JMP CHK_LOOP
NOT_DIV:
    ADD R1,#1
    JMP DIV_LOOP
IS_DIV:
    MOV A,R0
    ADD A,R1
    MOV R0,A
    ADD R1,#1
    JMP DIV_LOOP
CHK_PERF:
    MOV A,R0
    SUB A,80H
    JZ SET_ONE
    MOV A,#0
    MOV 81H,A
    JMP END_P
SET_ONE:
    MOV A,#1
    MOV 81H,A
END_P:
    NOP
    JMP END_P
DONE:
    MOV A,#0
    MOV 81H,A
    NOP
    JMP DONE
