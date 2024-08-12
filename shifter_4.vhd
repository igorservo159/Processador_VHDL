library ieee;
use ieee.std_logic_1164.all;

entity shifter_4 is
	Port(
    sh4      : in std_logic;
    A_sh4	    : in std_logic_vector(15 downto 0);
    A_shifted_sh4	: out std_logic_vector(15 downto 0));
end shifter_4;

architecture behav of shifter_4 is

	component mux is
		Port(
      a_mux, b_mux : in std_logic;
      s_mux    : in std_logic;
      c_mux	   : out std_logic);
  end component;

begin

	m0 : mux port map(a_mux=>A_sh4(0), b_mux=> '0', s_mux=>(sh4), c_mux=>A_shifted_sh4(0));
	m1 : mux port map(a_mux=>A_sh4(1), b_mux=> '0', s_mux=>(sh4), c_mux=>A_shifted_sh4(1));
	m2 : mux port map(a_mux=>A_sh4(2), b_mux=> '0', s_mux=>(sh4), c_mux=>A_shifted_sh4(2));
	m3 : mux port map(a_mux=>A_sh4(3), b_mux=> '0', s_mux=>(sh4), c_mux=>A_shifted_sh4(3));
	m4 : mux port map(a_mux=>A_sh4(4), b_mux=>A_sh4(0), s_mux=>(sh4), c_mux=>A_shifted_sh4(4));
	m5 : mux port map(a_mux=>A_sh4(5), b_mux=>A_sh4(1), s_mux=>(sh4), c_mux=>A_shifted_sh4(5));
	m6 : mux port map(a_mux=>A_sh4(6), b_mux=>A_sh4(2), s_mux=>(sh4), c_mux=>A_shifted_sh4(6));
	m7 : mux port map(a_mux=>A_sh4(7), b_mux=>A_sh4(3), s_mux=>(sh4), c_mux=>A_shifted_sh4(7));
	m8 : mux port map(a_mux=>A_sh4(8), b_mux=>A_sh4(4), s_mux=>(sh4), c_mux=>A_shifted_sh4(8));
	m9 : mux port map(a_mux=>A_sh4(9), b_mux=>A_sh4(5), s_mux=>(sh4), c_mux=>A_shifted_sh4(9));
	m10 : mux port map(a_mux=>A_sh4(10), b_mux=>A_sh4(6), s_mux=>(sh4), c_mux=>A_shifted_sh4(10));
	m11 : mux port map(a_mux=>A_sh4(11), b_mux=>A_sh4(7), s_mux=>(sh4), c_mux=>A_shifted_sh4(11));
	m12 : mux port map(a_mux=>A_sh4(12), b_mux=>A_sh4(8), s_mux=>(sh4), c_mux=>A_shifted_sh4(12));
	m13 : mux port map(a_mux=>A_sh4(13), b_mux=>A_sh4(9), s_mux=>(sh4), c_mux=>A_shifted_sh4(13));
	m14 : mux port map(a_mux=>A_sh4(14), b_mux=>A_sh4(10), s_mux=>(sh4), c_mux=>A_shifted_sh4(14));
	m15 : mux port map(a_mux=>A_sh4(15), b_mux=>A_sh4(11), s_mux=>(sh4), c_mux=>A_shifted_sh4(15));
	
end behav;
