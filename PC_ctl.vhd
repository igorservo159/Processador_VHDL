library ieee;
use ieee.std_logic_1164.all;

entity PC_ctl is
	Port(
		S_PC: in std_logic_vector(3 downto 0);
		PC_out: out std_logic_vector(2 downto 0));
end PC_ctl;

architecture behav of PC_ctl is
	begin

	PC_out(0) <= S_PC(3) and not(S_PC(2)) and not(S_PC(1)) and S_PC(0); 

	PC_out(1) <= not(S_PC(3)) and not(S_PC(2)) and not(S_PC(1)) and S_PC(0);
				  
	PC_out(2) <= not(S_PC(3)) and not(S_PC(2)) and not(S_PC(1)) and not(S_PC(0));

end behav;
