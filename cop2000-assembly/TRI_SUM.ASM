MOV A, #07H
MOV 80H, A
MOV R0, #00H
MOV R1, #01H
T_LOOP:
    MOV A, R1
    SUB A, 80H
    JC T_DONE
    JZ T_LAST
    MOV A, R0
    ADD A, R1
    MOV R0, A
    ADD R1, #01H
    JMP T_LOOP
T_LAST:
    MOV A, R0
    ADD A, R1
    MOV R0, A
T_DONE:
    MOV A, R0
    MOV 81H, A
END_T:
    NOP
    JMP END_T
