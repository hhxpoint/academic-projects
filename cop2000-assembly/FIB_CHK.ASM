    MOV A,80H
    JZ NO
    MOV A,80H
    SUB A,#01H
    JZ YES
    SUB A,#01H
    JZ YES
    MOV R0,#01H
    MOV R1,#02H
FLOOP:
    MOV A,80H
    SUB A,R1
    JZ YES
    JC NO
    MOV A,R0
    ADD A,R1
    MOV R2,A
    MOV A,R1
    MOV R0,A
    MOV A,R2
    MOV R1,A
    JC OVFW
    JMP FLOOP
OVFW:
NO:
    MOV A,#00H
    MOV 81H,A
    JMP FIN
YES:
    MOV A,#01H
    MOV 81H,A
FIN:
    NOP
    JMP $
