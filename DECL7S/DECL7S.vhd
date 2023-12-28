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