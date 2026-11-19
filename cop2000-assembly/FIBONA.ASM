MOV R0, #05H    ; 计算前5项
MOV R1, #00H    ; F(0) = 0
MOV R2, #01H    ; F(1) = 1
LOOP:
    MOV A, R0        ; A = 当前迭代次数
    JZ END_LOOP      ; A=0时结束循环

    MOV A, R2        ; A = F(n-1)
    ADD A, R1        ; A = F(n-1) + F(n-2)
    MOV R3, A        ; 临时存F(n)到R3  tmp = pre + pre_pre

    MOV A, R2        ; 保存R2到A
    MOV R1, A        ; R1 = 旧R2      pre_pre = pre
    MOV A, R3        ; 恢复F(n)到A
    MOV R2, A        ; R2 = F(n)      pre = tmp

    MOV A, R0
    SUB A, #01H
    MOV R0, A

    JMP LOOP         ; 继续循环
END_LOOP:
    NOP
    JMP END_LOOP     ; 停机

