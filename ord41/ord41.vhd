library ieee;
use ieee.std_logic_1164.all;
entity ord41 is
port
(a1,b1,c1,d1 :in std_logic;
z1           :out std_logic);
end ord41;
architecture ord41bhv of ord41 is
    component nd2
    port (a,b: in std_logic;
          c  :out std_logic);
    end component;
    signal x,y:std_logic;
    begin
    u1:nd2 port map(a1,b1,x);
    u2:nd2 port map(a=>c1,c=>y,b=>d1);
    u3:nd2 port map(x,y,c=>z1);
end ord41bhv;