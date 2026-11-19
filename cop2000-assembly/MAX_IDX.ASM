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
MOV A, R0
MOV R1, A
ADD R0, #01H
SCAN:
    MOV A, R0
    SUB A, #8AH
    JZ OUTPUT
    MOV A, @R0
    MOV R2, A
    MOV A, R2
    SUB A, @R1
    JC NEXT
    MOV A, R0
    MOV R1, A
NEXT:
    ADD R0, #01H
    JMP SCAN
OUTPUT:
    MOV A, @R1
    MOV 90H, A
    SUB A, #80H
    MOV 91H, A
DONE:
    NOP
    JMP DONE
