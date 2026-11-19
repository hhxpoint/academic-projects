MOV R0, #00H
MOV A, #08H
MOV 80H, A
MOV A, #03H
MOV 81H, A
MOV R1, #01H
MOV A, 80H
SUB A, #01H
JC J_DONE
JZ J_DONE
J_LOOP:
    ADD R1, #01H
    MOV A, R0
    MOV R3, 81H
    ADD A, R3
    MOV R2, A
MOD_L:
    MOV A, R2
    SUB A, R1
    JC MOD_D
    JZ MOD_D
    MOV R2, A
    JMP MOD_L
MOD_D:
    MOV A, R2
    MOV R0, A
    MOV A, R1
    SUB A, 80H
    JZ J_DONE
    JMP J_LOOP
J_DONE:
    MOV A, R0
    MOV 82H, A
END_J:
    NOP
    JMP END_J
