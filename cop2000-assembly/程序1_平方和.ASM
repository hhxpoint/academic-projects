;=========================================================
; 程序1: 求 1²+2²+3²+4²+5² = 1+4+9+16+25 = 55 = 0x37
;---------------------------------------------------------
; 算法: 平方 = 把 i 累加 i 次
;   外层 i 从 1 递增到 5
;   内层把 i 加到 sum 共 i 次 (即 i²)
; 寄存器分配:
;   R0 = i (当前底数, 1→5→6退出)
;   R1 = sum (总和, 贯穿全程)
;   R2 = count (内层计数 = i)
;   A  = 运算中转 (ADD/SUB 目的操作数)
;=========================================================

        ORG  00H
        MOV  A, #00H
        MOV  R1, A          ; R1 = sum = 0
        MOV  A, #01H
        MOV  R0, A          ; R0 = i = 1

OUTER:  MOV  A, R0
        MOV  R2, A          ; R2 = count = i

INNER:  MOV  A, R1          ; A = sum
        ADD  A, R0          ; A = sum + i
        MOV  R1, A          ; sum 更新

        MOV  A, R2          ; count--
        SUB  A, #01H
        MOV  R2, A
        JZ   END_INNER      ; count==0 结束内层
        JMP  INNER

END_INNER:
        MOV  A, R0          ; i++
        ADD  A, #01H
        MOV  R0, A
        SUB  A, #06H        ; i - 6
        JZ   DONE           ; i==6 退出
        JMP  OUTER

DONE:   MOV  A, R1          ; A = sum = 55 = 0x37
                     ; 输出 0x37
HALT:   JMP  HALT
        END
