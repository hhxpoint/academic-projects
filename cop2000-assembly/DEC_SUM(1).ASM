    MOV A,80H
    MOV R1,#00H
HLOOP:
    SUB A,#100
    JC HDONE
    JZ HDONE
    ADD R1,#01H
    JMP HLOOP
HDONE:
    JC HREST
    JMP HCONT
HREST:
    ADD A,#100
HCONT:
    MOV R2,#00H
TLOOP:
    SUB A,#10
    JC TDONE
    JZ TDONE
    ADD R2,#01H
    JMP TLOOP
TDONE:
    JC TREST
    JMP TCONT
TREST:
    ADD A,#10
TCONT:
    ADD A,R1
    ADD A,R2
    MOV 81H,A
    NOP
    JMP $
