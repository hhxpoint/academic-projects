MOV A, #05H
MOV 80H, A
MOV R3, #B0H
MOV A, 80H
MOV R2, A
PUSH:
    MOV A, R2
    SUB A, #01H
    JC POP
    JZ POP
    MOV A, R2
    MOV @R3, A
    ADD R3, #01H
    MOV A, R2
    SUB A, #01H
    MOV R2, A
    JMP PUSH
POP:
    MOV A, #01H
    MOV R2, A
POPLOOP:
    MOV A, R3
    SUB A, #B0H
    JZ STORE
    SUB R3, #01H
    MOV A, @R3
    MOV R0, A
    MOV A, R2
    MOV R1, A
    MOV R2, #00H
MUL:
    MOV A, R0
    AND A, #255
    JZ MULDONE
    MOV A, R0
    AND A, #01H
    JZ SHFT
    MOV A, R0
    RR A
    MOV R0, A
    MOV A, R2
    ADD A, R1
    MOV R2, A
    MOV A, R1
    RL A
    MOV R1, A
    JMP MUL
SHFT:
    MOV A, R0
    RR A
    MOV R0, A
    MOV A, R1
    RL A
    MOV R1, A
    JMP MUL
MULDONE:
    JMP POPLOOP
STORE:
    MOV A, R2
    MOV 81H, A
DONE:
    NOP
    JMP DONE
