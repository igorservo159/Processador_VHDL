library ieee;
use ieee.std_logic_1164.all;

entity n_ctl is
	Port(
		OP_n: in std_logic_vector(3 downto 0);
		S_n: in std_logic_vector(3 downto 0);
		RP_zero_n: in std_logic;
		N_out: out std_logic_vector(3 downto 0));
end n_ctl;

architecture behav of n_ctl is
	begin

	N_out(0) <= ((not(S_n(3)) and not(S_n(2)) and not(S_n(1)) and not(S_n(0))) or 
			   (not(S_n(3)) and not(S_n(2)) and S_n(1) and not(S_n(0)) and not(OP_n(2)) and not(OP_n(0))) or
			   (not(S_n(3)) and not(S_n(2)) and S_n(1) and not(S_n(0)) and OP_n(2) and not(OP_n(1)) and not(OP_n(0))) or
			   (not(S_n(3)) and not(S_n(2)) and S_n(1) and S_n(0)) or
			   (not(S_n(3)) and S_n(2)) or 
			   (S_n(3)));

	N_out(1) <= ((not(S_n(3)) and not(S_n(2)) and not(S_n(1)) and S_n(0)) or 
				(not(S_n(3)) and not(S_n(2)) and S_n(1) and not(S_n(0)) and not(OP_n(2)) and not(OP_n(1)) and not(OP_n(0))) or
				(not(S_n(3)) and not(S_n(2)) and S_n(1) and not(S_n(0)) and not(OP_n(2)) and OP_n(1) and OP_n(0)) or
				(not(S_n(3)) and not(S_n(2)) and S_n(1) and not(S_n(0)) and OP_n(2) and not(OP_n(1)) and not(OP_n(0))) or
			    (not(S_n(3)) and not(S_n(2)) and S_n(1) and not(S_n(0)) and OP_n(2) and OP_n(1) and not(OP_n(0))));

	N_out(2) <= ((not(S_n(3)) and not(S_n(2)) and S_n(1) and not(S_n(0)) and not(OP_n(2)) and OP_n(1)) or 
			    (not(S_n(3)) and not(S_n(2)) and S_n(1) and not(S_n(0)) and not(OP_n(2)) and not(OP_n(1)) and OP_n(0)) or
			    (not(S_n(3)) and not(S_n(2)) and S_n(1) and not(S_n(0)) and OP_n(2) and not(OP_n(1)) and not(OP_n(0))));

	N_out(3) <= ((not(S_n(3)) and not(S_n(2)) and S_n(1) and not(S_n(0)) and OP_n(2) and not(OP_n(1)) and OP_n(0)) or 
				(not(S_n(3)) and not(S_n(2)) and S_n(1) and not(S_n(0)) and OP_n(2) and OP_n(1) and not(OP_n(0))) or
				(S_n(3) and not(S_n(2)) and not(S_n(1)) and not(S_n(0)) and RP_zero_n));
	
end behav;
