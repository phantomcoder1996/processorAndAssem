
Library ieee;
use ieee.std_logic_1164.all;

ENTITY Mux4 IS
Generic(n: integer:=16);
Port(a:in std_logic_vector(n-1 downto 0);
     b:in std_logic_vector(n-1 downto 0);
     c:in std_logic_vector(n-1 downto 0);
     d:in std_logic_vector(n-1 downto 0);
     sel:in std_logic_vector(1 downto 0);
     z:out std_logic_vector(n-1 downto 0)
     );


END ENTITY;


Architecture Mux4Arch of Mux4 is
begin

z<=a when sel="00"
else b when sel="01"
else c when sel="10"
else d;

end Mux4Arch;