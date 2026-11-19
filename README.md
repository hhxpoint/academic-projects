# 汇编语言与 C++ 课程练习

> 本科阶段的 **8086 汇编语言实验**（Cop2000 仿真器）与 **Visual C++ 控制台练习**归档。每个 `.ASM` 文件都可独立汇编、单步调试，适合作为汇编入门/课程设计参考。

![Assembly](https://img.shields.io/badge/Assembly-8086-6E4C1E)
![C++](https://img.shields.io/badge/C%2B%2B-Console-00599C?logo=cplusplus&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-2F6B5F)

---

## 目录结构

```text
academic-projects/
├── cop2000-assembly/        # 8086 汇编实验（.ASM 源码 + .LST 汇编清单）
│   ├── 3AVG-5.ASM
│   ├── ABS_VAL.ASM
│   ├── BUB_SORT.ASM
│   ├── CAESAR.ASM
│   ├── FIBONA.ASM
│   ├── GCD.ASM
│   ├── JOSEPHUS.ASM
│   ├── PASCAL.ASM
│   ├── PRIME.ASM
│   └── ...
├── cpp-console/             # Visual C++ 控制台项目
│   ├── ConsoleApplication1/ # Hello World 入门
│   └── test1/               # BFS 多源感染扩散
└── README.md
```

---

## 一、8086 汇编实验

### 运行环境

- Windows
- **Cop2000 微机原理与接口技术仿真器**（实验课配套软件，仓库不包含该商业软件）
- 或任意 8086 汇编器/仿真器（MASM/TASM + DOSBox）

### 使用方式

1. 打开 Cop2000 仿真器
2. 新建/打开实验，导入 `cop2000-assembly/*.ASM`
3. 汇编、链接、装载
4. 单步/连续运行，观察寄存器、内存、标志位
5. `.LST` 为汇编清单，可用于对照机器码与地址

> 不同实验对内存地址、端口、中断的约定可能不同；请按课程实验指导书调整。

### 实验索引（节选）

| 类别 | 文件 |
|---|---|
| 算术/平均 | `3AVG-5.ASM`、`ABS_VAL.ASM`、`AVG_THREE.ASM`、`CUM_SUM.ASM`、`DIV_MOD.ASM`、`EXPONENTIATION.ASM`、`FACTORIAL.ASM`、`FASTMUL.ASM` |
| 数组/排序 | `ARR_MIN.ASM`、`ARR_SUM.ASM`、`BUB_SORT.ASM`、`INSERTION_SORT.ASM`、`SELECTION_SORT.ASM`、`ODD_EVEN_SORT.ASM`、`MAX_SCAN.ASM`、`FIND_MIN.ASM` |
| 数论 | `GCD.ASM`、`LCM_CALC.ASM`、`IS_PRIME.ASM`、`PERF_NUM.ASM`、`COLLATZ.ASM`、`FIBONA.ASM`、`PASCAL.ASM`、`JOSEPHUS.ASM` |
| 位运算 | `BIT_REV.ASM`、`BIT_AND_CNT.ASM`、`POPCNT.ASM`、`GRAY_CODE.ASM`、`HAM_WT.ASM`、`XOR_SWAP.ASM`、`LEAD_ZERO.ASM` |
| 字符串/编码 | `CAESAR.ASM`、`CASE_CVT.ASM`、`TO_UPPER.ASM`、`DIG_REV.ASM` |
| 接口实验 | `EX8253.ASM`、`EX8255.ASM`（8253/8255 可编程接口芯片） |
| 综合 | `程序1_平方和.ASM`、`程序2_累加和.ASM`、`NEW_INST.ASM` |

> 同名 `(1)`、`(2)` 为不同版本/迭代；`.BAK/.BIN` 未纳入仓库。

---

## 二、C++ 控制台项目

### 环境

- Visual Studio 2022（`v143` 工具集）
- 或任意支持 C++17 的编译器

### 项目

| 项目 | 说明 |
|---|---|
| `ConsoleApplication1` | Visual C++ 入门 Hello World |
| `test1` | 多源 BFS：网格中多个感染源同时扩散，求每个格子的最短感染时间 |

运行：

1. 用 Visual Studio 打开对应 `.sln`
2. 选择 `x64 / Debug` 或 `Release`
3. F5 运行；`test1` 按提示输入网格与感染源

> 仓库只保留源码与工程文件，不包含 `x64/Debug` 编译产物。

---

## 测试与验证

- 汇编：在 Cop2000/MASM 中逐个汇编，检查 `.LST` 无错误，运行结果与实验指导书一致
- C++：Visual Studio 编译运行；`test1` 用样例网格验证 BFS 距离
- 仓库文件完整性检查：

```powershell
# 汇编源码数量
(Get-ChildItem cop2000-assembly -Filter *.ASM).Count
# C++ 工程
Get-ChildItem cpp-console -Recurse -Filter *.sln
```

---

## 说明

- 本仓库为课程练习归档，代码风格与解题方式保持当时状态，未做大规模重构。
- 仓库不包含 Cop2000 商业软件、课程 PDF、可执行文件与编译产物。
- 如需运行汇编实验，请自行准备课程配套仿真器。

---

## License

MIT License，详见 [LICENSE](LICENSE)。


---

## 子项目

| 目录 | 内容 |
|---|---|
| `assembly/` | 8086 汇编实验：MASM/TASM 源码、LST 清单、运行说明 |
| `cpp/` | C++ 控制台课程设计：链表、文件、面向对象练习 |
| `docs/` | 实验报告与截图（已脱敏） |

## 运行环境

- 汇编：DOSBox + MASM/TASM（或 Cop2000 仿真器）
- C++：Visual Studio / g++（C++11+）

## 说明

- 原始 Cop2000 商业仿真器、PDF 未纳入仓库；
- 报告中的姓名/学号已移除；
- 每个子目录均有独立 README。
