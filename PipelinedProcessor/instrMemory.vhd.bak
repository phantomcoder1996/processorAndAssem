LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
Entity instrMemory is
  
  Port(
        clk:in std_logic;
        address:in std_logic_vector(9 downto 0);
        output:out std_logic_vector(15 downto 0)
  );
  
end entity ;


architecture IM of instrMemory is 
TYPE memory IS ARRAY(0 TO 1023) OF std_logic_vector(15 DOWNTO 0);
	SIGNAL mem : memory ;
begin 
  PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
						output<=mem(to_integer(unsigned(address)));
					END IF;
					END PROCESS;
  
end IM;

