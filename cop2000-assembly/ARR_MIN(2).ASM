    MOV A, 90H
    MOV R0, A

    MOV A, R0
    SUB A, 91H
    JC UPDATE_1
    JMP NEXT_1
UPDATE_1:
    MOV A, 91H
    MOV R0, A
NEXT_1:

    MOV A, R0
    SUB A, 92H
    JC UPDATE_2
    JMP NEXT_2
UPDATE_2:
    MOV A, 92H
    MOV R0, A
NEXT_2:

    MOV A, R0
    SUB A, 93H
    JC UPDATE_3
    JMP NEXT_3
UPDATE_3:
    MOV A, 93H
    MOV R0, A
NEXT_3:

    MOV A, R0
    MOV 80H, A
END_MAX:
    NOP
    JMP END_MAX
