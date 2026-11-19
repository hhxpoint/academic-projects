MOV A, #05H
MOV 80H, A
MOV R0, #00H
MOV R1, #00H
MOV R2, #08H
G_LOOP:
    MOV A, R2
    SUB A, #01H
    JC G_DONE
    JZ G_DONE
    MOV R2, A
    MOV A, R0
    RL A
    MOV R0, A
    MOV A, 80H
    RR A
    MOV 80H, A
    JC G_SET
    JMP G_LOOP
G_SET:
    MOV A, R0
    ADD A, #01H
    MOV R0, A
    JMP G_LOOP
G_DONE:
    MOV A, R0
    MOV 81H, A
END_G:
    NOP
    JMP END_G
