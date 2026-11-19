MOV R0, #90H
MOV R1, #08H
MOV R2, #00H
LOOP:
    MOV A, R1
    SUB A, #01H
    JC STORE
    JZ STORE
    MOV R1, A
    MOV A, R2
    XOR A, @R0
    MOV R2, A
    ADD R0, #01H
    JMP LOOP
STORE:
    MOV A, R2
    MOV 80H, A
DONE:
    NOP
    JMP DONE
