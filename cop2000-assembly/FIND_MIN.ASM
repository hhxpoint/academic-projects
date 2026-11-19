MOV R0, #90H
MOV A, @R0
MOV R1, A
ADD R0, #01H
MOV R2, #07H
LOOP:
    MOV A, R2
    SUB A, #01H
    JC DONE
    JZ DONE
    MOV R2, A
    MOV A, @R0
    MOV R3, A
    SUB A, R1
    JC UPDATE
NEXT:
    ADD R0, #01H
    JMP LOOP
UPDATE:
    MOV A, R3
    MOV R1, A
    JMP NEXT
DONE:
    MOV A, R1
    MOV 80H, A
END:
    NOP
    JMP END
