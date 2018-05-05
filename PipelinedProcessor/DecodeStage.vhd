Library ieee;
use ieee.std_logic_1164.all;

Entity DecodeStage is

Port(

clk   :in std_logic;
reset :in std_logic; --signal to load pc with M[0]
int   :in std_logic;

ack   :in std_logic;
branch:in std_logic;
updated:in std_logic;

rst   :in std_logic; --external signal to set all registers to 0


FetchDecode: in std_logic_vector(36 downto 0);
WriteBack  : in std_logic_vector( 38 downto 0);
WriteBackCtrlSignals: in std_logic_vector(2 downto 0);

PortInput	: in std_logic_vector(15 downto 0);

nextStageEn: in std_logic;
 

--Output represents decoding results and control signals
----------------------------------------------------------
--CtrlSignals : out std_logic_vector(11 downto 0);
decodedDstD : out std_logic_vector(15 downto 0); --Decoded data required for branching and will be needed by fetch stage
DecodeExecute: out std_logic_vector(66 downto 0);

FetchDecodeOpcode: out std_logic_vector( 4 downto 0); --needed for branch unit


--Output from control unit
--------------------------
 pushIntrEn: out std_logic;
 start	   : out std_logic;

------output for flushing 
DECEXRET:out std_logic;

ExMemREt: in std_logic;
stall: in std_logic


);

end entity;


Architecture DecodeStageArch of DecodeStage is


--Decoding intermediate signals
--------------------------------
Signal decodedSrcData	  :std_logic_vector(15 downto 0);
Signal decodedDstData	  :std_logic_vector(15 downto 0);

Signal decodedCtrlSignals :std_logic_vector(10 downto 0);

Signal rdstV_port	  :std_logic_vector(15 downto 0);

Signal DecodeExecuteIn	  :std_logic_vector(66 downto 0);
Signal DecodeExecuteOut	  :std_logic_vector(66 downto 0);

Signal DecExEn		  :std_logic;

Signal inInst		  :std_logic;
Signal Shl		  :std_logic;
Signal Shr		  :std_logic;
Signal LDM		  :std_logic;
Signal LDD		  :std_logic;
Signal STDins		  :std_logic;	

--Fetch decode register fields
-------------------------------
Signal incrementedPC:    std_logic_vector(9 downto 0);
Signal opcode:           std_logic_vector(4 downto 0);
Signal Rsrc:		 std_logic_vector(2 downto 0);
Signal Rdst:		 std_logic_vector(2 downto 0);
Signal Address_Imm:      std_logic_vector(15 downto 0);


--Data and signals from the writeback stage
--------------------------------------------
Signal WBRSrc:		 std_logic_vector(2 downto 0);
Signal WBRDst:		 std_logic_vector(2 downto 0);
Signal RdstData:	 std_logic_vector(15 downto 0);
Signal RsrcData: 	 std_logic_vector(15 downto 0);
Signal Wsrc:		 std_logic; 
Signal Wdst:	         std_logic;


---------------------------
Signal DecExSHorLDM	  : std_logic;
Signal chooseNOP          : std_logic;



begin

incrementedPC	<=	FetchDecode(36 downto 27);
opcode		<=	FetchDecode(26 downto 22);
Rsrc		<=	FetchDecode(21 downto 19);
Rdst		<=	FetchDecode(18 downto 16);
Address_Imm     <=	FetchDecode(15 downto 0);


RsrcData	<= 	WriteBack(38 downto 23);
RdstData	<= 	WriteBack(22 downto 7);
WBRSrc		<= 	WriteBack(6 downto 4);
WBRdst		<= 	WriteBack(3 downto 1);
wsrc		<=	WriteBackCtrlSignals(1);
wdst		<=      WriteBackCtrlSignals(0);
--TODO: change wsrc and wdst to match those of wb stage


 decodedDstD	<=	decodedDstData;


--RegisterFile
--------------
RegisterFile 	: entity work.RegisterFile port map(clk,rst,wsrc,wdst,WBRsrc,WBRdst,RsrcData,RdstData,Rsrc,Rdst,decodedSrcData,decodedDstData);


--Control Unit
--------------
ControlUnit	: entity work.ControlUnit port map(opcode,int,ack,branch,updated,clk,decodedCtrlSignals,pushIntrEn,start);

--Branch Unit
--------------
--BranchUnit	: entity work.BranchUnit  port map(opcode,DecExAluEn,);

FetchDecodeOpcode <= opcode;
--Signals for mux in decode stage
---------------------------------
inInst		<= '1' when opcode="10000" else '0';
shl		<= '1' when opcode="01001" else '0';
shr		<= '1' when opcode="01010" else '0';
LDD		<= '1' when opcode="11101" else '0';
LDM		<= '1' when opcode="11100" else '0';
STDins		<= '1' when opcode="11110" else '0';

rdstv_port	<= portInput when inInst='1' else decodedDstData; 

--Decode Execute Register mapping
----------------------------------
 DecodeExecuteIn(66 downto 56)<=decodedCtrlSignals when chooseNop='0' else (others=>'0');
 DecodeExecuteIn(55)<=DecExSHorLDM;
 DecodeExecuteIn(54)		<= '1'; --I dont know what this signal is used for
 DecodeExecuteIn(53)	        <= '1' when int='1' else '0';
 DecodeExecuteIn(52 downto 43)	<= incrementedPC;
 DecodeExecuteIn(42 downto 27)	<= decodedSrcData;
 DecodeExecuteIn(26 downto 11)	<= Address_Imm when shl='1' or shr='1' or LDD='1' or LDM='1' or STDins='1' else rdstv_port;
 DecodeExecuteIn(10 downto 8)   <= Rsrc;
 DecodeExecuteIn(7 downto 5)    <= Rdst;
 DecodeExecuteIn(4 downto 0)    <= "00000" when chooseNop='1' else opcode ;

chooseNop<='1' when nextStageEn='1' or DecodeExecuteout(64)='1' or Exmemret='1'  else '0';

 DecExEn <= not stall; --Temporarily until I receive a signal from fetch stage

 DecodeExecuteRegister: entity work.nbitRegister generic map(n=>67) port map(DecodeExecuteIn,rst,clk,DecExEn,DecodeExecuteout);
--CtrlSignals <= DecodeExecute(67 downto 56);
 --CtrlSignals<= decodedCtrlSignals;
 
DECEXRET<=DecodeExecuteout(64); --TODO:REVISE THA
DecodeExecute<=DecodeExecuteOut;



 

DecExSHorLDM<='1' when opcode="11100" or opcode="01010" or opcode="01001"
else '0';

end DecodeStageArch;
