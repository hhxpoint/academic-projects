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
OUTER:
    MOV A, R0
    SUB A, #89H
    JZ RESTORE
    MOV A, R0
    MOV R1, A
    ADD R0, #01H
    MOV A, R0
    MOV R2, A
    SUB R0, #01H
INNER:
    MOV A, R2
    SUB A, #8AH
    JZ SWAPCHK
    MOV A, @R2
    SUB A, @R1
    JC NOUPD
    MOV A, R2
    MOV R1, A
NOUPD:
    ADD R2, #01H
    JMP INNER
SWAPCHK:
    MOV A, R1
    SUB A, R0
    JZ NOSWAP
    MOV A, @R0
    MOV 90H, A
    MOV A, @R1
    MOV @R0, A
    MOV A, 90H
    MOV @R1, A
NOSWAP:
    ADD R0, #01H
    JMP OUTER
RESTORE:
    MOV R0, #80H
    MOV R1, #89H
RLOOP:
    MOV A, R0
    ADD A, #10H
    MOV R2, A
    MOV A, @R0
    SUB A, #80H
    MOV @R2, A
    MOV A, R0
    SUB A, R1
    JZ DONE
    ADD R0, #01H
    JMP RLOOP
DONE:
    NOP
    JMP DONE
