library ieee;
use ieee.std_logic_1164.all;

entity mux is
	Port(
    a_mux, b_mux : in std_logic;
    s_mux    : in std_logic;
    c_mux	   : out std_logic);
end mux;

architecture behav of mux is
begin
	c <= (a_mux and not s_mux) or (b_mux and s_mux);
end behav;
