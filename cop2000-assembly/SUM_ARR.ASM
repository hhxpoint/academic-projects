    MOV A,90H
    MOV R0,A
    MOV A,91H
    ADD A,R0
    MOV R0,A
    MOV A,92H
    ADD A,R0
    MOV 80H,A
DONE:
    NOP
    JMP DONE
