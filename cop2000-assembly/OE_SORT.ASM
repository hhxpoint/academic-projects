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
MOV R0, #0AH
PASS:
    MOV A, R0
    AND A, #255
    JZ RESTORE
    MOV R1, #81H
ODD:
    MOV A, R1
    SUB A, #89H
    JC ODDOK
    JZ ODDOK
    JMP EVEN
ODDOK:
    MOV A, R1
    ADD A, #01H
    MOV R2, A
    MOV A, R2
    SUB A, #89H
    JC ODDCMP
    JZ ODDCMP
    JMP EVEN
ODDCMP:
    MOV A, @R1
    MOV R3, A
    MOV A, R3
    SUB A, @R2
    JC ODDNX
    MOV A, @R2
    MOV 90H, A
    MOV A, R3
    MOV @R2, A
    MOV A, 90H
    MOV @R1, A
ODDNX:
    ADD R1, #02H
    JMP ODD
EVEN:
    MOV R1, #80H
EVLP:
    MOV A, R1
    SUB A, #89H
    JC EVEOK
    JMP PASSDONE
EVEOK:
    MOV A, R1
    ADD A, #01H
    MOV R2, A
    MOV A, R2
    SUB A, #89H
    JC EVCMP
    JZ EVCMP
    JMP PASSDONE
EVCMP:
    MOV A, @R1
    MOV R3, A
    MOV A, R3
    SUB A, @R2
    JC EVNX
    MOV A, @R2
    MOV 90H, A
    MOV A, R3
    MOV @R2, A
    MOV A, 90H
    MOV @R1, A
EVNX:
    ADD R1, #02H
    JMP EVLP
PASSDONE:
    SUB R0, #01H
    JMP PASS
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
