
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

ARCHI
TECTURE one of encode83_2 IS
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
            ELSE
                Y <= "XXXXX"; -- Undefined state
            END IF;
        END IF;

        Y2 <= Y(4);
        Y1 <= Y(3);
        Y0 <= Y(2);
        YEX <= Y(1);
        YS <= Y(0);
    END PROCESS;
END ARCHITECTURE one;