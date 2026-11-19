    MOV A,80H
    MOV 90H,A
    ADD A,81H
    MOV 91H,A
    ADD A,82H
    MOV 92H,A
END_S:
    NOP
    JMP END_S
