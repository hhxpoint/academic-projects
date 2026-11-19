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
    ; 原直接寻址写法：MOV 81H, A
    ; 替换为寄存器间接寻址写法
    MOV R0, #81H   ; 把目标地址81H存入指针寄存器R0
    MOV @R0, A     ; 通过R0间接寻址，将A的值写入81H内存单元
END_R:
    NOP
