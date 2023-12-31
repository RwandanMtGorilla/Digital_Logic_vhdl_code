LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY DVF IS
PORT(
CLK: IN STD_LOGIC; -- 原始时钟信号
D: IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- 预置值
FOUT: OUT STD_LOGIC -- 分频输出信号
);
END DVF;

ARCHITECTURE one OF DVF IS
SIGNAL FULL: STD_LOGIC; -- 计数器溢出信号
BEGIN
P_REG: PROCESS(CLK)
VARIABLE CNT8: STD_LOGIC_VECTOR(7 DOWNTO 0); -- 计数器变量
BEGIN
IF rising_edge(CLK) THEN
IF CNT8 = "11111111" THEN -- 当计数器达到最大值
CNT8 := D; -- 重置为预置值D
FULL <= '1'; -- 设置溢出信号
ELSE
CNT8 := CNT8 + 1; -- 计数器加1
FULL <= '0'; -- 清除溢出信号
END IF;
END IF;
END PROCESS P_REG;

P_DIV: PROCESS(FULL)
VARIABLE CNT2: STD_LOGIC := '0'; -- 分频信号变量，初始为0
BEGIN
IF rising_edge(FULL) THEN
CNT2 := NOT CNT2; -- 当FULL信号上升沿到来时，取反CNT2
FOUT <= CNT2; -- 将CNT2的值输出到FOUT
END IF;
END PROCESS P_DIV;

END one;