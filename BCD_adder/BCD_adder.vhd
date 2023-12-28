LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY BCD_adder IS
    PORT (
    BCD_A, BCD_B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    BCD_CIN : IN STD_LOGIC;
    BCD_F : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    BCD_COUT : OUT STD_LOGIC);
END BCD_adder;
ARCHITECTURE one OF BCD_adder IS
    COMPONENT full_adder_4
        PORT (A,B: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        F: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);--四位全加器的本位输出
        CIN :IN STD_LOGIC;--四位全加器的低位进位
        COUT:OUT STD_LOGIC);--四位全加器的高位进位
    END COMPONENT;
    --为修正判别过渡部分创建信号
    SIGNAL Q1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Q2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL COUT1 : STD_LOGIC;
    SIGNAL COUT2 : STD_LOGIC;
BEGIN
    U1 : full_adder_4 PORT MAP(A =>BCD_A,B =>BCD_B,F => Q1, CIN =>BCD_CIN, COUT => COUT1);
    PROCESS (BCD_A, BCD_B, BCD_CIN,COUT1,Q1,Q2,COUT2)--通过process(args)来使用if结构
    BEGIN--做修正判断
        IF (COUT1 = '1') THEN --A+B>15时
            Q2 <= Q1 +6;--加6修正
            COUT2<='1';
        ELSIF (Q1 >9) THEN --A+B>9时
            COUT2 <= '1';
            Q2 <= Q1 - 10;
        ELSIF (Q1 <10) THEN --A+B<10,不需要修正(或者说修正值为0即可),直接将Q1的值赋给Q2
            Q2 <= Q1;
            COUT2 <= '0';
        END IF;
        BCD_F <= Q2;--本位相加结果:
        BCD_COUT<= COUT2;--本次两个BCD码相加的进位情况(0/1):
    END PROCESS;
END one;