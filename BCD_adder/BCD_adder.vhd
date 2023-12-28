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
        F: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);--��λȫ�����ı�λ���
        CIN :IN STD_LOGIC;--��λȫ�����ĵ�λ��λ
        COUT:OUT STD_LOGIC);--��λȫ�����ĸ�λ��λ
    END COMPONENT;
    --Ϊ�����б���ɲ��ִ����ź�
    SIGNAL Q1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Q2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL COUT1 : STD_LOGIC;
    SIGNAL COUT2 : STD_LOGIC;
BEGIN
    U1 : full_adder_4 PORT MAP(A =>BCD_A,B =>BCD_B,F => Q1, CIN =>BCD_CIN, COUT => COUT1);
    PROCESS (BCD_A, BCD_B, BCD_CIN,COUT1,Q1,Q2,COUT2)--ͨ��process(args)��ʹ��if�ṹ
    BEGIN--�������ж�
        IF (COUT1 = '1') THEN --A+B>15ʱ
            Q2 <= Q1 +6;--��6����
            COUT2<='1';
        ELSIF (Q1 >9) THEN --A+B>9ʱ
            COUT2 <= '1';
            Q2 <= Q1 - 10;
        ELSIF (Q1 <10) THEN --A+B<10,����Ҫ����(����˵����ֵΪ0����),ֱ�ӽ�Q1��ֵ����Q2
            Q2 <= Q1;
            COUT2 <= '0';
        END IF;
        BCD_F <= Q2;--��λ��ӽ��:
        BCD_COUT<= COUT2;--��������BCD����ӵĽ�λ���(0/1):
    END PROCESS;
END one;