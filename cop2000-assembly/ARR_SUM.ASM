MOV R0, #90H
MOV R1, #08H
MOV R2, #00H
LOOP:
    MOV A, R1
    SUB A, #01H
    JC DONE
    JZ DONE
    MOV R1, A
    MOV A, R2
    ADD A, @R0
    MOV R2, A
    ADD R0, #01H
    JMP LOOP
DONE:
    MOV A, R2
    MOV 80H, A
END:
    NOP
    JMP END
