MOV A, #06H
MOV 80H, A
MOV R0, #00H
LOOP:
    MOV A, 80H
    SUB A, #01H
    JC DONE
    JZ DONE
    MOV A, 80H
    RR A
    JC ODD
    MOV A, 80H
    RR A
    MOV 80H, A
    ADD R0, #01H
    JMP LOOP
ODD:
    MOV A, 80H
    MOV R1, A
    ADD A, R1
    ADD A, R1
    ADD A, #01H
    MOV 80H, A
    ADD R0, #01H
    JMP LOOP
DONE:
    MOV A, R0
    MOV 81H, A
END:
    NOP
    JMP END
