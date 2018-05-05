Entity RegisterFile is 

Port(

clk: in std_logic;

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

Signal WBDstDecoderOutput: std_logic_vector(7 downto 0);
Signal WBSrcDecoderOutput: std_logic_vector(7 downto 0);
Signal FDDstDecoderOutput: std_logic_vector(7 downto 0);
Signal FDSrcDecoderOutput: std_logic_vector(7 downto 0);

Signal AluLeftBus	 : std_logic_vector(15 downto 0);
Signal AluRightBus	 : std_logic_vector(15 downto 0);

Signal RegisterOutputs   

begin


WBDestDecoder: entity work.decoder generic map(n => 3) port map( WBDst, WBRDst, WBDstDecoderOutput);
WBSrcDecoder : entity work.decoder generic map(n => 3) port map( WBSrc, WBRSrc, WBSrcDecoderOutput);

FDDestDecoder: entity work.decoder generic map(n => 3) port map( '1', FDRDst, FDDstDecoderOutput);
FDSrcDecoder : entity work.decoder generic map(n => 3) port map( '1', FDRSrc, FDSrcDecoderOutput);


RegistersGenerator: for i in 0 to 6 generate

--Reg: nbitregister generic map( n => 15 ) port map( );


end generate;







end RegisterFileArch;
