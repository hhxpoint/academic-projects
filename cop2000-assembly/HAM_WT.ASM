MOV A, #15
MOV 80H, A
MOV R0, #00H
LOOP:
    MOV A, 80H
    AND A, #255
    JZ DONE
    MOV A, 80H
    AND A, #01H
    JZ SKIP
    ADD R0, #01H
SKIP:
    MOV A, 80H
    RR A
    MOV 80H, A
    JMP LOOP
DONE:
    MOV A, R0
    MOV 81H, A
END:
    NOP
    JMP END
