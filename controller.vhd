library ieee;
use ieee.std_logic_1164.all;

entity controller is
	Port(
		x, y, z 	: in std_logic;
		A, B 		: in std_logic_vector(3 downto 0);
		S			: out std_logic_vector(3 downto 0));
end controller;
