; ============= 奇偶交换排序（Odd-Even Transposition Sort）=============
; 功能：对内存80H~89H的10个有符号数进行升序排序
; 使用移码表示法（补码+128）进行有符号数大小比较
; 算法：交替执行奇数阶段和偶数阶段的相邻比较交换
; ============= 初始化模块：数据转移码 =============
MOV A, #100     ; +100
ADD A, #80H     ; 转移码：228(0xE4)
MOV 80H, A
MOV A, #-77     ; -77
ADD A, #80H     ; 转移码：51(0x33)
MOV 81H, A
MOV A, #42      ; +42
ADD A, #80H     ; 转移码：170(0xAA)
MOV 82H, A
MOV A, #65      ; +65
ADD A, #80H     ; 转移码：193(0xC1)
MOV 83H, A
MOV A, #17      ; +17
ADD A, #80H     ; 转移码：145(0x91)
MOV 84H, A
MOV A, #-8      ; -8
ADD A, #80H     ; 转移码：120(0x78)
MOV 85H, A
MOV A, #-32     ; -32
ADD A, #80H     ; 转移码：96(0x60)
MOV 86H, A
MOV A, #67      ; +67
ADD A, #80H     ; 转移码：195(0xC3)
MOV 87H, A
MOV A, #4       ; +4
ADD A, #80H     ; 转移码：132(0x84)
MOV 88H, A
MOV A, #22      ; +22
ADD A, #80H     ; 转移码：150(0x96)
MOV 89H, A
; ============= 奇偶交换排序模块 =============
; R0：外循环计数器（n=10趟，保证完全排序）
; R1：内循环指针（奇数阶段从81H开始，偶数阶段从80H开始）
MOV R0, #0AH    ; 外循环计数=10（需要n趟）
PASS_START:
    MOV A, R0       ; 判断是否完成所有趟
    AND A, #255
    JZ CONVERT      ; R0=0，排序完成

    ; ===== 奇数阶段：比较(81H,82H), (83H,84H), ..., (87H,88H) =====
    MOV R1, #81H    ; 奇数阶段从地址81H开始
ODD_LOOP:
    MOV A, R1       ; 判断R1是否超出范围
    SUB A, #89H
    JC DO_ODD       ; R1<89H，继续比较
    JZ DO_ODD       ; R1=89H，也要比较(89H,8AH不存在，跳过)
    JMP EVEN_START  ; R1>89H，奇数阶段结束

DO_ODD:
    MOV A, R1       ; 计算R1+1
    ADD A, #01H
    MOV R2, A       ; R2=R1+1

    MOV A, R2       ; 检查R1+1是否超出89H
    SUB A, #89H
    JC ODD_COMPARE  ; R2<89H，可以比较
    JZ ODD_COMPARE  ; R2=89H，可以比较
    JMP EVEN_START  ; R2>89H，跳过

ODD_COMPARE:
    MOV A, @R1      ; 取arr[R1]
    MOV R3, A       ; 暂存
    MOV A, R3       ; 恢复arr[R1]
    SUB A, @R2      ; arr[R1] - arr[R1+1]
    JC ODD_NEXT     ; arr[R1] < arr[R1+1]，不交换

    ; 交换arr[R1]和arr[R1+1]
    MOV A, @R2      ; 取arr[R1+1]
    MOV 90H, A      ; 暂存
    MOV A, R3       ; 取arr[R1]
    MOV @R2, A      ; arr[R1+1] = arr[R1]
    MOV A, 90H      ; 取暂存值
    MOV @R1, A      ; arr[R1] = 原arr[R1+1]
ODD_NEXT:
    ADD R1, #02H    ; 步进2（下一对奇数位置）
    JMP ODD_LOOP    ; 继续奇数阶段

    ; ===== 偶数阶段：比较(80H,81H), (82H,83H), ..., (88H,89H) =====
EVEN_START:
    MOV R1, #80H    ; 偶数阶段从地址80H开始
EVEN_LOOP:
    MOV A, R1       ; 判断R1是否超出范围
    SUB A, #89H
    JC DO_EVEN      ; R1<89H，继续比较
    JMP PASS_DONE    ; R1>=89H，偶数阶段结束

DO_EVEN:
    MOV A, R1       ; 计算R1+1
    ADD A, #01H
    MOV R2, A       ; R2=R1+1

    MOV A, R2       ; 检查R1+1是否超出89H
    SUB A, #89H
    JC EVEN_COMPARE ; R2<89H，可以比较
    JZ EVEN_COMPARE ; R2=89H，可以比较
    JMP PASS_DONE   ; R2>89H，跳过

EVEN_COMPARE:
    MOV A, @R1      ; 取arr[R1]
    MOV R3, A       ; 暂存
    MOV A, R3       ; 恢复arr[R1]
    SUB A, @R2      ; arr[R1] - arr[R1+1]
    JC EVEN_NEXT    ; arr[R1] < arr[R1+1]，不交换

    ; 交换arr[R1]和arr[R1+1]
    MOV A, @R2      ; 取arr[R1+1]
    MOV 90H, A      ; 暂存
    MOV A, R3       ; 取arr[R1]
    MOV @R2, A      ; arr[R1+1] = arr[R1]
    MOV A, 90H      ; 取暂存值
    MOV @R1, A      ; arr[R1] = 原arr[R1+1]
EVEN_NEXT:
    ADD R1, #02H    ; 步进2（下一对偶数位置）
    JMP EVEN_LOOP   ; 继续偶数阶段

PASS_DONE:
    SUB R0, #01H    ; 外循环计数减1
    JMP PASS_START  ; 开始下一趟
; ============= 补码还原模块 =============
CONVERT:
    MOV R0, #80H    ; 数组起始地址
    MOV R1, #89H    ; 数组结束地址
CONV_LOOP:
    MOV A, @R1      ; 取移码值
    SUB A, #80H     ; 移码转补码（减128）
    MOV R2, A       ; 暂存补码值
    MOV A, R1       ; 取源地址
    ADD A, #10H     ; 目标地址=源地址+16
    MOV R3, A       ; R3为目标地址
    MOV A, R2       ; 取补码值
    MOV @R3, A      ; 存入目标地址
    MOV A, R1
    SUB A, R0       ; R1-R0
    JZ DONE         ; 全部转换完成
    SUB R1, #01H
    JMP CONV_LOOP
DONE:
    NOP
    JMP DONE        ; 死循环结束程序
