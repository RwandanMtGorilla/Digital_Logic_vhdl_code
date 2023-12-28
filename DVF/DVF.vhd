LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY DVF IS
PORT(
CLK: IN STD_LOGIC; -- ԭʼʱ���ź�
D: IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Ԥ��ֵ
FOUT: OUT STD_LOGIC -- ��Ƶ����ź�
);
END DVF;

ARCHITECTURE one OF DVF IS
SIGNAL FULL: STD_LOGIC; -- ����������ź�
BEGIN
P_REG: PROCESS(CLK)
VARIABLE CNT8: STD_LOGIC_VECTOR(7 DOWNTO 0); -- ����������
BEGIN
IF rising_edge(CLK) THEN
IF CNT8 = "11111111" THEN -- ���������ﵽ���ֵ
CNT8 := D; -- ����ΪԤ��ֵD
FULL <= '1'; -- ��������ź�
ELSE
CNT8 := CNT8 + 1; -- ��������1
FULL <= '0'; -- �������ź�
END IF;
END IF;
END PROCESS P_REG;

P_DIV: PROCESS(FULL)
VARIABLE CNT2: STD_LOGIC := '0'; -- ��Ƶ�źű�������ʼΪ0
BEGIN
IF rising_edge(FULL) THEN
CNT2 := NOT CNT2; -- ��FULL�ź������ص���ʱ��ȡ��CNT2
FOUT <= CNT2; -- ��CNT2��ֵ�����FOUT
END IF;
END PROCESS P_DIV;

END one;