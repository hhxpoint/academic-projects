MOV A, #0C3H
MOV 80H, A
MOV R1, #00H
MOV R2, #08H
LOOP:
    MOV A, R2
    SUB A, #01H
    JC DONE
    JZ DONE
    MOV R2, A
    MOV A, R1
    RL A
    MOV R1, A
    MOV A, 80H
    RL A
    MOV 80H, A
    MOV A, 80H
    AND A, #01H
    JZ NOBIT
    MOV A, R1
    OR A, #01H
    MOV R1, A
NOBIT:
    JMP LOOP
DONE:
    MOV A, R1
    MOV 81H, A
END:
    NOP
    JMP END
