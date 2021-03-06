Library ieee;
use ieee.std_logic_1164.all;

Entity FetchStage is
port(

clk: in std_logic;
reset :in std_logic; --signal to load pc with M[0]
int   :in std_logic;
branch:in std_logic; --branch is an out from branch unit
rst   :in std_logic; --external signal to set all registers to 0
--PCen  :in std_logic; --external signal from branch unit required for flushing
ret   :in std_logic; --Signal from execute memory stage to indicate ret or reti
flush :in std_logic; --Signal from branch unit
DECEXRET:in std_logic;--control signal from decode stage bit 8
EXECMEMRET: in std_logic;--control signal from execute stage bit 8

--Data and signals required from early branching
------------------------------------------------
x	   : in std_logic_vector(14 downto 0); --Signal from forwarding unit
ALUResult1 : in std_logic_vector(15 downto 0);
AlUResult2 : in std_logic_vector(15 downto 0);
MemoryData : in std_logic_vector(15 downto 0);
WBSrcData  : in std_logic_vector(15 downto 0); --Output of multiplexer in Memory Stage
WBDstData  : in std_logic_vector(15 downto 0); --Output of multiplexer in Memory Stage

decodedDstData: in std_logic_vector(15 downto 0); --is one of outputs of decoding stage
--from control unit to be used in interrupt----------------
 pushIntrEn: in std_logic; 
 start	   : in  std_logic;
--------------------
---instructionMemoryDataIn: in std_logic_vector(15 downto 0);-- needed for what !!! --
--Output represents fetch decode register values required for the decoding stage

---InstructionMemoryAddressOut: out std_logic_vector(9 downto 0); -- needed for what !!! --
FetchDecodeOutput: out std_logic_vector(36 downto 0);
nextStageEn: inout std_logic; --inout becuase i need to read its value---


------------------
FetDecUSERsrc     : out std_logic;
FetDecUSERdst     : out std_logic;
stall:in std_logic;

FetchDecIOWr: out std_logic --a signal to avoid stalling if there is load followed by out

);
end entity;


Architecture FetchStageArch of FetchStage is



Signal pcinput:	         std_logic_vector(9 downto 0);
Signal pcoutput:         std_logic_vector(9 downto 0);
Signal PCen:             std_logic;
Signal instrMemOut:      std_logic_vector(15 downto 0);
Signal irRst:            std_logic;
Signal IROut:            std_logic_vector(15 downto 0);
Signal Rsrc,Rdst:        std_logic_vector(2 downto 0);
Signal opCode:           std_logic_vector(4 downto 0);
Signal Imm:              std_logic_vector(15 downto 0);
Signal countRst,countEn,countOut:std_logic; 
Signal twoWord:			 std_logic;
Signal FetchDecodeIN:    std_logic_vector(39 downto 0);
Signal FetchDecodeOut:    std_logic_vector(39 downto 0);
signal FetchDecodeEn:   std_logic;
signal indicatorBits: std_logic_vector(2 downto 0);
signal loadedOpcode: std_logic_vector(4 downto 0);

constant outop : std_logic_vector(4 downto 0):="01111";
-------------------------------------------------------------
------------------- Define components -----------------------
-------------------------------------------------------------
 component instrMemory is
  Port(
        clk:in std_logic;
        address:in std_logic_vector(9 downto 0);
        output:out std_logic_vector(15 downto 0)
  );
end component;

component my_nDFF IS
GENERIC ( n : integer := 8);
PORT( Clk,Rst,enb : IN std_logic; -- buf to enable tristate -- en -- to enable reg
		   d : IN std_logic_vector(n-1 DOWNTO 0); 
		   q : INOUT std_logic_vector(n-1 DOWNTO 0));
		
END component;

component Counter IS 
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
    end component;
-------------------------------------------------------------
------------------- End components -----------------------
-------------------------------------------------------------
begin




--PC Controller circuit is responsible for loading PC with correct Value
-------------------------------------------------------------------------
PC          	: entity work.nbitregister generic map(n=>10) port map(pcinput,rst,clk,PCen,pcoutput);
PCController	: entity work.PCController port map(x,int,ret,reset,branch,pcoutput,decodedDstData,ALUResult1,ALUResult2,MemoryData,WBSrcData ,WBDstData,pcinput);
--- instruction memory and IR register ---
------------------------------------------
IM:instrMemory port map (clk,pcoutput,instrMemOut);

--IR:my_nDFF generic map (n=>16)port map(clk,irRst,'1',instrMemOut,IROut);
  
--- 1 bit counter needed in getting EA/Imm ---
-------------------------------------------------------
--count:Counter port map(countRst,countEn,clk,countOut);

--- set pc en ---
PCen<=not( stall); -- check condition --
-- Process(clk,IROut,countEn)
  -- begin
-- --- IR output & setting for the fetch decode buffer ---
-- -------------------------------------------------------
-- irRst<=branch or flush;
-- Rsrc<=IROut(10 downto 8);
-- Rdst<=IROut(8 downto 6);


-- if (branch='0' and  DECEXRET='0' and EXECMEMRET='0' ) then
-- opCode<=IROut(15 downto 11) ;
-- else 
-- opCode<="00000"; --no-operation
-- end if;

-- --TODO : Handle instructions that shall be loaded on two times
-- --These are LDM - LDD - SHL -SHR - STD
-- if(opCode="11101" or opCode="11110" or opCode="01001" or opCode="01010" or opCode="11100" )then
-- nextStageEn<='1';
-- countEn<='1';
-- countRst<='1';
-- else 
-- nextStageEn<='0';
-- countEn<='0';
-- end if;

-- if(nextStageEn='0' and countOut='1')then
-- Imm<=IROut;
-- elsif(rising_edge(clk))then
-- Imm<=(others=>'0');
-- end if;
-- --TODO:Create Fetch decode Register of 37 bits and map its output to fetch decode output in entity declararation
-- if(rising_edge(clk))then 
-- FetchDecodeOutput(36 downto 0)<= pcinput & opcode & Rsrc & Rdst & Imm;
-- FetDecUSERsrc<=instrMemOut(1);
-- FetDecUSERdst<=instrMemOut(2);

-- end if;

--opcode<="00000" when(branch='1' or  DECEXRET='1' or EXECMEMRET='1' ) else instrMemOut(15 downto 11);
FetchDecodeEn<= not stall;
opcode <= instrMemOut(15 downto 11) when twoword='0' else FetchDecodeOut(29 downto 25); 
Rsrc<=instrMemOut(10 downto 8) when twoword='0' else FetchDecodeOut(24 downto 22);
Rdst<=instrMemOut(7 downto 5) when twoword='0' else  FetchDecodeOut(21 downto 19);
Imm<=instrMemOut when twoword='1' else (others=>'0');
indicatorbits<=instrMemOut(2 downto 0) when twoword='0' else "000";
loadedopcode<="00000" when branch='1' else opcode;
FetchDecodeIN<= pcinput & loadedopcode & Rsrc & Rdst & Imm & indicatorbits;
FetchDecodeRegister: entity work.nbitRegister generic map(n=>40) port map(FetchDecodeIN,rst,clk,FetchDecodeEn,FetchDecodeOut);
FetDecUSERsrc<=FetchDecodeOut(1);
FetDecUSERdst<=FetchDecodeOut(2);
FetchDecodeOutput<=FetchDecodeOut(39 downto 3);
twoWord<=FetchDecodeOut(0);

nextStageEn<=twoWord;
FetchDecIOWr<='1' when opcode=outop else '0';
--Set T and interrupt indicator in decodeexecute register mapping section in DEcode Stage.vhdl



--end process;
end FetchStageArch;
