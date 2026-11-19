    MOV A,90H
    SUB A,91H
    JC SWAP1
    JZ SKIP1
    JMP SKIP1
SWAP1:
    MOV A,91H
SKIP1:
    SUB A,92H
    JC SWAP2
    JZ SKIP2
    JMP SKIP2
SWAP2:
    MOV A,92H
SKIP2:
    SUB A,93H
    JC SWAP3
    JZ SKIP3
    JMP SKIP3
SWAP3:
    MOV A,93H
SKIP3:
    MOV 80H,A
    NOP
    JMP $
