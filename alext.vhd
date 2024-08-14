library ieee;
use ieee.std_logic_1164.all;

entity alext is
	Port(
		x_al, y_al 	: in std_logic;
		a_al, b_al	: in std_logic;
		ia_al, ib_al	: out std_logic);
end alext;

architecture behav of alext is
	
begin

	ia_al <= a_al;
	ib_al <= (not x_al and y_al and b_al) or (x_al and not y_al and not(b_al));
	
end behav;
