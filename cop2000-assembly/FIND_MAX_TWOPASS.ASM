; ============================================================================
; FIND_MAX_TWOPASS.ASM - Version D
; 两趟扫描查找最大值汇编程序 (Two-Pass Scan for Maximum)
;
; 功能: 用两趟扫描在10个有符号8位数中查找最大值
;       (Find maximum of 10 signed 8-bit numbers using two-pass scan)
;
; 算法流程:
;   Phase 1: 数据输入与移码转换 (Data input & biased code conversion)
;            有符号数 -> 移码 (补码 + 80H), 存于 80H~89H
;   Phase 2: 第一趟扫描偶数下标 (Pass 1: scan even indices)
;            R0 从 80H 开始, 步长为 2, 扫描 80H, 82H, 84H, 86H, 88H
;   Phase 3: 第二趟扫描奇数下标 (Pass 2: scan odd indices)
;            R0 从 81H 开始, 步长为 2, 扫描 81H, 83H, 85H, 87H, 89H
;   Phase 4: 补码还原 (Convert max from biased code to two's complement)
;
; 测试数据: 100, -77, 42, 65, 17, -8, -32, 67, 4, 22
;
; 寄存器分配:
;   R0: 扫描指针 (Scan pointer)
;   R1: 当前趟的终止地址 (End boundary for current pass)
;   R2: 临时寄存器, 用于比较 (Temp for comparisons)
;
; 内存分配:
;   80H~89H: 移码数组 (Biased code array, 10 elements)
;   90H:     当前最大值 (Current maximum in biased code)
;   91H:     当前趟终止地址 (End address for current pass)
;   92H:     最大值-补码 (Maximum in two's complement)
; ============================================================================

; ============================================================================
; Phase 1: 数据输入模块 - 将10个有符号数转为移码并存入内存
; (Data Input Module - Convert signed numbers to biased code and store)
; ============================================================================

; --- 第1个数: 100 ---
    MOV A, #100     ; 将立即数100存入累加器A
    ADD A, #80H     ; 100 + 128 = 228 (0xE4), 转换为移码
    MOV 80H, A      ; 将移码0xE4存入内存地址80H

; --- 第2个数: -77 ---
    MOV A, #-77     ; -77 (补码: 0xB3)
    ADD A, #80H     ; 转换为移码: 0xB3 + 0x80 = 51 (0x33)
    MOV 81H, A      ; 存入81H

; --- 第3个数: 42 ---
    MOV A, #42      ; +42
    ADD A, #80H     ; 转换为移码: 42 + 128 = 170 (0xAA)
    MOV 82H, A      ; 存入82H

; --- 第4个数: 65 ---
    MOV A, #65      ; +65
    ADD A, #80H     ; 转换为移码: 65 + 128 = 193 (0xC1)
    MOV 83H, A      ; 存入83H

; --- 第5个数: 17 ---
    MOV A, #17      ; +17
    ADD A, #80H     ; 转换为移码: 17 + 128 = 145 (0x91)
    MOV 84H, A      ; 存入84H

; --- 第6个数: -8 ---
    MOV A, #-8      ; -8 (补码: 0xF8)
    ADD A, #80H     ; 转换为移码: 0xF8 + 0x80 = 0x78
    MOV 85H, A      ; 存入85H

; --- 第7个数: -32 ---
    MOV A, #-32     ; -32 (补码: 0xE0)
    ADD A, #80H     ; 转换为移码: 0xE0 + 0x80 = 0x60
    MOV 86H, A      ; 存入86H

; --- 第8个数: 67 ---
    MOV A, #67      ; +67
    ADD A, #80H     ; 转换为移码: 67 + 128 = 195 (0xC3)
    MOV 87H, A      ; 存入87H

; --- 第9个数: 4 ---
    MOV A, #4       ; +4
    ADD A, #80H     ; 转换为移码: 4 + 128 = 132 (0x84)
    MOV 88H, A      ; 存入88H

; --- 第10个数: 22 ---
    MOV A, #22      ; +22
    ADD A, #80H     ; 转换为移码: 22 + 128 = 150 (0x96)
    MOV 89H, A      ; 存入89H

; ============================================================================
; Phase 2: 第一趟扫描 - 偶数下标 (Pass 1: Even Indices)
; 扫描 80H, 82H, 84H, 86H, 88H, 步长为 2
; 终止地址: R1 = 8AH (88H 的下一个地址)
; ============================================================================

    MOV A, #8AH     ; 第一趟终止地址 (one past last even = 88H + 2)
    MOV 91H, A      ; 存储终止地址到 91H
    MOV R1, A       ; R1 = 8AH (用于循环边界比较)

    MOV R0, #80H    ; R0 = 80H (第一个偶数下标)
    MOV A, @R0      ; 取第一个元素 arr[80H] 作为初始最大值
    MOV 90H, A      ; 存入 90H 作为当前最大值

; --- 第一趟主循环 (Pass 1 Main Loop) ---
PASS1:
    MOV A, R0       ; 取当前扫描地址
    ADD A, #02H     ; 步长为 2: R0 = R0 + 2
    MOV R0, A       ; 更新扫描指针

    MOV A, R1       ; 取终止地址 8AH
    SUB A, R0       ; 计算 8AH - R0
    JZ  PASS2       ; 若 R0 == 8AH, 第一趟结束, 跳转到第二趟

    MOV A, @R0      ; 取当前元素 arr[R0]
    MOV R2, A       ; R2 = arr[R0] (暂存当前元素)
    MOV A, R2       ; 加载当前元素到 A
    SUB A, 90H      ; 比较: A = arr[R0] - 当前最大值
    JC  P1SKIP      ; 若 arr[R0] < 当前最大值 (CF=1), 跳过更新

    MOV A, R2       ; 重新加载当前元素 (SUB 修改了 A)
    MOV 90H, A      ; 更新最大值为 arr[R0]

P1SKIP:
    JMP PASS1       ; 继续第一趟扫描

; ============================================================================
; Phase 3: 第二趟扫描 - 奇数下标 (Pass 2: Odd Indices)
; 扫描 81H, 83H, 85H, 87H, 89H, 步长为 2
; 终止地址: R1 = 8BH (89H 的下一个地址)
; ============================================================================

PASS2:
    MOV A, #8BH     ; 第二趟终止地址 (one past last odd = 89H + 2)
    MOV 91H, A      ; 存储终止地址到 91H
    MOV R1, A       ; R1 = 8BH (用于循环边界比较)

    MOV R0, #81H    ; R0 = 81H (第一个奇数下标)

; --- 第二趟主循环 (Pass 2 Main Loop) ---
PASS2L:
    MOV A, R1       ; 取终止地址 8BH
    SUB A, R0       ; 计算 8BH - R0
    JZ  CONVERT     ; 若 R0 == 8BH, 第二趟结束, 跳转到补码还原

    MOV A, @R0      ; 取当前元素 arr[R0]
    MOV R2, A       ; R2 = arr[R0] (暂存当前元素)
    MOV A, R2       ; 加载当前元素到 A
    SUB A, 90H      ; 比较: A = arr[R0] - 当前最大值
    JC  P2SKIP      ; 若 arr[R0] < 当前最大值 (CF=1), 跳过更新

    MOV A, R2       ; 重新加载当前元素 (SUB 修改了 A)
    MOV 90H, A      ; 更新最大值为 arr[R0]

P2SKIP:
    MOV A, R0       ; 取当前地址
    ADD A, #02H     ; 步长为 2: R0 = R0 + 2
    MOV R0, A       ; 更新扫描指针
    JMP PASS2L      ; 继续第二趟扫描

; ============================================================================
; Phase 4: 补码还原模块 (Convert Maximum to Two's Complement)
; 将移码形式的最大值转换回补码, 存入 92H
; 转换公式: 补码 = 移码 - 80H
; ============================================================================

CONVERT:
    MOV A, 90H      ; 取最大值 (移码形式)
    SUB A, #80H     ; 移码转回补码 (移码 - 128 = 补码)
    MOV 92H, A      ; 将补码结果存入 92H

; ============================================================================
; 程序结束 (Program End)
; ============================================================================

LOOPEND:
    NOP             ; 空操作
    JMP LOOPEND     ; 死循环终止程序
