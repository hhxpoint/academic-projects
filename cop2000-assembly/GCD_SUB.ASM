MOV A, #0CH
MOV 80H, A
MOV A, #08H
MOV 81H, A
LOOP:
    MOV A, 80H
    SUB A, 81H
    JZ DONE
    JC SWAP
    MOV 80H, A
    JMP LOOP
SWAP:
    MOV A, 81H
    SUB A, 80H
    MOV 81H, A
    JMP LOOP
DONE:
    MOV A, 80H
    MOV 82H, A
END:
    NOP
    JMP END
