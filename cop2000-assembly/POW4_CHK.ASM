    MOV A,80H
    AND A,#255
    JZ NOTP4
    SUB A,#01H
    JZ YESP4
DIVLOOP:
    MOV A,80H
    MOV R1,#00H
DBY4:
    SUB A,#04H
    JC DEND
    MOV A,R1
    ADD A,#01H
    MOV R1,A
    JZ DEND
    JMP DBY4
DEND:
    JC DREST
    JMP DCHK
DREST:
    ADD A,#04H
DCHK:
    AND A,#255
    JZ DCHK_CONT
    JMP NOTP4
DCHK_CONT:
    MOV A,R1
    SUB A,#01H
    JZ YESP4
    MOV 80H,A
    JMP DIVLOOP
NOTP4:
    MOV A,#00H
    MOV 81H,A
    JMP FIN
YESP4:
    MOV A,#01H
    MOV 81H,A
FIN:
    NOP
    JMP $
