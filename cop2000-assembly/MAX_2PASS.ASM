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
MOV A, #8AH
MOV 91H, A
MOV R1, A
MOV R0, #80H
MOV A, @R0
MOV 90H, A
P1:
    MOV A, R0
    ADD A, #02H
    MOV R0, A
    MOV A, R1
    SUB A, R0
    JZ P2
    MOV A, @R0
    MOV R2, A
    MOV A, R2
    SUB A, 90H
    JC P1
    MOV A, R2
    MOV 90H, A
    JMP P1
P2:
    MOV A, #8BH
    MOV 91H, A
    MOV R1, A
    MOV R0, #81H
P2L:
    MOV A, R1
    SUB A, R0
    JZ OUTPUT
    MOV A, @R0
    MOV R2, A
    MOV A, R2
    SUB A, 90H
    JC P2NX
    MOV A, R2
    MOV 90H, A
P2NX:
    MOV A, R0
    ADD A, #02H
    MOV R0, A
    JMP P2L
OUTPUT:
    MOV A, 90H
    SUB A, #80H
    MOV 92H, A
DONE:
    NOP
    JMP DONE
