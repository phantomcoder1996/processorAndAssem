Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity RegisterFile is 

Port(

clk: in std_logic;
rst: in std_logic;

WBSrc: in std_logic; --ctrl signal
WBDst: in std_logic; --ctrl signal

WBRSrc: in std_logic_vector(2 downto 0); --Reg code of register to be written
WBRDst: in std_logic_vector(2 downto 0); --Reg code of register to be written
WBRdstData: in std_logic_vector(15 downto 0); --Data to be written to destination 
WBRsrcData: in std_logic_vector(15 downto 0); --Data to be written to Src

FDRsrc: in std_logic_vector(2 downto 0); --Reg code of register to be read
FDRDst: in std_logic_vector(2 downto 0);  --Reg code of register to be read

RsrcData: out std_logic_vector(15 downto 0);
RdstData: out std_logic_vector(15 downto 0)

);

end entity;

Architecture RegisterFileArch of RegisterFile is

Type regFile is Array(0 to 7) of std_logic_vector(15 downto 0);   

Signal registers : regfile;
Signal FDs	 : integer:=0;
Signal FDd	 : integer:=0;
Signal WBs	 : integer:=0;
Signal WBd	 : integer:=0;



begin

FDs	<= (to_integer(unsigned(FDRsrc)));
FDd	<= (to_integer(unsigned(FDRdst)));

WBs	<= (to_integer(unsigned(WBRsrc)));
WBd	<= (to_integer(unsigned(WBRdst)));

process(clk,rst)
begin

--writing in register file shall be done with falling edge of clock so that correct data will be written in the decode execute buffer for the next clock cycle

if(rst='1') then
registers(0)	<= (others=>'0');
registers(1)	<= (others=>'0');
registers(2)	<= (others=>'0');
registers(3)	<= (others=>'0');
registers(4)	<= (others=>'0');
registers(5)	<= (others=>'0');
registers(6)	<= (others=>'0');
--registers(7)	<= (others=>'0');

elsif(falling_edge(clk)) then

if(WBSrc='1') then
   registers(WBs)	<= WBRsrcData;
end if;

if(WBDst='1') then
   registers(WBd)	<= WBRdstData;
end if;

end if;

end process;

RsrcData	<= registers(FDs);
RdstData	<= registers(FDd);



end RegisterFileArch;