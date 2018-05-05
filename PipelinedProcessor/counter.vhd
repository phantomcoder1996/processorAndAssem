Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Counter IS 
  PORT(
    
    ------------ Rst inputs --------------------------
        rst:IN std_logic;
    ------------ en inputs --------------------------
        en:IN std_logic;
    ------------ clk input -----------------
        clk:IN std_logic;
    ------------ output --------------------
        output: INOUT std_logic
      );
   SIGNAL counter:std_logic;
END ENTITY;


ARCHITECTURE my_counter OF Counter IS
  
  BEGIN
  
  PROCESS(clk)
  BEGIN


  IF (rst='1' and en = '1' AND falling_edge(clk)) THEN 
  output<='1';
  ELSIF(en = '1' AND falling_edge(clk) and counter='1') THEN 
  output<='0';
  ELSIF( falling_edge(clk))THEN
  output<='0';
  
  END IF;
  
  --output<=counter;
  END PROCESS; 
    
    
    
  END my_counter ;
  
