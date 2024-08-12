library ieee;
use ieee.std_logic_1164.all;

entity n1_ctl is
	Port(
		OP: in std_logic_vector(2 downto 0);
		S: in std_logic_vector(3 downto 0);
		n1_out: out std_logic);
end n1_ctl;

architecture behav of n1_ctl is
	
	n1_out <= ((not(S(3)) and not(S(2)) and not(S(1)) and S(0)) or 
			   (not(S(3)) and not(S(2)) and S(1) and not(S(0)) and not(OP(2)) and (OP(1) xnor OP(0))) or
			   (not(S(3)) and not(S(2)) and S(1) and not(S(0)) and OP(2) and not(OP(0))));
	
end behav;
