; ============= main 入口 =============
MOV R0, #30H    ; R0 = 48（0x30）
MOV R1, #12H    ; R1 = 18（0x12）
CALL GCD        ; 调用 GCD 函数
; 结果存于 R0
; 无限循环结束
JMP $
; ============= 递归实现 GCD =============
GCD:
    ; 保存 R0-R1 到栈
    MOV A, R0
    MOV @R3, A
    MOV A, R3
    ADD A, #01H
    MOV R3, A

    MOV A, R1
    MOV @R3, A
    MOV A, R3
    ADD A, #01H
    MOV R3, A

    ; 判断 R1 == 0 ?
    MOV A, R1
    JC BASE_CASE

    ; 计算 R0 % R1
    ; 保存 R1 到 R2
    MOV A, R1
    MOV R2, A

    ; 计算 R0 % R1（通过减法循环）
MOD_LOOP:
    MOV A, R0
    SUB A, R2
    JC MOD_DONE
    MOV R0, A
    JMP MOD_LOOP
MOD_DONE:
    ; 保存余数到 R2
    MOV A, R0
    MOV R2, A

    ; 更新 R0 = R1
    MOV A, R1
    MOV R0, A

    ; 更新 R1 = R2（a % b）
    MOV A, R2
    MOV R1, A

    ; 递归调用 GCD(b, a % b)
    CALL GCD

    ; 返回后无需恢复 R0-R1（由递归调用栈处理）
    ; 跳转到返回点
    JMP RET_GCD
BASE_CASE:
    ; 恢复 R1
    MOV A, R3
    SUB A, #01H
    MOV R3, A
    MOV A, @R3
    MOV R1, A

    ; 恢复 R0
    MOV A, R3
    SUB A, #01H
    MOV R3, A
    MOV A, @R3
    MOV R0, A
RET_GCD:
    RET


