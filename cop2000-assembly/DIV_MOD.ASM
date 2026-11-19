MOV A, #0AH
MOV 80H, A
MOV A, #03H
MOV 81H, A
MOV R0, #00H
LOOP:
    MOV A, 80H
    SUB A, 81H
    JC DONE
    MOV 80H, A
    ADD R0, #01H
    JMP LOOP
DONE:
    MOV A, R0
    MOV 82H, A
END:
    NOP
    JMP END
