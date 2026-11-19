; ============= 插入排序（Insertion Sort - 交换法）=============
; 功能：对内存80H~89H的10个有符号数进行升序排序
; 使用移码表示法（补码+128）进行有符号数大小比较
; 算法：逐个取出元素，与已排序部分从后往前比较并交换到正确位置
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
; ============= 插入排序模块 =============
; R0：外循环指针i（从81H到89H）
; R1：内循环指针j（从i向前移动，通过交换将元素放到正确位置）
MOV R0, #81H    ; i=81H（从第2个元素开始）
OUTER:
    MOV A, R0       ; 判断i是否超出89H
    SUB A, #89H
    JC DO_INSERT    ; i<89H，执行插入
    JZ DO_INSERT    ; i=89H，最后一个元素也要插入
    JMP CONVERT     ; i>89H，排序完成
DO_INSERT:
    MOV R1, R0      ; j=i
INNER:
    MOV A, R1       ; 判断j是否到达数组首部
    SUB A, #80H
    JC EXIT_INNER   ; j<80H（回绕），已到数组前面，停止
    JZ EXIT_INNER   ; j=80H，无法再向前比较

    MOV A, R1       ; 计算j-1
    SUB A, #01H
    MOV R2, A       ; R2=j-1

    MOV A, @R1      ; 取arr[j]（当前插入元素）
    MOV R3, A       ; 暂存arr[j]到R3

    MOV A, R3       ; 恢复arr[j]
    SUB A, @R2      ; arr[j] - arr[j-1]
    JC EXIT_INNER   ; arr[j] < arr[j-1]（借位），已找到正确位置

    ; arr[j] >= arr[j-1]，交换两者
    MOV A, @R1      ; 取arr[j]
    MOV 90H, A      ; 暂存到90H
    MOV A, @R2      ; 取arr[j-1]
    MOV @R1, A      ; arr[j] = arr[j-1]
    MOV A, 90H      ; 取暂存的arr[j]
    MOV @R2, A      ; arr[j-1] = 原arr[j]

    SUB R1, #01H    ; j--（向前继续比较）
    JMP INNER       ; 继续内循环
EXIT_INNER:
    ADD R0, #01H    ; i++（处理下一个元素）
    JMP OUTER       ; 继续外循环
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
