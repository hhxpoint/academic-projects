MOV A, #03H
MOV 80H, A
MOV A, #05H
MOV 81H, A
MOV R0, #00H
MOV A, 81H
MOV R1, A
MOV A, 80H
MOV R2, A
R_LOOP:
    MOV A, R1
    SUB A, #01H
    JC R_DONE
    JZ R_LAST
    MOV A, R0
    ADD A, R2
    MOV R0, A
    MOV A, R1
    SUB A, #01H
    MOV R1, A
    JMP R_LOOP
R_LAST:
    MOV A, R0
    ADD A, R2
    MOV R0, A
R_DONE:
    MOV A, R0
    MOV 82H, A
END_R:
    NOP
    JMP END_R
