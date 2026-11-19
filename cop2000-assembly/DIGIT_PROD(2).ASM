MOV A, 80H
    MOV R1, #00H

TLOOP:
    SUB A, #0AH
    JC TDONE

    MOV R0, A
    MOV A, R1
    ADD A, #01H
    MOV R1, A
    MOV A, R0
    JMP TLOOP

TDONE:
    ADD A, #0AH
    MOV R2, A

    MOV R3, #00H

MLOOP:
    MOV A, R1
    ADD A, #00H
    JZ MDONE

    MOV A, R3
    ADD A, R2
    MOV R3, A

    MOV A, R1
    SUB A, #01H
    MOV R1, A
    JMP MLOOP

MDONE:
    MOV A, R3
    MOV 81H, A
END_MUL:
    NOP
    JMP END_MUL
