Library ieee;
use ieee.std_logic_1164.all;

entity ExecuteStage is

Port(
clk: in std_logic;
rst: in std_logic;


stall:in std_logic;
DecodeExecute: in std_logic_vector(55 downto 0);

inCtrlSignals: in std_logic_vector(10 downto 0);

--opcode	     : in std_logic_vector(4 downto 0); --needed to check if the instuction in execute is out instruction
--this could also be determined from iowrite but not sure;
ExMemRdstV   : in std_logic_vector(15 downto 0); --Dst multiplexer output in memory wb stage
ExMemRsrcV   : in std_logic_vector(15 downto 0); --Src multiplexer output in memory wb stage
WriteBack    : in std_logic_vector(38 downto 0);  --maps to WriteBack Register from 38 down to 7
x	     : in std_logic_vector(14 downto 0); --input from forwarding unit
fetchDecodeOpcode: in std_logic_vector(4 downto 0); --passed from decode stage for branch unit
--FlagsReg: in std_logic_vector(3 downto 0);
--FlagsREGOUT:out std_logic_vector(3 downto 0);
--Output represents execution results as well as ctrl signals


--outCtrlSignals: out std_logic_vector(11 downto 0);

ExecuteMemory:  out std_logic_vector(76 downto 0);
OutportOutput: out std_logic_vector(15 downto 0);


------ALUOUPUT

 ALURESult1: out std_logic_vector(15 downto 0);
 ALURESutlt2: out  std_logic_vector(15 downto 0);

--Output from branch unit
branch	     : inout std_logic;
flush	     : inout std_logic;
EXECMEMRET: out std_logic


);

end entity;


Architecture ExecuteStageArch of ExecuteStage is

Signal T		: std_logic;
Signal incrementedPC	: std_logic_vector(9 downto 0);
Signal RsrcV		: std_logic_vector(15 downto 0);
Signal RdstV		: std_logic_vector(15 downto 0);
Signal imm		: std_logic_vector(15 downto 0);
Signal Rsrc		: std_logic_vector(2 downto 0);
Signal Rdst		: std_logic_vector(2 downto 0);
Signal opcode		: std_logic_vector(4 downto 0); --ALU op may change so be careful
Signal intIndicator	: std_logic;

--Data coming from WB stage
---------------------------
Signal WBDstData    :  std_logic_vector(15 downto 0);  --dst data in WB buffers
Signal WBSrcData    :  std_logic_vector(15 downto 0);  --src data in WB buffers 


signal ExMemOut     :std_logic_vector(76 downto 0);

--Input Ctrl Signals
---------------------
--TODO: write all input ctrlsigs as shown
---------------------------------------------
Signal IoWr		: std_logic;
SIGNAL DEXMUX          : std_logic;     --shr shl ldm
SIGNAL EXMEMMUX        : std_logic;     -- push std out 
SIGNAL MEMIO            : std_logic_vector(2 downto 0);   -- 00 rd mem-- 01 wr mem --10 rd IO --11 wr IO
SIGNAL  SELSRC          :std_logic; --push pop ret reti call
SIGNAL  SELDST          :std_logic_vector(1 downto 0); -- 00 in --01 any alu --10 ldd/pop  -- 11 LDM
SIGNAL  JMPS            :std_logic_vector(2 downto 0); -- 00 jmp --01 jz --10 jn  -- 11 jc
SIGNAL CALLRET         :std_logic_vector(1 downto 0); --10 call 01 ret
SIGNAL WBB             :std_logic_vector(2 downto 0); -- src dst dst hazard

Signal OutportInput	: std_logic_vector(15 downto 0);
Signal ExMemIN          :  std_logic_vector(76 downto 0);
-----------------------
--Signal  ALU
Signal FlagsALU: std_logic_vector(3 downto 0);
Signal ALURES1: std_logic_vector(15 downto 0);
Signal ALURES2: std_logic_vector(15 downto 0);
SIGNAL ALURSRC:std_logic_vector(15 downto 0);
SIGNAL ALUDEST:std_logic_vector(15 downto 0);
SIGNAL ALUEN: std_logic;
----------------------------------------------------------------------------
----Signal for selecting src and dst

SIgnal sel1DST,sel2DST,sel3DST,sel4DST: std_logic;
SIGNAL sel1SRC,sel2SRC,sel3SRC,sel4SRC:std_logic;
SIGNAL RsrcVMux1,RsrcVMux2,RsrcVMux3:std_logic_vector(15 downto 0);
SIGNAL  RdstVMUX2,RdstVMUX1,RdstVMUX3:std_logic_vector(15 downto 0);

------------------------------------------------------

-------------control Signals ------------------------------------
constant ANDOP: std_logic_vector(4 downto 0) := "00101";
constant SHLCOP: std_logic_vector(4 downto 0) := "00111";
constant SHRCOP: std_logic_vector(4 downto 0) := "01000";
constant OROP: std_logic_vector(4 downto 0) := "00110";
constant CALLOP: std_logic_vector(4 downto 0) := "11001";
constant MOVOP: std_logic_vector(4 downto 0) := "00001";
constant NOTOP: std_logic_vector(4 downto 0) := "10001";
constant DECOP: std_logic_vector(4 downto 0) := "10100";
constant INCOP: std_logic_vector(4 downto 0) := "10011";
constant ADDOP: std_logic_vector(4 downto 0) := "00010";
constant SUBOP: std_logic_vector(4 downto 0) := "00100";
constant MULOP: std_logic_vector(4 downto 0) := "00011";
constant JMPOP: std_logic_vector(4 downto 0) := "11000";
constant JMPCOP: std_logic_vector(4 downto 0) := "10111";
constant JMPNOP: std_logic_vector(4 downto 0) := "10110";
constant JMPZOP: std_logic_vector(4 downto 0) := "10101";
CONSTANT POPOP:std_logic_vector(4 downto 0) := "01110";
CONSTANT RETOP:std_logic_vector(4 downto 0) := "11010";
CONSTANT SHLOP:std_logic_vector(4 downto 0) := "01001";
CONSTANT SHROP:std_logic_vector(4 downto 0) := "01010";
CONSTANT RETIOP:std_logic_vector(4 downto 0) :="11011";
CONSTANT PUSHOP:std_logic_vector(4 downto 0) :="01101";
CONSTANT NOOP:std_logic_vector(4 downto 0) :="00000";
CONSTANT LDDOP:std_logic_vector(4 downto 0) :="11101";
CONSTANT LDMOP:std_logic_vector(4 downto 0) :="11100";
CONSTANT OUTOP:std_logic_vector(4 downto 0) :="01111";
CONSTANT INOP:std_logic_vector(4 downto 0) :="10000";
CONSTANT STDOP:std_logic_vector(4 downto 0) :="11110";
CONSTANT SetcOP:std_logic_vector(4 downto 0) :="01011";
CONSTANT clrcop:std_logic_vector(4 downto 0) :="01100";
-------------------------------------------------
SIGNAL opc:std_logic_vector(4 downto 0);
-----signal for branch
SIGNAL BR:std_logic;

-----
SIGNAL ROUT:std_logic_vector(15 downto 0);
SIGNAL ROUT2:std_logic_vector(15 downto 0);
----------------------------

SIGNAL EXMEMEN: std_logic;
--------------------
SIGNAL FlagsReg:  std_logic_vector(3 downto 0);
SIGNAL FlagsREGOUT: std_logic_vector(3 downto 0);
---------------

SIGNAL ExMemSHorLDM	:std_logic;

SIGNAL cntrlsgmod:std_logic_vector(10 downto 0);
-------
begin

--Signals coming from WriteBack Stage
-------------------------------------
WBsrcData	<= 	WriteBack(38 downto 23);
WBdstData	<= 	WriteBack(22 downto 7);


--Decode Execute Register fields
---------------------------------
T		<= DecodeExecute(54);
intIndicator	<= DecodeExecute(53);
incrementedPC	<= DecodeExecute(52 downto 43);
RsrcV		<= DecodeExecute(42 downto 27);
RdstV		<= DecodeExecute(26 downto 11);
Rsrc		<= DecodeExecute(10 downto 8);
Rdst		<= DecodeExecute(7 downto 5);
opcode		<= DecodeExecute(4 downto 0);

--Decoding of Control Signals
-----------------------------

--ToDo: Write decoding of in ctrl signals as shown

--MEMIO     <=   inCtrlSignals(11 downto 9);       -- 00 rd mem-- 01 wr mem --10 rd IO --11 wr IO
--IoWr		<= '1' when MEMIO="001"
--else '0';

IOWR<= inCtrlSignals(9);

--Output port and its Controller
--------------------------------
OutputPortController:entity work.outPortController port map(RsrcV,ExMemRdstV,ExMemRsrcV,WBDstData,WBSrcData,x,outPortInput );
Outputport          :entity work.nbitregisterf generic map(n=>16) port map(outPortInput,rst,clk,IOWr,OutportOutput);

----------------------------------------------------

--TODO: Add Alu and its signals
---------------------------------
ALUEN<='1' when opcode=ANDOP or  opcode=SHLCOP or opcode=SHRCOP or opcode=OROP or opcode=NOTOP  or opcode=DECOP or opcode=ADDOP or opcode=SUBOP or opcode=MULOP or opcode=setcop or opcode=clrcop 
else '0';

ALUUnit :entity work.ALU port map(ALURSRC,ALUDEST,opcode,ALUEN,ALURES1,ALURES2,FlagsREGOUT,FlagsALU);
FlagsReg<=FlagsALU;

-----------------ALU results 
ALURESult1<=ALURES1;
ALURESutlt2<=ALURES2;

--TODO: Add muxes at src and dst values of alu
-----------------------------------------------
--sel1SRC<=x(3);
--sel2SRC<=x(7) or x(10);
--sel3SRC<=x(10);
--sel4SRC<=x(0) or x(7) or x(10) or x(3);
--RsrcVMux1<=ExMemout(37 downto 22)when sel1SRC='0'
--else ExMemout(53 downto 38);
--RsrcVMux2<= WBDstData when sel3SRC='0'
--else WBSrcData;
--RsrcVMux3<=RsrcVMux2 when sel2SRC='1'
--else RsrcVMux1;
--ALURSRC<= RsrcV when sel4SRC='0'
--else RsrcVMux3;


sel1SRC<=x(3);
sel2SRC<=x(7) or x(10);
sel3SRC<=x(10);
sel4SRC<=x(0) or x(7) or x(10) or x(3);
RsrcVMux1<=ExMemRsrcV when sel1SRC='1'
else ExMemRdstV;
RsrcVMux2<= WBDstData when sel3SRC='0'
else WBSrcData;
RsrcVMux3<=RsrcVMux2 when sel2SRC='1'
else RsrcVMux1;
ALURSRC<= RsrcV when sel4SRC='0'
else RsrcVMux3;
----------------------------
--sel1DST<=x(2);
--sel2DST<=x(1)or x(2);
--sel3DST<=x(9);
--sel4DST<= x(1)or x(2)or x(8)or x(9);

--RdstVMUX2<= WBSrcData when sel3DST='1'
--else WBDstData;
--RdstVMUX1 <= ExMemout(37 downto 22) when sel1DST='0'
--else ExMemout(53 downto 38);
--RdstVMUX3<=RdstVMUX1 when sel2DST='1'
--else RdstVMUX2;
--ALUDEST<= RdstV when sel4DST='0'
--else RdstVMUX3;

sel1DST<=x(2); --source dependency
sel2DST<=x(1)or x(2);
sel3DST<=x(9);
sel4DST<= x(1)or x(2)or x(8)or x(9);

RdstVMUX2<= WBSrcData when sel3DST='1'
else WBDstData;
RdstVMUX1 <= ExMemRsrcV when sel1DST='1'
else ExMemRdstV;
RdstVMUX3<=RdstVMUX1 when sel2DST='1'
else RdstVMUX2;
ALUDEST<= RdstV when sel4DST='0'
else RdstVMUX3;

--TODO: Add Execute Memory register Its output is 65 bits and is declared in entity declaration above
--------------------------------------------------------------------------------------------------------
--ROUT<=RsrcV when  opcode= STDOP --revise design changed
--else ALURES2;

--------------------------------------------------------------------------------------------------------
ROUT<=ALURSRC when  opcode= STDOP --revise design changed
else ALURES2;

ROUT2<=ALUDEST when sel4DST='1'--revise design changed
else RdstV;

EXMEMEN<='1' when stall='0'
 else '0';
cntrlsgmod <=inCtrlSignals when stall='0'
else "00000000000";

ExMemIN<= cntrlsgmod & ExMemSHorLDM & intIndicator &incrementedPC& ROUT& ALURES1 & ROUT2 & Rsrc & Rdst   ;
ExecuteMemoryRegister: entity work.nbitRegister generic map(n=>77) port map(ExMemIN,rst,clk,EXMEMEN,ExMemout);

ExecuteMemory<=ExMemout;
--TODO: Add branch unit here make sure that the opcode you pass to branch unit is fetchDecodeOpcode in entity declaration
--------------------------------------------------------------------------------------------------------------------------------
BranchUnit: entity work.BranchUnit port map(fetchDecodeOpcode,ALUEN,FlagsALU,FlagsREGOUT,branch,flush);
BR<=branch;
------------------------------------Flags
FlagRegister: entity work.nbitRegister generic map(n=>4) port map(FlagsReg,rst,clk,ALUEN,FlagsREGOUT);
---------------------------------------------

--outCtrlSignals <= ExecuteMemory(77 downto 66);
--EXECMEMRET<=cntrlsgmod(8);
EXECMEMRET<=ExMemOut(74);

ExMemSHorLDM<='1' when opcode= SHLCOP or opcode= SHRCOP or opcode=LDMOP
else '0';



end ExecuteStageArch;


