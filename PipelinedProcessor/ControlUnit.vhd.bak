Library ieee;
use ieee.std_logic_1164.all;

Entity ControlUnit is
Port(
--- inputs ---
opcode: in std_logic_vector(4 downto 0);
intr: in std_logic;
Ack: in std_logic;
branch:in std_logic;
updated:in std_logic;
clk:in std_logic;

--- outputs ---
CtrlSignals: out std_logic_vector(11 downto 0);
pushIntrEn:out std_logic;
start: out std_logic
);
end entity;

Architecture ControlUnitArch of ControlUnit is
  
Signal romEn: std_logic;
----------------------------------------------
-------------- components --------------------
----------------------------------------------
component ROM is
  
  Port(
        clk:in std_logic;
        en:in std_logic;
        address:in std_logic_vector(4 downto 0);
        output:out std_logic_vector(11 downto 0)
  );
  
end component;
----------------------------------------------
-------------- end components ----------------
----------------------------------------------
begin
--- create ROM ---
r:ROM port map (clk,romEn,opcode,ctrlSignals);
--- create start mux ---
start<='0' when intr='1' and Ack='0' 
         else '0' ;
--- set pushIntrEn & romEN ---
pushIntrEn<=not(branch);
romEn<=not(intr);

end ControlUnitArch;