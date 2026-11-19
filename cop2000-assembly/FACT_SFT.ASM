MOV A, #05H
MOV 80H, A
MOV R3, #01H
FACT:
    MOV A, 80H
    AND A, #255
    JZ STORE
    MOV A, 80H
    MOV R0, A
    MOV A, R3
    MOV R1, A
    MOV R2, #00H
MUL:
    MOV A, R0
    AND A, #255
    JZ MULEND
    MOV A, R0
    AND A, #01H
    JZ SHIFT
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
SHIFT:
    MOV A, R0
    RR A
    MOV R0, A
    MOV A, R1
    RL A
    MOV R1, A
    JMP MUL
MULEND:
    MOV A, R2
    MOV R3, A
    MOV A, 80H
    SUB A, #01H
    MOV 80H, A
    JMP FACT
STORE:
    MOV A, R3
    MOV 81H, A
DONE:
    NOP
    JMP DONE
