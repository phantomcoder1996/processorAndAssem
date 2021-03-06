Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity PCController is

Port(

x                        : in std_logic_vector(14 downto 0);
int			 : in std_logic;
ret	                 : in std_logic; --must be set to 1 for ret and reti instructions
reset			 : in std_logic;
branch			 : in std_logic;

PCVal			 : in std_logic_vector(9  downto 0);
RdstData 		 : in std_logic_vector(15 downto 0); --Data output od decoding (read from reg file)
ALUResult1		 : in std_logic_vector(15 downto 0);
ALUResult2		 : in std_logic_vector(15 downto 0);
MemoryData		 : in std_logic_vector(15 downto 0);
WBSrcData 		 : in std_logic_vector(15 downto 0);
WBDstData 		 : in std_logic_vector(15 downto 0);


newPCVal 		 : out std_logic_vector(9 downto 0)

);


end entity;


Architecture PCControllerArch of PCController is

constant one: std_logic_vector(15 downto 0):= (0=>'1',others=>'0');

Signal pcOut		   : std_logic_vector(15 downto 0);
Signal BranchnewVal	   : std_logic_vector(15 downto 0);
Signal ForwardedBranchVal  : std_logic_vector(15 downto 0);
Signal incrementedPc 	   : std_logic_vector(15 downto 0);
Signal ALUForwardedVal     : std_logic_vector(15 downto 0);
Signal memoryForwardedVal  : std_logic_vector(15 downto 0);
Signal WbData   	   : std_logic_vector(15 downto 0);



--Selection Lines
-------------------
Signal normal_forwarded_sel: std_logic;
Signal normal_branch_sel   : std_logic;
Signal memoryStageSel	   : std_logic;
Signal directMemorySel	   : std_logic;
Signal WBSrcDataSel	   : std_logic;
Signal AluResult2Sel 	   : std_logic;

begin

incrementedPc		<=  std_logic_vector(unsigned(PCVal) + unsigned(one));

AluResult2Sel		<= '1' when x(13)='1' else '0';
WBSrcDataSel		<= '1' when x(14)='1' else '0';
directMemorySel		<= '1' when reset= '1' or int='1' or ret='1' else '0';
memoryStageSel		<= '1' when directmemorySel='1' or x(12)='1' or WBSrcDataSel='1' else '0';
normal_branch_sel	<= '1' when int='1' or reset='1' or ret='1' or branch='1' 
else '0';
normal_forwarded_sel	<= '1' when memoryStageSel='1' or x(11)='1' or AluResult2Sel='1' else '0';

WBdata			<= WBSrcData when WBSrcDataSel='1' else WBDstData;
ALUForwardedVal		<= ALUResult2 when AluResult2Sel='1' else ALUResult1;
memoryForwardedVal	<= MemoryData when directMemorySel='1' else WBdata;
ForwardedBranchVal	<= memoryForwardedVal  when memoryStageSel='1' else ALUForwardedVal;
BranchnewVal		<= ForwardedBranchVal when normal_forwarded_sel='1' else RdstData;
pcOut			<= BranchnewVal when normal_branch_sel='1' else incrementedPC;


newPCVal		<= pcOut(9 downto 0);
end PCControllerArch;