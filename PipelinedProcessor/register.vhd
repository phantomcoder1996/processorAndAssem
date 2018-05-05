Library ieee;
use ieee.std_logic_1164.all;

Entity nbitregister is
Generic(n: integer:=32);
Port(d : in std_logic_vector(n-1 downto 0);
     rst: in std_logic;
     clk: in std_logic;
     En: in std_logic;
    q : out std_logic_vector(n-1 downto 0));

end Entity;


Architecture nbitregister_architecture of nbitregister is
begin

process(rst,clk,En)
begin

if(rst='1') then

q<=(others=>'0');

elsif(rising_edge(clk) and En='1') then

q<=d;

end if;



end process;



end nbitregister_architecture;
