    MOV A,80H
    SUB A,#61H
    JC NO_CONV
    MOV A,80H
    SUB A,#7BH
    JC CONVERT
    JMP NO_CONV
CONVERT:
    MOV A,80H
    SUB A,#20H
    MOV 81H,A
    JMP END
NO_CONV:
    MOV A,80H
    MOV 81H,A
END:
    NOP
    JMP END
