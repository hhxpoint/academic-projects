    MOV A,90H
    SUB A,91H
    JC NEG1
    MOV R0,A
    JMP PAIR2
NEG1:
    MOV A,91H
    SUB A,90H
    MOV R0,A
PAIR2:
    MOV A,91H
    SUB A,92H
    JC NEG2
    MOV R1,A
    JMP CMP2
NEG2:
    MOV A,92H
    SUB A,91H
    MOV R1,A
CMP2:
    MOV A,R1
    SUB A,R0
    JC PAIR3
    MOV A,R1
    MOV R0,A
PAIR3:
    MOV A,92H
    SUB A,93H
    JC NEG3
    MOV R1,A
    JMP CMP3
NEG3:
    MOV A,93H
    SUB A,92H
    MOV R1,A
CMP3:
    MOV A,R1
    SUB A,R0
    JC DONE_D
    MOV A,R1
    MOV R0,A
DONE_D:
    MOV A,R0
    MOV 80H,A
END_D:
    NOP
    JMP END_D
