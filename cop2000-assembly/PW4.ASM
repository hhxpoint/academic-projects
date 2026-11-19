DIVLOOP:
    MOV A, 80H
    ADD A, #00H
    JZ NOTP4
    SUB A, #01H
    JZ YESP4
    MOV A, 80H
    MOV R1, #00H
DBY4:
    SUB A, #04H
    JC DEND
    MOV R0, A
    MOV A, R1
    ADD A, #01H
    MOV R1, A
    MOV A, R0
    JMP DBY4
DEND:
    ADD A, #04H
    ADD A, #00H
    JZ DIV_OK
    JMP NOTP4
DIV_OK:
    MOV A, R1
    MOV 80H, A
    JMP DIVLOOP
NOTP4:
    MOV A, #00H
    MOV 81H, A
    JMP FIN
YESP4:
    MOV A, #01H
    MOV 81H, A
FIN:
    NOP
    JMP FIN
