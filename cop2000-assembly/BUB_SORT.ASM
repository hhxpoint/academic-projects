MOV A, #100
ADD A, #80H
MOV 80H, A
MOV A, #-77
ADD A, #80H
MOV 81H, A
MOV A, #42
ADD A, #80H
MOV 82H, A
MOV A, #65
ADD A, #80H
MOV 83H, A
MOV A, #17
ADD A, #80H
MOV 84H, A
MOV A, #-8
ADD A, #80H
MOV 85H, A
MOV A, #-32
ADD A, #80H
MOV 86H, A
MOV A, #67
ADD A, #80H
MOV 87H, A
MOV A, #4
ADD A, #80H
MOV 88H, A
MOV A, #22
ADD A, #80H
MOV 89H, A
MOV R0, #80H
MOV R1, #89H
OUTER:
    MOV A, R1
    SUB A, R0
    JZ RESTORE
    MOV A, R0
    MOV R2, A
    ADD A, #01H
    MOV R3, A
INNER:
    MOV A, R1
    SUB A, R2
    JZ OUTEREND
    MOV A, @R3
    SUB A, @R2
    JC NOSWAP
    MOV A, @R2
    MOV 90H, A
    MOV A, @R3
    MOV @R2, A
    MOV A, 90H
    MOV @R3, A
NOSWAP:
    ADD R2, #01H
    ADD R3, #01H
    JMP INNER
OUTEREND:
    SUB R1, #01H
    JMP OUTER
RESTORE:
    MOV R0, #80H
    MOV R1, #89H
RLOOP:
    MOV A, R1
    ADD A, #10H
    MOV R2, A
    MOV A, @R1
    SUB A, #80H
    MOV @R2, A
    MOV A, R1
    SUB A, R0
    JZ DONE
    SUB R1, #01H
    JMP RLOOP
DONE:
    NOP
    JMP DONE
