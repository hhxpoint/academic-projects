; ============================================================================
; SELECTION_SORT.ASM - Version D
; 选择排序汇编程序 (Selection Sort Assembly Program)
;
; 功能: 对10个有符号8位数进行选择排序
;       (Sort 10 signed 8-bit numbers using selection sort)
;
; 算法流程:
;   Phase 1: 数据输入与移码转换 (Data input & biased code conversion)
;            有符号数 -> 移码 (补码 + 80H), 存于 80H~89H
;   Phase 2: 选择排序 (Selection sort on biased values)
;            每趟在未排序部分中找最小值, 与当前位置交换
;            利用移码的无符号特性, 用SUB+CF比较元素大小
;   Phase 3: 补码还原 (Convert biased code back to two's complement)
;            移码 - 80H = 补码, 结果存于 90H~99H
;
; 测试数据: 100, -77, 42, 65, 17, -8, -32, 67, 4, 22
;
; 寄存器分配:
;   R0: 外循环指针 i (Outer loop pointer, 80H to 88H)
;   R1: 最小值指针 minIndex (Pointer to current minimum)
;   R2: 内循环指针 j (Inner loop pointer)
;   R3: 临时寄存器, 用于 j+1 或边界值 (Temp for j+1 or boundary)
;
; 内存分配:
;   80H~89H: 移码数组 (Biased code array, 10 elements)
;   90H:     交换暂存单元 (Swap temporary storage)
;   91H:     外循环终止地址 (Outer loop end address = 89H)
;   92H:     内循环终止地址 (Inner loop end address = 8AH)
;   93H:     临时存储 (Temp storage for R0 during boundary check)
;   90H~99H: 排序结果-补码 (Sorted result in two's complement)
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
    MOV A, #-77     ; 将立即数-77存入累加器A (补码: 0xB3)
    ADD A, #80H     ; -77的补码(0xB3) + 128 = 51 (0x33), 转换为移码
    MOV 81H, A      ; 将移码0x33存入内存地址81H

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
    MOV A, #-8      ; -8 (补码形式: 0xF8)
    ADD A, #80H     ; 转换为移码: 0xF8 + 0x80 = 0x78
    MOV 85H, A      ; 存入85H

; --- 第7个数: -32 ---
    MOV A, #-32     ; -32 (补码形式: 0xE0)
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
; Phase 2: 选择排序模块 (Selection Sort Module)
; 对80H~89H中的移码进行升序排序
; 每趟在未排序部分(i+1~89H)中找最小值, 与位置i交换
; 利用移码的无符号数特性, 直接用SUB指令和借位标志CF比较大小
; ============================================================================

    MOV A, #89H     ; 外循环终止地址 (one past last i position)
    MOV 91H, A      ; 存储外循环边界到91H

    MOV R0, #80H    ; 外循环指针 i = 80H (数组起始地址)

; --- 外循环 (Outer Loop): i from 80H to 88H ---
OUTER:
    MOV A, 91H      ; 加载外循环终止地址 89H
    SUB A, R0       ; 计算 89H - i
    JZ  SORTDONE    ; 若 i == 89H, 排序完成 (i已遍历到88H的下一位)

    MOV R1, R0      ; minIndex = i (假定当前位置为最小值)
    MOV A, R0       ; 计算 j = i + 1
    ADD A, #01H     ; A = i + 1
    MOV R2, A       ; 内循环指针 j = i + 1

    MOV A, #8AH     ; 内循环终止地址 (one past array end = 89H + 1)
    MOV 92H, A      ; 存储内循环边界到92H

; --- 内循环 (Inner Loop): j from i+1 to 89H ---
INNER:
    MOV A, 92H      ; 加载内循环终止地址 8AH
    SUB A, R2       ; 计算 8AH - j
    JZ  SWAPCHK     ; 若 j == 8AH, 内循环结束, 跳转到交换检查

    MOV A, @R2      ; 取 arr[j] (当前扫描元素)
    SUB A, @R1      ; 比较: A = arr[j] - arr[minIndex]
    JC  UPDMIN      ; 若 arr[j] < arr[minIndex] (CF=1), 更新最小值指针

; --- 内循环尾部 (指针后移) ---
INNERCONT:
    MOV A, R2       ; 取当前 j 值
    ADD A, #01H     ; j = j + 1
    MOV R2, A       ; 更新 j 指针
    JMP INNER       ; 继续内循环

; --- 更新最小值指针 (Update minIndex) ---
UPDMIN:
    MOV R1, R2      ; minIndex = j (发现更小的元素)
    JMP INNERCONT   ; 继续内循环

; --- 交换检查 (Swap Check): 若 minIndex != i, 则交换 ---
SWAPCHK:
    MOV A, R1       ; 取 minIndex
    MOV 93H, A      ; 暂存 minIndex 到 93H
    MOV A, R0       ; 取 i
    SUB A, 93H      ; 计算 i - minIndex
    JZ  NOSWAP      ; 若 i == minIndex, 无需交换, 跳过

; --- 执行交换 (Perform Swap: arr[i] <-> arr[minIndex]) ---
    MOV A, @R0      ; 取 arr[i]
    MOV 90H, A      ; 暂存到交换单元 90H
    MOV A, @R1      ; 取 arr[minIndex]
    MOV @R0, A      ; arr[i] = arr[minIndex]
    MOV A, 90H      ; 取原 arr[i]
    MOV @R1, A      ; arr[minIndex] = 原 arr[i]

NOSWAP:
    MOV A, R0       ; 外循环指针 i 后移
    ADD A, #01H     ; i = i + 1
    MOV R0, A       ; 更新 i
    JMP OUTER       ; 继续外循环

; ============================================================================
; Phase 3: 补码还原模块 (Biased Code to Two's Complement Conversion)
; 将排序后的移码 (80H~89H) 转换回补码, 结果存入 90H~99H
; 转换公式: 补码 = 移码 - 80H (即减去偏移量128)
; ============================================================================

SORTDONE:
    MOV R0, #80H    ; 初始化源地址 (移码数组起始地址)
    MOV R1, #89H    ; 初始化循环终止地址 (移码数组结束地址)

; --- 转码循环 (Conversion Loop) ---
CONVERT:
    MOV A, R0       ; 取源地址
    ADD A, #10H     ; 计算目标地址: 源地址 + 10H (80H->90H, ...)
    MOV R2, A       ; R2 = 目标地址 (90H~99H)

    MOV A, @R0      ; 取当前地址的移码值
    SUB A, #80H     ; 移码转回补码 (移码 - 128 = 补码)
    MOV @R2, A      ; 将补码存入目标地址 (90H~99H)

    MOV A, R0       ; 取当前地址
    SUB A, R1       ; 计算 R0 - R1
    JZ  LOOPEND     ; 若 R0 == R1 (89H), 所有数据已转换, 跳转到结束

    ADD R0, #01H    ; 源地址加1, 处理下一个元素
    JMP CONVERT     ; 继续转换

; ============================================================================
; 程序结束 (Program End)
; ============================================================================

LOOPEND:
    NOP             ; 空操作
    JMP LOOPEND     ; 死循环终止程序
