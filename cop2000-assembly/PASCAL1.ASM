    MOV R1, #08H
    MOV R0, #90H
INITZ:
    MOV A, #00H
    MOV @R0, A

    MOV A, R0
    ADD A, #01H
    MOV R0, A

    MOV A, R1
    SUB A, #01H
    MOV R1, A
    JZ INIZDN
    JMP INITZ

INIZDN:
    MOV A, #01H
    MOV 90H, A

    MOV A, 80H
    MOV R3, A

OUTER:
    MOV A, R3
    ADD A, #00H
    JZ ODONE

    MOV R1, #91H

INNER:
    MOV A, R3
    ADD A, #91H
    MOV R2, A

    MOV A, R1
    SUB A, R2
    JC INPROC
    JMP INEXT

INPROC:
    MOV A, R1
    SUB A, #01H
    MOV R0, A
    MOV A, @R0
    MOV R2, A

    MOV A, R1
    MOV R0, A
    MOV A, @R0
    ADD A, R2
    MOV @R0, A

    MOV A, R1
    ADD A, #01H
    MOV R1, A

    JMP INNER

INEXT:
    MOV A, R3
    SUB A, #01H
    MOV R3, A
    JMP OUTER

ODONE:
    NOP
    JMP ODONE
