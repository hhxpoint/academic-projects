    MOV A,80H
    SUB A,#02H
    JC NPRM
    JZ YPRM
    MOV R1,#02H
DLOOP:
    MOV A,80H
    MOV R2,#00H
DDIV:
    SUB A,R1
    JC DEND
    ADD R2,#01H
    JZ DEND
    JMP DDIV
DEND:
    JC DREST
    JMP DCHECK
DREST:
    ADD A,R1
DCHECK:
    AND A,#255
    JZ NPRM
    MOV A,R1
    ADD A,#01H
    MOV R1,A
    MOV A,R1
    SUB A,80H
    JZ YPRM
    JMP DLOOP
NPRM:
    MOV A,#00H
    MOV 81H,A
    JMP FIN
YPRM:
    MOV A,#01H
    MOV 81H,A
FIN:
    NOP
    JMP $
