MOV A, #05H
MOV 80H, A
MOV R0, #01H
FACT:
    MOV A, 80H
    AND A, #255
    JZ STORE
    MOV A, 80H
    MOV R1, A
    MOV A, R1
    MOV R2, A
    MOV R3, #00H
MUL:
    MOV A, R2
    AND A, #255
    JZ MULEND
    MOV A, R3
    ADD A, R0
    MOV R3, A
    SUB R2, #01H
    JMP MUL
MULEND:
    MOV A, R3
    MOV R0, A
    MOV A, 80H
    SUB A, #01H
    MOV 80H, A
    JMP FACT
STORE:
    MOV A, R0
    MOV 81H, A
DONE:
    NOP
    JMP DONE
