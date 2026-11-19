MOV A, #0B3H
MOV 80H, A
MOV A, 80H
RL A
JC NEG
JMP DONE
NEG:
    MOV A, 80H
    MOV R0, A
    MOV A, #0FFH
    SUB A, R0
    ADD A, #01H
    MOV 80H, A
DONE:
    NOP
    JMP DONE
