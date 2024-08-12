library ieee;
use ieee.std_logic_1164.all;

entity shifter_2 is
	Port(
		sh2: in std_logic;
		A_sh2: in std_logic_vector(15 downto 0);
		A_shifted_sh2: out std_logic_vector(15 downto 0));
end shifter_2;

architecture behav of shifter_2 is

	component mux is
		Port(
			a_mux, b_mux: in std_logic;
			s_mux: in std_logic;
			c_mux: out std_logic);
  	end component;

begin

	m0 : mux port map(a_mux=>A_sh2(0), b_mux=> '0', s_mux=>(sh2), c_mux=>A_shifted_sh2(0));
	m1 : mux port map(a_mux=>A_sh2(1), b_mux=> '0', s_mux=>(sh2), c_mux=>A_shifted_sh2(1));
	m2 : mux port map(a_mux=>A_sh2(2), b_mux=>A_sh2(0), s_mux=>(sh2), c_mux=>A_shifted_sh2(2));
	m3 : mux port map(a_mux=>A_sh2(3), b_mux=>A_sh2(1), s_mux=>(sh2), c_mux=>A_shifted_sh2(3));
	m4 : mux port map(a_mux=>A_sh2(4), b_mux=>A_sh2(2), s_mux=>(sh2), c_mux=>A_shifted_sh2(4));
	m5 : mux port map(a_mux=>A_sh2(5), b_mux=>A_sh2(3), s_mux=>(sh2), c_mux=>A_shifted_sh2(5));
	m6 : mux port map(a_mux=>A_sh2(6), b_mux=>A_sh2(4), s_mux=>(sh2), c_mux=>A_shifted_sh2(6));
	m7 : mux port map(a_mux=>A_sh2(7), b_mux=>A_sh2(5), s_mux=>(sh2), c_mux=>A_shifted_sh2(7));
	m8 : mux port map(a_mux=>A_sh2(8), b_mux=>A_sh2(6), s_mux=>(sh2), c_mux=>A_shifted_sh2(8));
	m9 : mux port map(a_mux=>A_sh2(9), b_mux=>A_sh2(7), s_mux=>(sh2), c_mux=>A_shifted_sh2(9));
	m10 : mux port map(a_mux=>A_sh2(10), b_mux=>A_sh2(8), s_mux=>(sh2), c_mux=>A_shifted_sh2(10));
	m11 : mux port map(a_mux=>A_sh2(11), b_mux=>A_sh2(9), s_mux=>(sh2), c_mux=>A_shifted_sh2(11));
	m12 : mux port map(a_mux=>A_sh2(12), b_mux=>A_sh2(10), s_mux=>(sh2), c_mux=>A_shifted_sh2(12));
	m13 : mux port map(a_mux=>A_sh2(13), b_mux=>A_sh2(11), s_mux=>(sh2), c_mux=>A_shifted_sh2(13));
	m14 : mux port map(a_mux=>A_sh2(14), b_mux=>A_sh2(12), s_mux=>(sh2), c_mux=>A_shifted_sh2(14));
	m15 : mux port map(a_mux=>A_sh2(15), b_mux=>A_sh2(13), s_mux=>(sh2), c_mux=>A_shifted_sh2(15));
	
end behav;
