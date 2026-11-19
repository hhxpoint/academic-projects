    MOV R1,#08H
    MOV R0,#90H
INITZ:
    MOV A,#00H
    MOV @R0,A
    ADD R0,#01H
    MOV A,R1
    SUB A,#01H
    JZ INIZDN
    MOV R1,A
    JMP INITZ
INIZDN:
    MOV A,#01H
    MOV 90H,A
    MOV A,80H
    MOV R2,A
OUTER:
    MOV A,R2
    SUB A,#01H
    JZ ODONE
    MOV R2,A
    MOV A,R2
    ADD A,#90H
    MOV R3,A
    MOV R1,#91H
INNER:
    MOV A,R1
    SUB A,R3
    JC INPROC
    JMP INEXT
INPROC:
    MOV A,R1
    SUB A,#01H
    MOV R0,A
    MOV A,@R0
    MOV R2,A
    MOV A,R1
    MOV R0,A
    MOV A,@R0
    ADD A,R2
    MOV @R0,A
    ADD R1,#01H
    JMP INNER
INEXT:
    JMP OUTER
ODONE:
    NOP
    JMP $
