LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY encode83_1 IS
    PORT(IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7:IN STD_LOGIC; 
        ST:IN STD_LOGIC;
        Y0,Y1,Y2:OUT STD_LOGIC;
        YEX:OUT STD_LOGIC;
        YS:OUT STD_LOGIC);
END encode83_1;
ARCHITECTURE one of encode83_1  IS
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
            "11111" WHEN (ST='1');
        Y2<=Y(4);
        Y1<=Y(3);
        Y0<=Y(2);
        YEX<=Y(1);
        YS<=Y(0);
END ARCHITECTURE one;