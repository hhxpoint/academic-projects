MOV A, 80H
    MOV R0, A    ; 【关键步】将原字符备份在 R0 中
    
    ; 1. 检查是否小于 'a' (61H)
    SUB A, #61H  
    JC  NO_CONV  ; 若借位，说明 ASCII码 < 61H，不是小写字母，直接跳走
    
    ; 2. 检查是否大于 'z' (7AH)
    MOV A, R0    ; 恢复原字符用于下一次比较
    SUB A, #7BH  ; 7BH 为 '{'，即 'z' 的下一个字符
    JC  CONVERT  ; 若借位，说明 ASCII码 < 7BH，说明确在 a-z 之间！执行转换
    JMP NO_CONV  ; 若没借位，说明 ASCII码 >= 7BH，不是小写字母
    
CONVERT:
    MOV A, R0    ; 恢复原字符
    SUB A, #20H  ; 减去 32 (20H)，转为大写
    JMP SAVE
    
NO_CONV:
    MOV A, R0    ; 不是小写，直接恢复原字符
SAVE:
    MOV 81H, A   ; 输出结果到 81H
DONE:
    NOP
    JMP DONE     ; 停机死循环
