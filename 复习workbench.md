```md
在 VHDL 中，语法是不区分大小写的

```

### 二选一电路
```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY mux2la IS
	PORT (a, b, s: IN BIT;  --对于bit 也有写法如 BIT_VECTOR(7 DOWNTO 0) bit只有 0或者1;也有STD_LOGIC 和 STD_LOGIC_VECTOR; STD_LOGIC：与BIT类似，但它包含了更多的状态（如'U'（未初始化），'X'（未知），'0'，'1'，'Z'（高阻态），'W'，'L'，'H'，'-'）
				y: OUT BIT);    --请注意 在port的末尾句 结尾没有分号 在port中';'作为分隔符使用
END ENTITY mux2la;
ARCHITECTURE one OF mux2la IS  --定义了一个实体（Entity）和它的一个或多个架构（Architecture），编译器或仿真器通常默认选择最后一个编译的架构。
  BEGIN
  PROCESS (a,b,s) 
    BEGIN
	IF s = '0' THEN
	   y <= a;  --信号赋值语句
    ELSE
	   y <= b;
	END IF;
  END PROCESS;
END ARCHITECTURE one;

```

### 触发器(D触发器)
```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY DFF1 IS
    PORT(CLK:IN STD_LOGIC;
         D:IN STD_LOGIC;
         Q:OUT STD_LOGIC);
END;
ARCHITECTURE bhv OF DFF1 IS
    SIGNAL Q1:STD_LOGIC; --SIGNAL Q1: STD_LOGIC; 这行定义了一个内部信号 Q1
    BEGIN
    PROCESS(CLK,Q1) 
        BEGIN
            IF CLK'EVENT AND CLK='1' THEN    --CLK'EVENT 不论上升沿下降沿 只要信号改变，'EVENT 属性就返回 TRUE； CLK='1'则是上升沿
            Q1<=D; 
            END IF;
        END PROCESS;
    Q<=Q1;  --代码位于 PROCESS 块外部  在 VHDL 中，除了 PROCESS 块之外的语句都是并发执行的。 在 PROCESS 块之外直接使用 IF 语句会创建组合逻辑，而不是时序逻辑。这意味着输出的变化直接依赖于输入的变化，而不是时钟或其他触发事件。
END bhv;
```

```vhdl

IF CLK'EVENT AND CLK='1' THEN 

END IF;
```

### 锁存器(电平敏感 D触发器)
```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY DFF2 IS
    PORT(CLK:IN STD_LOGIC;
         D:IN   STD_LOGIC;
         Q:OUT  STD_LOGIC);
END;
ARCHITECTURE bhv OF DFF2 IS
    BEGIN
        PROCESS(CLK,D)
        BEGIN
        IF CLK='1'  --高电平存储 低电平锁定
            THEN Q<=D;
        END IF;
    END PROCESS;
END bhv;

```

### 
```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FDD IS
    PORT(CLK, 
         D, 
         CLR, 
         PRE, 
         CE: IN STD_LOGIC;
         Q: OUT STD_LOGIC);
END FDD;

ARCHITECTURE BHV OF FDD IS
    SIGNAL Q_TMP: STD_LOGIC;
BEGIN
    Q <= Q_TMP;

    PROCESS(CLK, CLR, PRE, CE)
    BEGIN
        IF CLR = '1' THEN      -- Asynchronous clear
            Q_TMP <= '0';
        ELSIF PRE = '1' THEN  -- Asynchronous preset
            Q_TMP <= '1';
        ELSIF rising_edge(CLK) THEN
            IF CE = '1' THEN    -- Clock enable
                Q_TMP <= D;
            END IF;
        END IF;
    END PROCESS;
END BHV;

```

### 条件信号赋值语句的 8-3优先译码器电路
```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY encode83_2 IS
    PORT(
        IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7:IN STD_LOGIC; 
        ST:IN STD_LOGIC;
        Y0,Y1,Y2:OUT STD_LOGIC;
        YEX:OUT STD_LOGIC;
        YS:OUT STD_LOGIC);
END encode83_2;
ARCHITECTURE one of encode83_2  IS
SIGNAL I :STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL Y :STD_LOGIC_VECTOR(4 DOWNTO 0); 
BEGIN
        I<=IN7&IN6&IN5&IN4&IN3&IN2&IN1&IN0; 
        Y<= "11110" WHEN (ST='0' AND I="11111111") ELSE
            "00001" WHEN (ST='0' AND IN7='0') ELSE
            "00101" WHEN (ST='0' AND IN6='0') ELSE
            "01001" WHEN (ST='0' AND IN5='0') ELSE
            "01101" WHEN (ST='0' AND IN4='0') ELSE
            "10001" WHEN (ST='0' AND IN3='0') ELSE
            "10101" WHEN (ST='0' AND IN2='0') ELSE
            "11001" WHEN (ST='0' AND IN1='0') ELSE
            "11101" WHEN (ST='0' AND IN0='0') ELSE
            "11111" WHEN (ST='1');--选择信号赋值语句

        Y2<=Y(4);
        Y1<=Y(3);
        Y0<=Y(2);
        YEX<=Y(1);
        YS<=Y(0);
END ARCHITECTURE one;

```

### IF语句 8-3优先译码器电路
```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY encode83_2 IS
    PORT(
        IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7 : IN STD_LOGIC; 
        ST : IN STD_LOGIC;
        Y0, Y1, Y2 : OUT STD_LOGIC;
        YEX : OUT STD_LOGIC;
        YS : OUT STD_LOGIC
    );
END encode83_2;

ARCHITECTURE one of encode83_2 IS
    SIGNAL I : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Y : STD_LOGIC_VECTOR(4 DOWNTO 0); 
BEGIN
    I <= IN7 & IN6 & IN5 & IN4 & IN3 & IN2 & IN1 & IN0;

    PROCESS(ST, I)
    BEGIN
        IF ST = '1' THEN
            Y <= "11111";
        ELSE
            IF I = "11111111" THEN
                Y <= "11110";
            ELSIF IN7 = '0' THEN
                Y <= "00001";
            ELSIF IN6 = '0' THEN
                Y <= "00101";
            ELSIF IN5 = '0' THEN
                Y <= "01001";
            ELSIF IN4 = '0' THEN
                Y <= "01101";
            ELSIF IN3 = '0' THEN
                Y <= "10001";
            ELSIF IN2 = '0' THEN
                Y <= "10101";
            ELSIF IN1 = '0' THEN
                Y <= "11001";
            ELSIF IN0 = '0' THEN
                Y <= "11101";

            END IF;
        END IF;

        Y2 <= Y(4);
        Y1 <= Y(3);
        Y0 <= Y(2);
        YEX <= Y(1);
        YS <= Y(0);
    END PROCESS;
END ARCHITECTURE one;

```
### 元件例化举例
**rod41.vhd**
```vhdl
library ieee;
use ieee.std_logic_1164.all;
entity ord41 is
port (
    a1,b1,c1,d1: in std_logic;  --外部IO端口
    z1         : out std_logic;
)
end ord41;
architecture ord41bhv of ord41 is
    component nd2   --例化实体名对应
        port (a,b: in std.logic;    --端口名对应
                c: out std_logic);
    end component;
    signal x,y:std_logic;   --信号线(内部线)
    begin
        u1:nd2 port map(a=>a1,b=>b1;c=>x);--例化名(元件名)
        u2:nd2 port map(a=>c1,b=>d1;c=>y);
        u3:nd2 port map(a=>x,b=>y,c=>z1);
end ord41bhv;

```
**nd2.vhd**
```vhdl
library ieee;
use ieee.std_logic_1164.all;
entity nd2 is
    port(
        a,b:in std_logic;
        c:out std_logic
    );
end;
architecture nd2bhv of nd2 is
begin
    c<=a nand b;
end;
```

### 一位全加器
```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY full_adder_1 IS
    PORT ( a : IN STD_LOGIC;
        b: IN STD_LOGIC; 
        ci : IN STD_LOGIC; 
        CO: OUT STD_LOGIC; 
        f : OUT STD_LOGIC);
END full_adder_1;
ARCHITECTURE one OF full_adder_1 IS 
BEGIN
    f <= a XOR b XOR ci;
    Co <= (a AND b) OR (a AND ci) OR(b AND ci); 
END one;
```

### 四位全加器
```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 

ENTITY full_adder_4 IS
    PORT (
        A, B: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        F: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 
        CIN: IN STD_LOGIC;
        COUT: OUT STD_LOGIC
    ); 
END full_adder_4;

ARCHITECTURE one OF full_adder_4 IS
    COMPONENT full_adder_1
        PORT(
            a : IN STD_LOGIC;
            b : IN STD_LOGIC; 
            ci : IN STD_LOGIC; 
            co : OUT STD_LOGIC; 
            f : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL temp: STD_LOGIC_VECTOR(4 DOWNTO 0); 

BEGIN
    temp(0) <= CIN;

    g: FOR i IN 0 TO 3 GENERATE
        u1: full_adder_1 
            PORT MAP(
                a => A(i),
                b => B(i),
                ci => temp(i),
                co => temp(i+1),
                f => F(i)
            );
    END GENERATE g;

    COUT <= temp(4); 
END one;

```

## VHDL行为描述方式 BCD加法器 
- (只需一个四位全加器) 你都直接在算法里用加减号了 你还要用一个实例化的加法器？？？
```vhdl
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
```
### VHDL结构描述方式 BCD加法器
```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY BCD_adder1 IS
    PORT (
    BCD_A, BCD_B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    BCD_CIN : IN STD_LOGIC;
    BCD_F : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    BCD_COUT : OUT STD_LOGIC);
END BCD_adder1;

ARCHITECTURE one OF BCD_adder1 IS
    COMPONENT full_adder_4
        PORT (
        A, B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        F : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        CIN : IN STD_LOGIC;
        COUT : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL temp: STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL COUT1, COUT2: STD_LOGIC;
    SIGNAL Q1, Q2: STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	U1:full_adder_4 PORT MAP(A =>BCD_A,B =>BCD_B,F =>Q1,CIN =>BCD_CIN,COUT =>COUT1);
	
	COUT2<=NOT((NOT COUT1)AND(Q1(3) NAND Q1(1))AND(Q1(3)NAND Q1(2)));
	
	Q2(3)<= '0';
	Q2(2)<= COUT2;
	Q2(1)<= COUT2;
	Q2(0)<= '0';
	U2:full_adder_4 PORT MAP(A =>Q2,B =>Q1,F =>BCD_F,CIN => '0');
	
	BCD_COUT<= COUT2;
	
END one;
```
- 好 我逐渐理解了一切! 元件实例化基本可以理解为一种可以调用的 函数(!)但是思路上和程序编写不太相同

###  7段数码显示译码器VHDL源程序
```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
ENTITY DECL7S IS
PORT(A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    LED7S : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)); 
END;
ARCHITECTURE one OF DECL7S IS 
BEGIN
PROCESS(A) 
BEGIN
    CASE A IS
        WHEN "0000" => LED7S <= "0111111"; -- 0
        WHEN "0001" => LED7S <= "0000110"; -- 1
        WHEN "0010" => LED7S <= "1011011"; -- 2
        WHEN "0011" => LED7S <= "1001111"; -- 3
        WHEN "0100" => LED7S <= "1100110"; -- 4
        WHEN "0101" => LED7S <= "1101101"; -- 5
        WHEN "0110" => LED7S <= "1111101"; -- 6
        WHEN "0111" => LED7S <= "0000111"; -- 7
        WHEN "1000" => LED7S <= "1111111"; -- 8
        WHEN "1001" => LED7S <= "1101111"; -- 9
        WHEN "1010" => LED7S <= "1110111"; -- A
        WHEN "1011" => LED7S <= "1111100"; -- b
        WHEN "1100" => LED7S <= "0111001"; -- C
        WHEN "1101" => LED7S <= "1011110"; -- d
        WHEN "1110" => LED7S <= "1111001"; -- E
        WHEN "1111" => LED7S <= "1110001"; -- F
        WHEN OTHERS => LED7S <= "0000000"; -- default
    END CASE;
END PROCESS; 
END;
```
### 8位数控分频器VHDL源程序
```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY DVF IS
    PORT(
        CLK: IN STD_LOGIC;                      -- 原始时钟信号
        D: IN STD_LOGIC_VECTOR(7 DOWNTO 0);     -- 预置值
        FOUT: OUT STD_LOGIC                     -- 分频输出信号
    );
END DVF;

ARCHITECTURE one OF DVF IS
    SIGNAL FULL: STD_LOGIC; -- 计数器溢出信号
BEGIN
    P_REG: PROCESS(CLK)
        VARIABLE CNT8: STD_LOGIC_VECTOR(7 DOWNTO 0); -- 计数器变量
    BEGIN
        IF rising_edge(CLK) THEN
            IF CNT8 = "11111111" THEN    -- 当计数器达到最大值
                CNT8 := D;               -- 重置为预置值D
                FULL <= '1';             -- 设置溢出信号
            ELSE
                CNT8 := CNT8 + 1;        -- 计数器加1
                FULL <= '0';             -- 清除溢出信号
            END IF;
        END IF;
    END PROCESS P_REG;

    P_DIV: PROCESS(FULL)
        VARIABLE CNT2: STD_LOGIC := '0'; -- 分频信号变量，初始为0
    BEGIN
        IF rising_edge(FULL) THEN
            CNT2 := NOT CNT2;            -- 当FULL信号上升沿到来时，取反CNT2
            FOUT <= CNT2;                -- 将CNT2的值输出到FOUT
        END IF;
    END PROCESS P_DIV;

END one;

```