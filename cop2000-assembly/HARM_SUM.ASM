    MOV A,80H
    MOV R0,A
    MOV A,80H
    MOV R1,#00H
DIV2:
    SUB A,#02H
    JC D2DONE
    ADD R1,#01H
    JZ D2DONE
    MOV R2,A
    SUB A,#01H
    JZ D2DONE
    MOV R2,A
    JMP DIV2
D2DONE:
    MOV A,R0
    ADD A,R1
    MOV R0,A
    MOV A,80H
    MOV R1,#00H
DIV3:
    SUB A,#03H
    JC D3DONE
    ADD R1,#01H
    JZ D3DONE
    MOV R2,A
    SUB A,#01H
    JZ D3DONE
    MOV R2,A
    JMP DIV3
D3DONE:
    MOV A,R0
    ADD A,R1
    MOV 81H,A
    NOP
    JMP $
