    MOV A,81H
    AND A,#255
    JZ KZERO
    MOV A,80H
    MOV R2,#00H
BASEM:
    SUB A,#10
    JC BDONE
    JZ BDONE
    ADD R2,#01H
    JMP BASEM
BDONE:
    JC BREST
    JMP BCONT
BREST:
    ADD A,#10
BCONT:
    MOV R1,A
    MOV R3,#01H
    MOV A,81H
    MOV R0,A
MLOOP:
    MOV A,R3
    MOV R2,A
    MOV A,#00H
    JZ MZ
MMUL:
    ADD A,R1
    JC MCARRY
    JMP MNXT
MCARRY:
    SUB A,#10
MNXT:
    MOV R2,A
    MOV A,R3
    SUB A,#01H
    JZ MZ
    MOV R3,A
    MOV A,R2
    JMP MMUL
MZ:
    MOV R3,A
    MOV A,R0
    SUB A,#01H
    JZ MDONE
    MOV R0,A
    JMP MLOOP
MDONE:
    MOV A,R3
    MOV 82H,A
    JMP FIN
KZERO:
    MOV A,#01H
    MOV 82H,A
FIN:
    NOP
    JMP $
