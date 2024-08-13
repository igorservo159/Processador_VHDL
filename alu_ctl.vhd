library ieee;
use ieee.std_logic_1164.all;

entity alu_ctl is
	Port(
		S_alu: in std_logic_vector(3 downto 0);
		alu_s1s0: out std_logic_vector(1 downto 0));
end alu_ctl;

architecture behav of alu_ctl is
	begin

	alu_s1s0(0) <= (not(S_alu(3)) and S_alu(2) and not(S_alu(1)) and S_alu(0)) or 
			    (S_alu(3) and not(S_alu(2)) and S_alu(1) and not(S_alu(0)));

	alu_s1s0(1) <= (not(S_alu(3)) and S_alu(2) and S_alu(1) and S_alu(0)) or 
			    (S_alu(3) and not(S_alu(2)) and S_alu(1) and not(S_alu(0)));
				
end behav;
