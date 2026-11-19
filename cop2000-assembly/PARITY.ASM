MOV A, #0B3H
MOV 80H, A
MOV R0, #00H
P_LOOP:
    MOV A, 80H
    AND A, #255
    JZ P_DONE
    MOV A, 80H
    SUB A, #01H
    MOV R1, A
    MOV A, 80H
    AND A, R1
    MOV 80H, A
    ADD R0, #01H
    JMP P_LOOP
P_DONE:
    MOV A, R0
    RR A
    JC P_ODD
    MOV A, #00H
    JMP P_END
P_ODD:
    MOV A, #01H
P_END:
    MOV 81H, A
END_PAR:
    NOP
    JMP END_PAR
