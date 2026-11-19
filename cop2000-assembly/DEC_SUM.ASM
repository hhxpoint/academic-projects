MOV A, 80H
    MOV R0, A
    MOV R1, #00H
    MOV R2, #00H
H_LOOP:
    MOV A, R0
    SUB A, #64H
    JC H_DONE
    MOV R0, A
    MOV A, R1
    ADD A, #01H
    MOV R1, A
    JMP H_LOOP
H_DONE:
T_LOOP:
    MOV A, R0
    SUB A, #0AH
    JC T_DONE
    MOV R0, A
    MOV A, R2
    ADD A, #01H
    MOV R2, A
    JMP T_LOOP
T_DONE:
    MOV A, R1
    ADD A, R2
    ADD A, R0
    MOV 81H, A
END_D:
    NOP
    JMP END_D
