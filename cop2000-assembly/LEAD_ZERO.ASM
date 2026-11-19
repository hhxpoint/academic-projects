; 初始化：待检测数据 10H 存入80H单元，计数器R2清零
MOV A, #10H
MOV 80H, A
MOV R2, #00H

LOOP:
    ; 检测最高位：与80H（二进制10000000）按位与
    MOV A, 80H
    AND A, #80H
    JZ CONTINUE   ; 结果为0 → 最高位是0 → 跳转到循环处理
    JMP STORE     ; 结果非0 → 最高位是1 → 直接结束循环

CONTINUE:
    ; 最高位是0，左移一位
    MOV A, 80H
    RL A
    MOV 80H, A
    
    ; 计数器R2加1（通过累加器A中转，符合指令规则）
    MOV A, R2
    ADD A, #01H
    MOV R2, A
    
    ; 循环上限保护：最多执行8次，防止数据全0时死循环
    MOV A, R2
    SUB A, #08H
    JZ STORE
    
    JMP LOOP

STORE:
    ; 将最终前导零计数结果存入81H单元
    MOV A, R2
    MOV 81H, A
DONE:
    NOP
    JMP DONE
