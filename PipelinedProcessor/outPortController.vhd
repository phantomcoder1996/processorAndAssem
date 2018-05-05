Library ieee;
use ieee.std_logic_1164.all;


Entity outPortController is

Port(
RSrcV: in std_logic_vector(15 downto 0); --from decode execute stage
ExMemRdstV: in std_logic_vector(15 downto 0); --This represents the output of multiplexer of dst value in memory stage
--MemoryData: in std_logic_vector(15 downto 0);
ExMemRsrcV: in std_logic_vector(15 downto 0); --This represents the output of multiplexer of src value in memory stage
WBDstData: in std_logic_vector(15 downto 0);
WBSrcData: in std_logic_vector(15 downto 0);

x: in std_logic_vector(14 downto 0); --from forwarding unit

--ExMemMemRead: in std_logic; --Ctrl signal to show that the instruction in memory stage is using the memory or not

outPortInput: out std_logic_vector(15 downto 0)
);
end Entity;




Architecture outPortControllerArch of outPortController is

Signal normal_forwarded_sel : std_logic;
Signal memoryWBSel	    : std_logic;
Signal exmemSel	    : std_logic;
Signal WBSrcSel	 	    : std_logic;

Signal forwardedData	    : std_logic_vector(15 downto 0);
Signal memforwarded	    : std_logic_vector(15 downto 0);
Signal WBforwarded	    : std_logic_vector(15 downto 0);


begin


--Selection lines control
-------------------------
normal_forwarded_sel	    <= '1' when x(0)='1' or x(3)='1' or x(10)='1' or x(7)='1' else '0';
memoryWBSel		    <= '1' when x(0)='1' or x(3)='1' else '0';
exmemSel		    <= '1' when x(0)='1' else '0';
WBSrcSel		    <= '1' when x(10)='1' else '0';

outPortInput		    <= forwardedData when normal_forwarded_sel = '1' else RsrcV;
forwardedData		    <= memforwarded  when memoryWBSel='1' else WBforwarded;
WBforwarded		    <= WBSrcData     when WBSrcSel='1' else WBDstData;
memforwarded		    <= ExMemRdstV    when exmemSel='1' else ExMemRsrcV;


end OutPortControllerArch;
