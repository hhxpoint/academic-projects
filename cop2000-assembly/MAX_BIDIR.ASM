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
MOV A, @R0
MOV 90H, A
LOOP1:
    MOV A, R0
    SUB A, R1
    JC CMPAIR
    JZ OUTPUT
    JMP OUTPUT
CMPAIR:
    MOV A, @R0
    MOV R2, A
    MOV A, R2
    SUB A, @R1
    JC RBIG
    MOV A, R2
    MOV R3, A
    MOV A, R3
    SUB A, 90H
    JC SKIP1
    MOV A, R2
    MOV 90H, A
    JMP ADV
RBIG:
    MOV A, @R1
    MOV R2, A
    MOV A, R2
    SUB A, 90H
    JC ADV
    MOV A, R2
    MOV 90H, A
SKIP1:
    NOP
ADV:
    ADD R0, #01H
    SUB R1, #01H
    JMP LOOP1
OUTPUT:
    MOV A, 90H
    SUB A, #80H
    MOV 91H, A
DONE:
    NOP
    JMP DONE
