    MOV A, 80H
    MOV R2, A
    MOV A, R2
    MOV R0, A
    MOV R3, R0
    MOV R0, R3

    MOV A, 81H
    MOV R2, A
    MOV A, R2
    ADD A, R0
    MOV R2, A
    MOV A, R2
    MOV R0, A
    MOV R3, R0
    MOV R0, R3

    MOV A, 82H
    MOV R2, A
    MOV A, R2
    ADD A, R0
    MOV R2, A
    MOV A, R2
    MOV R3, A
    MOV A, R3

    MOV R1, #00H
    MOV A, R1
    MOV R1, A
    MOV R2, #00H
    MOV R1, R2

DIV_LOOP:
    MOV R2, A
    MOV A, R2
    SUB A, #03H
    JC  STORE

    MOV R0, A
    MOV R2, R0
    MOV R0, R2
    MOV A, R1
    ADD A, #01H
    MOV R2, A
    MOV A, R2
    MOV R1, A
    MOV A, R0
    MOV R2, A
    MOV A, R2
    NOP
    JMP DIV_LOOP

STORE:
    MOV A, R1
    MOV R2, A
    MOV A, R2
    MOV 83H, A
    MOV A, 83H
    MOV R2, A
    MOV A, R2

DONE:
    NOP
    NOP
    MOV R2, A
    MOV A, R2
    NOP
    JMP DONE
