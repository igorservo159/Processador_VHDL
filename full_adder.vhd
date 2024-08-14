library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
	Port(
    a_fa, b_fa, cin_fa	: in std_logic;
    cout_fa, z_fa		: out std_logic);
end full_adder;

architecture behav of full_adder is

begin
  cout_fa <= (a_fa and b_fa) or (a_fa and cin_fa) or (b_fa and cin_fa);
  z_fa <= a_fa xor b_fa xor cin_fa;
end behav;
