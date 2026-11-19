; ============= 初始化模块 =============
MOV A, #08H        ; 将底数 8 存入累加器 A
MOV 80H, A         ; 将 A 中的值存入主存地址 80H（作为底数）
MOV A, #02H        ; 将指数 2 存入累加器 A
MOV 81H, A         ; 将 A 中的值存入主存地址 81H（作为指数）
MOV R3, #01H       ; 将结果初始化为 1，R3 保存最终运算结果
; ============= 快速幂主循环 =============
LOOP1:                             ; 主循环开始
    MOV A, 81H                    ; 将主存地址 81H 的值送入累加器 A（当前指数）
    AND A, #255                   ; 判断 A 是否为 0（即指数是否为 0）
    JZ LOOPEND                    ; 如果指数为 0，直接跳转到结束

    MOV A, 81H                    ; 再次将主存地址 81H 的值送入 A
    AND A, #01H                   ; 判断最低位是否为 1（即指数奇偶性）
    JZ LOOP2                      ; 如果为 0（偶数），跳转至 LOOP2（不乘 ans）

    ; 当前指数为奇数 → ans *= pos
    MOV A, R3                     ; 将 R3 中的结果送入 A
    MOV R0, A                     ; 将 A 中的值送入寄存器 R0
    MOV R1, 80H                   ; 将主存地址 80H 的值送入 R1（当前底数）
    MOV R2, #00H                  ; 初始化 R2 寄存器用于存放乘法中间结果
; ============= 乘法子程序（R0 × R1 → R2） =============
LOOP6:                             ; 运算结果存放在 R2 中
    MOV A, R0
    AND A, #255
    JZ LOOP8                      ; 如果 R0 为 0，跳转至 LOOP8（乘法结束）

    MOV A, R1
    AND A, #255
    JZ LOOP8                      ; 如果 R1 为 0，跳转至 LOOP8（乘法结束）

    MOV A, R0
    AND A, #01H                   ; 检查 R0 最低位
    JZ LOOP7                      ; 最低位为 0，跳转至 LOOP7（不加）

    MOV A, R0
    RR A                          ; R0 右移一位
    MOV R0, A

    MOV A, R2
    ADD A, R1                     ; R2 += R1
    MOV R2, A

    MOV A, R1
    RL A                          ; R1 左移一位
    MOV R1, A

    JMP LOOP6                     ; 跳转回 LOOP6 继续运算
LOOP7:
    MOV A, R0
    RR A                          ; R0 右移一位
    MOV R0, A

    MOV A, R1
    RL A                          ; R1 左移一位
    MOV R1, A

    JMP LOOP6                     ; 跳转回 LOOP6 继续运算
LOOP8:
    MOV A, R2                     ; 将 R2 中的运算结果送入 A
    MOV R3, A                     ; 将 A 中的值送入 R3（更新结果）
    JMP LOOP2                     ; 跳转至 LOOP2（执行底数平方）
; ============= 底数平方处理 =============
LOOP11:                            ; 用于回跳
    MOV A, 81H                    ; 将主存地址 81H 的值送入 A（当前指数）
    RR A                          ; 将 A 右移一位（指数右移）
    MOV 81H, A                    ; 将更新后的指数写回主存地址 81H
    JMP LOOP1                     ; 返回主循环开始
LOOP2:                             ; 实现底数平方的过程
    MOV R2, #00H                  ; 初始化 R2 寄存器用于存放乘法中间结果
    MOV R0, 80H                   ; 将主存地址 80H 的值送入 R0（当前底数）
    MOV R1, 80H                   ; 同样将主存地址 80H 的值送入 R1（乘数与被乘数一致）
; ============= 平方乘法子程序（R0 × R1 → R2） =============
LOOP3:                             ; 运算结果存放在 R2 中
    MOV A, R0
    AND A, #255
    JZ LOOP5                      ; 如果 R0 为 0，跳转至 LOOP5（乘法结束）

    MOV A, R1
    AND A, #255
    JZ LOOP5                      ; 如果 R1 为 0，跳转至 LOOP5（乘法结束）

    MOV A, R0
    AND A, #01H                   ; 检查 R0 最低位
    JZ LOOP4                      ; 最低位为 0，跳转至 LOOP4（不加）

    MOV A, R0
    RR A                          ; R0 右移一位
    MOV R0, A

    MOV A, R2
    ADD A, R1                     ; R2 += R1
    MOV R2, A

    MOV A, R1
    RL A                          ; R1 左移一位
    MOV R1, A

    JMP LOOP3                     ; 跳转回 LOOP3 继续运算
LOOP4:
    MOV A, R0
    RR A                          ; R0 右移一位
    MOV R0, A

    MOV A, R1
    RL A                          ; R1 左移一位
    MOV R1, A

    JMP LOOP3                     ; 跳转回 LOOP3 继续运算
LOOP5:                             ; 乘法结束
    MOV 80H, R2                   ; 将 R2 中的运算结果送入主存地址 80H（更新底数）
    JMP LOOP11                    ; 跳转回主循环结尾
; ============= 程序结束 =============
LOOPEND:
    NOP
    JMP LOOPEND                   ; 添加死循环终止程序

