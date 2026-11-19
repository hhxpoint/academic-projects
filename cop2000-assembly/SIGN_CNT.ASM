MOV R0, #90H
MOV R1, #08H
MOV R2, #00H
MOV R3, #00H
LOOP:
    MOV A, R1
    SUB A, #01H
    JC STORE
    JZ STORE
    MOV R1, A
    MOV A, @R0
    AND A, #255
    JZ ZERO
    RL A
    JC NEG
    ADD R2, #01H
    JMP ADV
NEG:
    ADD R3, #01H
    JMP ADV
ZERO:
    JMP ADV
ADV:
    ADD R0, #01H
    JMP LOOP
STORE:
    MOV A, R2
    MOV 80H, A
    MOV A, R3
    MOV 81H, A
DONE:
    NOP
    JMP DONE
