START:
    MOV A, 80H
    MOV R0, #00H
    MOV A, 80H
    SUB A, #02H
    JC DONE
    MOV R3, #00H
HLIM:
    MOV A, 80H
    SUB A, R3
    SUB A, R3
    JC GOT_LIM
    MOV A, R3
    ADD A, #01H
    MOV R3, A
    JMP HLIM
GOT_LIM:
    MOV R1, #01H
DIV_LOOP:
    MOV A, R1
    SUB A, R3
    JZ CHK_PERF
    MOV A, 80H
    MOV R2, A
CHK_LOOP:
    SUB A, R1
    JC NOT_DIV
    MOV A, R2
    SUB A, R1
    JZ IS_DIV
    MOV R2, A
    JMP CHK_LOOP
NOT_DIV:
    MOV A, R1
    ADD A, #01H
    MOV R1, A
    JMP DIV_LOOP
IS_DIV:
    MOV A, R0
    ADD A, R1
    MOV R0, A
    MOV A, R1
    ADD A, #01H
    MOV R1, A
    JMP DIV_LOOP
CHK_PERF:
    MOV A, R0
    SUB A, 80H
    JZ SET_ONE
    MOV A, #00H
    MOV 81H, A
    JMP END_P
SET_ONE:
    MOV A, #01H
    MOV 81H, A
END_P:
    NOP
    JMP END_P
DONE:
    MOV A, #00H
    MOV 81H, A
    NOP
    JMP DONE
