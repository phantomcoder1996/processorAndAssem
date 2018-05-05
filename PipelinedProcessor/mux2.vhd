Library ieee;
use ieee.std_logic_1164.all;

ENTITY Mux2 IS
Generic(n: integer:=16);
Port(a:in std_logic_vector(n-1 downto 0);
     b:in std_logic_vector(n-1 downto 0);
     sel:in std_logic;
     z:out std_logic_vector(n-1 downto 0)
     );


END ENTITY;


Architecture Mux2Arch of Mux2 is
begin

z<=a when sel='0'
else b;

end Mux2Arch;