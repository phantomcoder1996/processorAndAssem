Library ieee;
use ieee.std_logic_1164.all;

Entity BranchUnit is
Port(

--you need that opcode to check on jump opcodes (These opcodes will be in fetch decode register)
opcode: in std_logic_vector(4 downto 0);

DecExAluEn: in std_logic; --This signal comes from control signals of Dec Ex buffer

ALUFlags  : in std_logic_vector(3 downto 0); --These are the AlUFlags that are on the wires and not saved yet in flag register
FlagReg   : in std_logic_vector(3 downto 0); --This are the values of the flags in the flag register

Branch : out std_logic;
flush: out std_logic



);

end entity;


Architecture BranchUnitArch of BranchUnit is

SIGNAL BRANCHH,BRANCHZERO,BRANCHN,BRACHC,call,Ret,RETI:std_logic;
SIGNAl FlagtoBeused: std_logic_vector(3 downto 0);
begin

FlagtoBeused<= ALUFlags when DecExAluEn='1' 
 else FlagReg;

BRANCHH <= '1' when(opcode="11000")
else '0' ;

call<='1' when(opcode="11001")
else '0';

Ret<='1' when(opcode="11010")
else '0';

RETI<='1' when(opcode="11011")
else '0';

BRANCHZERO <= '1' when opcode="10101" and FlagtoBeused(3)='1'
else '0';

BRANCHN<= '1' when opcode="10110" and FlagtoBeused(1)='1'
else '0';

BRACHC<= '1' when opcode="10111"and FlagtoBeused(2)='1'
else '0';

flush<=  Ret or RETI
Branch<= BRANCHH or BRANCHZERO or BRANCHN or BRACHC or call   ;

-----not sure------------------------------
---- Branch <= BRANCHH or call or Ret or  RETI or flush ;
--TODO: Unconditional jmps should generate signal branch in all cases as well as the call instruction

--TODO: As for conditional jmps if( aluen='1' then check on ALU flags else check on flag register)


-- PCen signal which is input to the fetch stage is used to contol whether pc will be enabled or not for purpose of flushing
--Generate that signal as output from branch unit and adjust the flushing in all stages files


end BranchUnitArch;

