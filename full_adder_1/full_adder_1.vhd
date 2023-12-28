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