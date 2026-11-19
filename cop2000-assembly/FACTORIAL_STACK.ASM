; ============================================================================
; FACTORIAL_STACK.ASM - Version D
; 栈模拟递归阶乘汇编程序 (Stack-Simulated Recursive Factorial)
;
; 功能: 用显式栈模拟递归方式计算 N!
;       (Compute N! using explicit stack to simulate recursion)
;
; 算法流程:
;   Phase 1: 初始化 (Initialization)
;            设置栈指针, 将 n, n-1, ..., 1 依次压入栈中
;   Phase 2: 出栈累乘 (Pop and multiply)
;            依次弹出栈中元素, 用移位加法乘法累乘得到阶乘结果
;
; 注意: 8位结果最大支持 5! = 120 (0x78), 6! = 720 溢出
;
; 输入: N = 5, 存于内存地址 80H
; 输出: N! 存于内存地址 81H
;
; 寄存器分配:
;   R0: 乘法累加器 / 乘数 (Multiplication accumulator / multiplier)
;   R1: 被乘数 / 移位被乘数 (Multiplicand / shifted multiplicand)
;   R2: 乘法结果 / 计数器 (Multiply result / counter)
;   R3: 栈指针 SP (Stack pointer, 栈区 B0H~B7H)
;
; 内存分配:
;   80H: 输入 N
;   81H: 输出 N!
;   B0H~B7H: 模拟栈区 (Simulated stack area)
; ============================================================================

; ============================================================================
; Phase 1: 初始化与压栈模块 (Init & Push Phase)
; 将 n, n-1, ..., 1 依次压入栈中, 模拟递归调用过程
; ============================================================================

    MOV A, #05H     ; N = 5
    MOV 80H, A      ; 存储 N 到 80H

    MOV R3, #B0H    ; 初始化栈指针 SP = B0H (栈底地址)
    MOV A, 80H      ; 加载 N 值
    MOV R2, A       ; R2 = N (当前待压入的值)

; --- 压栈循环 (Push Loop): 将 N, N-1, ..., 1 依次入栈 ---
PUSH_LOOP:
    MOV A, R2       ; 取当前值
    SUB A, #01H     ; 当前值 - 1 (判断是否为0)
    JC  POP_PHASE   ; 若当前值 < 1 (CF=1), 压栈结束, 跳转到出栈阶段
    JZ  POP_PHASE   ; 若当前值 == 0 (ZF=1), 压栈结束

    MOV A, R2       ; 重新加载当前值 (SUB 修改了 A)
    MOV @R3, A      ; 入栈: stack[SP] = value
    ADD R3, #01H    ; SP++ (栈指针上移)

    MOV A, R2       ; 取当前值
    SUB A, #01H     ; value = value - 1
    MOV R2, A       ; 更新当前值
    JMP PUSH_LOOP   ; 继续压栈

; ============================================================================
; Phase 2: 出栈累乘模块 (Pop & Multiply Phase)
; 依次弹出栈中元素, 与累乘结果相乘
; 乘法使用移位加法实现 (Shift-and-add multiplication)
; ============================================================================

POP_PHASE:
    MOV A, #01H     ; 初始化累乘结果 result = 1
    MOV R2, A       ; R2 = result (运行乘积)

; --- 出栈循环 (Pop Loop) ---
POP_LOOP:
    MOV A, R3       ; 取当前栈指针
    SUB A, #B0H     ; 计算 SP - 栈底地址 B0H
    JZ  FACT_DONE   ; 若 SP == B0H (栈空), 阶乘计算完成

    SUB R3, #01H    ; SP-- (栈指针下移)
    MOV A, @R3      ; 出栈: A = stack[SP] (弹出一个因子)

    ; --- 内联乘法: R2 = R2 * A (Inline multiply) ---
    MOV R0, A       ; R0 = multiplier (弹出的栈顶值)
    MOV R1, R2      ; R1 = multiplicand (当前累乘结果)
    MOV R2, #00H    ; R2 = 0 (清零乘积寄存器)

; --- 移位加法乘法子程序 (Shift-and-Add Multiplication) ---
;   逐位检查 R0 的最低位:
;     若为 1: R2 += R1
;     R0 >>= 1 (右移, 除以2)
;     R1 <<= 1 (左移, 乘以2)
MUL_LOOP:
    MOV A, R0       ; 取乘数 R0
    AND A, #FFH     ; 测试 R0 是否为 0 (AND 0xFF 更新 Z 标志)
    JZ  MUL_DONE    ; 若 R0 == 0, 乘法完成

    MOV A, R0       ; 取乘数 R0
    AND A, #01H     ; 检查 R0 的最低位
    JZ  MUL_SHIFT   ; 若最低位为 0, 跳过累加

; --- 最低位为 1: R0 >>= 1, R2 += R1, R1 <<= 1 ---
    MOV A, R0       ; 取 R0
    RR A            ; 右移一位 (最低位移出)
    MOV R0, A       ; 更新 R0

    MOV A, R2       ; 取当前乘积
    ADD A, R1       ; R2 += R1 (累加被乘数)
    MOV R2, A       ; 更新乘积

    MOV A, R1       ; 取被乘数
    RL A            ; 左移一位 (乘以2)
    MOV R1, A       ; 更新被乘数
    JMP MUL_LOOP    ; 处理下一位

; --- 最低位为 0: R0 >>= 1, R1 <<= 1 ---
MUL_SHIFT:
    MOV A, R0       ; 取 R0
    RR A            ; 右移一位
    MOV R0, A       ; 更新 R0

    MOV A, R1       ; 取被乘数
    RL A            ; 左移一位 (乘以2)
    MOV R1, A       ; 更新被乘数
    JMP MUL_LOOP    ; 处理下一位

; --- 乘法完成, 继续出栈循环 ---
MUL_DONE:
    JMP POP_LOOP    ; R2 中已保存乘积, 继续弹出下一个因子

; ============================================================================
; 存储结果 (Store Result)
; ============================================================================

FACT_DONE:
    MOV A, R2       ; 取最终阶乘结果
    MOV 81H, A      ; 存储 N! 到内存地址 81H

; ============================================================================
; 程序结束 (Program End)
; ============================================================================

LOOPEND:
    NOP             ; 空操作
    JMP LOOPEND     ; 死循环终止程序
