library ieee;
use ieee.std_logic_1164.all;

entity n3_ctl is
	Port(
		OP: in std_logic_vector(2 downto 0);
		S: in std_logic_vector(3 downto 0);
		n3_out: out std_logic);
end n3_ctl;

architecture behav of n3_ctl is
	
	n3_out <= ((not(S(3)) and not(S(2)) and S(1) and not(S(0)) and OP(2) and not(OP(1)) and OP(0)) or 
			   (not(S(3)) and not(S(2)) and S(1) and not(S(0)) and OP(2) and OP(1) and not(OP(0))) or
			   (S(3) and not(S(2)) and not(S(1)) and not(S(0))));

end behav;
