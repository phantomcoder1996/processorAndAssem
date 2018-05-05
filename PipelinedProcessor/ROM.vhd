LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
Entity ROM is
  
  Port(
        clk:in std_logic;
        en:in std_logic;
        address:in std_logic_vector(4 downto 0);
        output:out std_logic_vector(10 downto 0)
  );
  
end entity ;


architecture my_rom of ROM is 
TYPE memory IS ARRAY(0 TO 30) OF std_logic_vector(10 DOWNTO 0);
	SIGNAL mem : memory ;
begin 
 -- PROCESS(clk) IS
			--BEGIN
				--IF (rising_edge(clk) and en='1') THEN  
						output<=mem(to_integer(unsigned(address)));
				--	END IF;
					--END PROCESS;
  
end my_rom;



