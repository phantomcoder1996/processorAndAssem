Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;




entity decoder is

Generic(n: integer:=3);

Port(En:in std_logic; 
s: in std_logic_vector(n-1 downto 0); 
output: out std_logic_vector(((2**n)-1) downto 0));

end entity;


Architecture decoderArchitecture of decoder is
begin

process(s,En)
begin
if(En = '1') then

output<=(others=>'0');
output(to_integer(unsigned(s)))<='1';

else

 output<=(others=>'0');
end if;
end process;



end decoderArchitecture;
