MOV A, #19H
MOV 80H, A
MOV R1, #01H
MOV R2, #00H
LOOP:
    MOV A, 80H
    SUB A, R1
    JC DONE
    MOV 80H, A
    ADD R2, #01H
    MOV A, R1
    ADD A, #02H
    MOV R1, A
    JMP LOOP
DONE:
    MOV A, R2
    MOV 81H, A
END:
    NOP
    JMP END
