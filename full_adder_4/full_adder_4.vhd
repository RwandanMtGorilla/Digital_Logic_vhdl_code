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
