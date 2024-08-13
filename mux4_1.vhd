library ieee;
use ieee.std_logic_1164.all;

entity mux4_1 is
	Port(
        a_mux4, b_mux4, c_mux4: in std_logic_vector(15 downto 0);
        s1_mux4, s0_mux4: in std_logic;
        d_mux4: out std_logic_vector(15 downto 0));
end mux4_1;

architecture behav of mux4_1 is
begin
    d_mux4 <= (c_mux4 and not s1_mux4 and not s0_mux4)
           or (b_mux4 and not s1_mux4 and  s0_mux4)
           or (a_mux4 and s1_mux4 and not s0_mux4);
end behav;
