MOV A, #20
ADD A, #80H
MOV 80H, A
MOV A, #-50
ADD A, #80H
MOV 81H, A
MOV A, #100
ADD A, #80H
MOV 82H, A
MOV A, #-10
ADD A, #80H
MOV 83H, A
MOV A, #77
ADD A, #80H
MOV 84H, A
MOV A, #-99
ADD A, #80H
MOV 85H, A
MOV A, #33
ADD A, #80H
MOV 86H, A
MOV A, #-66
ADD A, #80H
MOV 87H, A
MOV A, #88
ADD A, #80H
MOV 88H, A
MOV A, #-44
ADD A, #80H
MOV 89H, A
MOV R0, #80H
MOV R1, #89H
LOOP1:
    MOV A, R1
    SUB A, R0
    JZ LOOPRE

    MOV A, R0
    MOV R2, A
    ADD A, #01H
    MOV R3, A
LOOP2:
    MOV A, R1
    SUB A, R2
    JZ LOOP11

    MOV A, @R3
    SUB A, @R2
    JC LOOP3
LOOP22:
    ADD R2, #01H
    ADD R3, #01H
    JMP LOOP2
LOOP11:
    SUB R1, #01H
    JMP LOOP1
LOOP3:
    MOV A, @R2
    MOV 90H, A
    MOV A, @R3
    MOV @R2, A
    MOV A, 90H
    MOV @R3, A
    JMP LOOP22
LOOPRE:
    MOV R0, #80H
    MOV R1, #89H
LOOP4:
    MOV A, R1
    ADD A, #10H
    MOV R2, A

    MOV A, @R1
    SUB A, #80H
    MOV @R2, A

    MOV A, R1
    SUB A, R0
    JZ LOOPEND
    SUB R1, #01H
    JMP LOOP4
LOOPEND:
    NOP
    JMP LOOPEND
