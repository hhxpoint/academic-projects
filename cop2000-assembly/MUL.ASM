MOV R0, #06H    ; 存放乘数a（6 → 0110）
MOV R1, #02H    ; 存放乘数b（2 → 0010）
MOV R2, #00H    ; 存放乘法结果（初始为0）
LOOP1:
 MOV A, R0        ; 将R0中的数送到A（检测乘数是否为0）
 AND A, #255      ; 判断A是否为0（设置零标志Z）
 JZ LOOP4         ; 若R0=0，直接跳转到结束（结果为0）

 MOV A, R1        ; 将R1中的数送到A（检测被乘数是否为0）
 AND A, #255      ; 判断A是否为0（设置零标志Z）
 JZ LOOP4         ; 若R1=0，直接跳转到结束（结果为0）

 MOV A, R0        ; 将R0中的数送到A（检测最低位LSB）
 AND A, #01H      ; 提取A的最低位（LSB）
 JZ LOOP2         ; 若LSB=0，跳转到LOOP2（仅移位，不累加）

 ; LSB=1时的处理：右移乘数 + 累加被乘数 + 左移被乘数
 MOV A, R0
 RR A             ; 乘数R0右移1位（逻辑右移，丢弃LSB）
 MOV R0, A

 MOV A, R2
 ADD A, R1        ; 结果R2 += 当前被乘数R1（累加操作）
 MOV R2, A

 MOV A, R1
 RL A             ; 被乘数R1左移1位（逻辑左移，位权放大×2）
 MOV R1, A

 JMP LOOP1        ; 返回循环开始，处理下一位

LOOP2:           ; LSB=0时的处理：仅移位，不累加
 MOV A, R0
 RR A             ; 乘数R0右移1位
 MOV R0, A

 MOV A, R1
 RL A             ; 被乘数R1左移1位
 MOV R1, A

 JMP LOOP1        ; 返回循环开始，处理下一位

LOOP3:
 JMP LOOP3        ; 死循环（程序终止）

LOOP4:           ; 结束标签
 END              ; 程序结束
