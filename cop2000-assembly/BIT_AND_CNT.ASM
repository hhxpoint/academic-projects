MOV A, 80H
    MOV R0, A
    MOV A, 81H
    MOV R1, A
    MOV A, R0
    AND A, R1
    MOV R0, A
    MOV R2, #00H
CNT_LOOP:
    MOV A, R0
    ADD A, #00H
    JZ DONE_C
    SUB A, #01H
    MOV R1, A
    MOV A, R0
    AND A, R1
    MOV R0, A
    MOV A, R2
    ADD A, #01H
    MOV R2, A
    JMP CNT_LOOP
DONE_C:
    MOV A, R2
    MOV 82H, A
END_C:
    NOP
    JMP END_C
