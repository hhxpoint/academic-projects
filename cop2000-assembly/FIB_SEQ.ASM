MOV A, #05H
MOV 80H, A
MOV R0, #00H
MOV R1, #01H
MOV A, 80H
SUB A, #01H
JC STORE
JZ STORE
MOV R2, A
LOOP:
    MOV A, R2
    SUB A, #01H
    JC STORE
    JZ STORE
    MOV R2, A
    MOV A, R0
    ADD A, R1
    MOV R3, A
    MOV A, R1
    MOV R0, A
    MOV A, R3
    MOV R1, A
    JMP LOOP
STORE:
    MOV A, R1
    MOV 81H, A
DONE:
    NOP
    JMP DONE
