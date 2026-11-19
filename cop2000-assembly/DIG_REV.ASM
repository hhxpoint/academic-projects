MOV A, 80H
    MOV R1, #00H
TENS_LOOP:
    SUB A, #10H
    JC GOT_ONES
    MOV R0, A
    MOV A, R1
    ADD A, #01H
    MOV R1, A
    MOV A, R0
    JMP TENS_LOOP
GOT_ONES:
    ADD A, #10H
    MOV R2, A
    MOV R0, #00H
    MOV R3, #10H
MUL_LOOP:
    MOV A, R0
    ADD A, R2
    MOV R0, A

    MOV A, R3
    SUB A, #01H
    MOV R3, A
    JZ DO_ADD
    JMP MUL_LOOP
DO_ADD:
    MOV A, R0
    ADD A, R1
    MOV 81H, A
END_R:
    NOP
    JMP END_R
