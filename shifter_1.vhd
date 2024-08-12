library ieee;
use ieee.std_logic_1164.all;

entity shifter_1 is
	Port(
		sh1: in std_logic;
		A_sh1: in std_logic_vector(15 downto 0);
		A_shifted_sh1: out std_logic_vector(15 downto 0));
end shifter_1;

architecture behav of shifter_1 is

	component mux is
		Port(
			a_mux, b_mux : in std_logic;
			s_mux: in std_logic;
			c_mux: out std_logic);
  	end component;

begin

	m0 : mux port map(a_mux=>A_sh1(0), b_mux=> '0', s_mux=>(sh1), c_mux=>A_shifted_sh1(0));
	m1 : mux port map(a_mux=>A_sh1(1), b_mux=>A_sh1(0), s_mux=>(sh1), c_mux=>A_shifted_sh1(1));
	m2 : mux port map(a_mux=>A_sh1(2), b_mux=>A_sh1(1), s_mux=>(sh1), c_mux=>A_shifted_sh1(2));
	m3 : mux port map(a_mux=>A_sh1(3), b_mux=>A_sh1(2), s_mux=>(sh1), c_mux=>A_shifted_sh1(3));
	m4 : mux port map(a_mux=>A_sh1(4), b_mux=>A_sh1(3), s_mux=>(sh1), c_mux=>A_shifted_sh1(4));
	m5 : mux port map(a_mux=>A_sh1(5), b_mux=>A_sh1(4), s_mux=>(sh1), c_mux=>A_shifted_sh1(5));
	m6 : mux port map(a_mux=>A_sh1(6), b_mux=>A_sh1(5), s_mux=>(sh1), c_mux=>A_shifted_sh1(6));
	m7 : mux port map(a_mux=>A_sh1(7), b_mux=>A_sh1(6), s_mux=>(sh1), c_mux=>A_shifted_sh1(7));
	m8 : mux port map(a_mux=>A_sh1(8), b_mux=>A_sh1(7), s_mux=>(sh1), c_mux=>A_shifted_sh1(8));
	m9 : mux port map(a_mux=>A_sh1(9), b_mux=>A_sh1(8), s_mux=>(sh1), c_mux=>A_shifted_sh1(9));
	m10 : mux port map(a_mux=>A_sh1(10), b_mux=>A_sh1(9), s_mux=>(sh1), c_mux=>A_shifted_sh1(10));
	m11 : mux port map(a_mux=>A_sh1(11), b_mux=>A_sh1(10), s_mux=>(sh1), c_mux=>A_shifted_sh1(11));
	m12 : mux port map(a_mux=>A_sh1(12), b_mux=>A_sh1(11), s_mux=>(sh1), c_mux=>A_shifted_sh1(12));
	m13 : mux port map(a_mux=>A_sh1(13), b_mux=>A_sh1(12), s_mux=>(sh1), c_mux=>A_shifted_sh1(13));
	m14 : mux port map(a_mux=>A_sh1(14), b_mux=>A_sh1(13), s_mux=>(sh1), c_mux=>A_shifted_sh1(14));
	m15 : mux port map(a_mux=>A_sh1(15), b_mux=>A_sh1(14), s_mux=>(sh1), c_mux=>A_shifted_sh1(15));
	
end behav;
