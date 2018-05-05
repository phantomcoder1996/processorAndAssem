library ieee;
use ieee.std_logic_1164.all;

entity tristateBuffer is

  generic (n : integer := 32);
  port(
       a:in std_logic_vector (n-1 downto 0);
       sel:in std_logic;
       b:out std_logic_vector (n-1 downto 0));

end tristateBuffer;


architecture arcTristate of tristateBuffer is 

begin

b<=a when sel='1'
else (others=>'Z') when sel='0';

end arcTristate;
