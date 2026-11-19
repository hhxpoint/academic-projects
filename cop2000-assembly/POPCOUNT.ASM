; ============= 初始化 =============
MOV R3, #00H
MOV R0, 80H
; ============= 主循环 =============
COUNT_LOOP:
    MOV A, R0
    AND A, #255
    JZ COUNT_END

    MOV A, R0
    AND A, #01H
    JZ COUNT_SHIFT

    MOV A, R3
    ADD A, #01H
    MOV R3, A
COUNT_SHIFT:
    MOV A, R0
    RR A
    MOV R0, A
    JMP COUNT_LOOP
; ============= 结束 =============
COUNT_END:
    NOP
    JMP COUNT_END
