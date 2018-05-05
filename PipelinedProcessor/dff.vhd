
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY my_nDFF IS
GENERIC ( n : integer := 8);
PORT( Clk,Rst,enb : IN std_logic; -- buf to enable tristate -- en -- to enable reg
		   d : IN std_logic_vector(n-1 DOWNTO 0); 
		   q : INOUT std_logic_vector(n-1 DOWNTO 0));
		
END my_nDFF;
  
ARCHITECTURE a_my_nDFF OF my_nDFF IS
BEGIN
PROCESS (Clk,Rst,enb,d)
BEGIN
IF (Rst = '1') THEN  -- to reset the register --
		q <= (OTHERS=>'0');
ELSIF ( (falling_edge(Clk)) and (enb='1') ) THEN 
		q <= d;

END IF;
END PROCESS;
END a_my_nDFF;

