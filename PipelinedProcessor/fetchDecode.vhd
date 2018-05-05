
Library ieee;
use ieee.std_logic_1164.all;

entity processorfd is
Port(

reset: in std_logic; --external reset signal
clk:   in std_logic; 
int:   in std_logic; --external interrupt signal
rst:   in std_logic; --external signal for loading all registers with zeros

--instructionMemIn: in std_logic_vector(15 downto 0);
--DataMemoryIn:     in std_logic_vector(15 downto 0);

portInput:        in std_logic_vector(15 downto 0)







);

end entity;


Architecture processorArch of processorfd is

--Signal from Execute

---Branch Signals From Execution 

SIGNAL Branch,Flush:std_logic;
SIGNAL ALUResult1 :  std_logic_vector(15 downto 0);
SIGNAL AlUResult2 :  std_logic_vector(15 downto 0);
--------------------
SIGNAL outCtrlSignals:  std_logic_vector(10 downto 0);
SIGNAL ExecuteMemory:   std_logic_vector(76 downto 0);
SIGNAL OutportOutput:  std_logic_vector(15 downto 0);

----Signals from Forwarding unit
SIGNAL x:std_logic_vector(14 downto 0);
SIGNAL stall: std_logic;

------------Signals in Memory Stage 
SIGNAL WBSrcData  :  std_logic_vector(15 downto 0); --Output of multiplexer in Memory Stage
SIGNAL WBDstData  :  std_logic_vector(15 downto 0); --Output of multiplexer in Memory Stage
SIGNAL MemoryData : std_logic_vector(15 downto 0);
SIGNAL outCtrlSignalsMem:  std_logic_vector(2 downto 0);
SIGNAL Address:     std_logic_vector( 9 downto 0);
SIGNAL ret:std_logic; --dont know where to find it


SIGNAL RsrcVal: std_logic_vector(2 downto 0);
SIGNAL RdstVal: std_logic_vector(2 downto 0);
SIGNAL intIndicator	:  std_logic;
------- Signals From decode Stage 
SIGNAL decodedDstData:  std_logic_vector(15 downto 0);
SIGNAL FetchDecodeOutput: std_logic_vector(36 downto 0);--output from fetch input to decode
SIGNAL pushIntrEn:  std_logic;
SIGNAL start	   :  std_logic;
----------------------------------------------------------
SIGNAL CtrlSignals :  std_logic_vector(10 downto 0);
SIGNAL decodedDstD : std_logic_vector(15 downto 0); --Decoded data required for branching and will be needed by fetch stage
SIGNAL DecodeExecute:  std_logic_vector(66 downto 0);
SIGNAL FetchDecodeOpcode:  std_logic_vector( 4 downto 0); --needed for branch unit

--------------no idea where to get it  in fetch stage s
SIGNAL nextStageEn:std_logic;
SIGNAL DECEXRET: std_logic;--control signal from decode stage bit 8
SIGNAL EXECMEMRET:  std_logic;--control signal from execute stage bit 8

-----------Signals for write back 
SIGNAL WriteBack:  std_logic_vector(41 downto 0);
SIGNAL outCtrlSignalsWB:std_logic_vector( 2 downto 0);
-----------------------
Signal ack:std_logic;
Signal updated:std_logic;

----------------------Forwarding unit control signals------------------------

Signal FetDecRsrc:  std_logic_vector(2 downto 0);
Signal FetDecRdst:  std_logic_vector(2 downto 0);
Signal DecExRsrc :   std_logic_vector(2 downto 0);
Signal DecExRdst :   std_logic_vector(2 downto 0);
Signal ExMemRsrc :  std_logic_vector(2 downto 0);
Signal ExMemRdst :  std_logic_vector(2 downto 0);
Signal MemWBRsrc :  std_logic_vector(2 downto 0);
Signal MemWBRdst :  std_logic_vector(2 downto 0);
Signal FetDecUSERsrc     :  std_logic;
Signal FetDecUSERdst     :  std_logic;
Signal DecExSHorLDM	  : std_logic;
Signal ExMemSHorLDM	  :  std_logic;

Signal ExMemWBDst        :  std_logic;
Signal ExMemWBSrc        :  std_logic;
Signal ExMemMemWrite     :  std_logic;
Signal DecExMemRead      :  std_logic;
Signal DecExWBDst        :  std_logic;
Signal DecExWBSrc        :  std_logic;



----------Prot input signal
SIGNAL PortIN:std_logic_vector(15 downto 0);



begin

--TODO
--------------forwarding unit signals
FetDecRsrc<=FetchDecodeOutput   (21 downto 19);
FetDecRdst <=FetchDecodeOutput  (18 downto 16);
DecExRsrc<=DecodeExecute(10 downto 8);
DecExRdst<= DecodeExecute(7 downto 5) ;
ExMemRsrc<=ExecuteMemory(5 downto 3);
ExMemRdst<=ExecuteMemory (2 downto 0);
MemWBRsrc<=RsrcVal;
MemWBRdst<=RdstVal;
ExMemSHorLDM<=ExecuteMemory(65);
DecExSHorLDM<=DecodeExecute(55);

outCtrlSignals<=  ExecuteMemory(76 downto 66);
CtrlSignals<=DecodeExecute(66 downto 56);

ExMemWBDst<=outCtrlSignals(0);
ExMemWBSrc<=outCtrlSignals(1);
DecExWBDst<=CtrlSignals(0);
DecExWBSrc<=CtrlSignals(1);
ExMemMemWrite<=outCtrlSignals (3);
DecExMemRead <=CtrlSignals (2);







-------
--Create an instance of forwarding unit


--Create instances for the stages of fetch- decode - execute -memory -wb stages
FetchStage: entity work.FetchStage port map(clk,reset,int,Branch,rst,ret,Flush,DECEXRET,EXECMEMRET,x,ALUResult1,AlUResult2,MemoryData,WBSrcData,WBDstData,decodedDstData,pushIntrEn,start,FetchDecodeOutput,nextStageEn,FetDecUSERsrc,FetDecUSERdst,stall);
DecodeStage: entity work.DecodeStage port map(clk,reset,int,ack,Branch,updated,rst,FetchDecodeOutput,WriteBack(38 downto 0),WriteBack(41 downto 39),PortIN,nextStageEn,decodedDstD,DecodeExecute,FetchDecodeOpcode,pushIntrEn,start,DECEXRET,EXECMEMRET,stall);

--Declare signals for all connections (rabena m3aki :D :D)

--After that Create a file for the interface of the processor with instruction memory and data memory as well as input port
--Instruction memory is in file instructionmemory.vhdl(sob7an allah) w datamemory is in file (ram.vhdl)

end processorArch;