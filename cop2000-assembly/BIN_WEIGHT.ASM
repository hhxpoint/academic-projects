MOV A, 80H
    MOV R0, A    ; R0 用来暂存当前正在处理的数字
    MOV R1, #00H ; R1 用来当计数器，记录 '1' 的个数，初始化为0

BW_LOOP:
    ; --- 1. 安全判定 R0 是否已经变为 0 ---
    MOV A, R0
    ADD A, #00H  ; 【神级补丁】强制让 A 过一次 ALU，这样才能刷新硬件的 Z 标志！
    JZ BW_CLASS  ; 如果此时 A 是 0 (说明所有的 1 都被扣光了)，跳到分类阶段
    
    ; --- 2. 核心算法：消除最低位的一个 1 (n & n-1) ---
    SUB A, #01H  ; 此时 A 里面是 R0 的值，A = n - 1
    MOV R2, A    ; R2 暂存 (n - 1)
    MOV A, R0    ; A 重新拿回 n
    AND A, R2    ; A = n AND (n - 1) -> 这个位运算能神奇地消掉最低位的一个 1
    MOV R0, A    ; 把消掉一个 1 后的新数字存回 R0
    
    ; --- 3. 计数器安全 +1 ---
    MOV A, R1    ; 把计数器请进 A
    ADD A, #01H  ; 计数器 +1
    MOV R1, A    ; 把计数器存回 R1
    JMP BW_LOOP  ; 继续循环找下一个 1

BW_CLASS:
    ; 此时，R1 里已经完美记录了 80H 中 '1' 的个数。
    ; 分类规则： 0~2个(轻, 亮1)；3~5个(中, 亮2)；6~8个(重, 亮3)
    
    MOV A, R1    ; 把个数放入 A 准备分类
    SUB A, #03H  ; 减去 3
    JC LIGHT     ; 如果产生借位 (说明个数是 0, 1, 2)，跳到轻级别
    
    SUB A, #03H  ; 刚才已经减了3，现在再减3 (相当于总共减了6)
    JC MEDIUM    ; 如果产生借位 (说明个数是 3, 4, 5)，跳到中级别

HEAVY:
    ; 如果两次减3都不借位，说明个数 >= 6，属于重级别
    MOV A, #03H  
    MOV 81H, A   ; 输出 03 到地址 81H
    JMP END_B

LIGHT:
    MOV A, #01H
    MOV 81H, A   ; 输出 01 到地址 81H
    JMP END_B

MEDIUM:
    MOV A, #02H
    MOV 81H, A   ; 输出 02 到地址 81H

END_B:
    NOP
    JMP END_B    ; 停机
