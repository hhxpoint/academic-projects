    MOV A,80H
    MOV R1,#00H
TLOOP:
    SUB A,#10
    JC TDONE
    JZ TDONE
    ADD R1,#01H
    JMP TLOOP
TDONE:
    JC TREST
    JMP TCONT
TREST:
    ADD A,#10
TCONT:
    MOV R2,A
    MOV R3,#00H
    MOV A,R1
    AND A,#255
    JZ MDONE
MLOOP:
    MOV A,R3
    ADD A,R2
    MOV R3,A
    MOV A,R1
    SUB A,#01H
    JZ MDONE
    MOV R1,A
    JMP MLOOP
MDONE:
    MOV A,R3
    MOV 81H,A
    NOP
    JMP $
