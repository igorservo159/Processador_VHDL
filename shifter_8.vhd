library ieee;
use ieee.std_logic_1164.all;

entity shifter_8 is
	Port(
    sh8      : in std_logic;
    A_sh8	    : in std_logic_vector(15 downto 0);
    A_shifted_sh8	: out std_logic_vector(15 downto 0));
end shifter_8;

architecture behav of shifter_8 is

	component mux is
		Port(
      a_mux, b_mux : in std_logic;
      s_mux    : in std_logic;
      c_mux	   : out std_logic);
  end component;

begin

	m0 : mux port map(a_mux=>A_sh8(0), b_mux=> '0', s_mux=>(sh8), c_mux=>A_shifted_sh8(0));
	m1 : mux port map(a_mux=>A_sh8(1), b_mux=> '0', s_mux=>(sh8), c_mux=>A_shifted_sh8(1));
	m2 : mux port map(a_mux=>A_sh8(2), b_mux=> '0', s_mux=>(sh8), c_mux=>A_shifted_sh8(2));
	m3 : mux port map(a_mux=>A_sh8(3), b_mux=> '0', s_mux=>(sh8), c_mux=>A_shifted_sh8(3));
	m4 : mux port map(a_mux=>A_sh8(4), b_mux=> '0', s_mux=>(sh8), c_mux=>A_shifted_sh8(4));
	m5 : mux port map(a_mux=>A_sh8(5), b_mux=> '0', s_mux=>(sh8), c_mux=>A_shifted_sh8(5));
	m6 : mux port map(a_mux=>A_sh8(6), b_mux=> '0', s_mux=>(sh8), c_mux=>A_shifted_sh8(6));
	m7 : mux port map(a_mux=>A_sh8(7), b_mux=> '0', s_mux=>(sh8), c_mux=>A_shifted_sh8(7));
	m8 : mux port map(a_mux=>A_sh8(8), b_mux=>A_sh8(0), s_mux=>(sh8), c_mux=>A_shifted_sh8(8));
	m9 : mux port map(a_mux=>A_sh8(9), b_mux=>A_sh8(1), s_mux=>(sh8), c_mux=>A_shifted_sh8(9));
	m10 : mux port map(a_mux=>A_sh8(10), b_mux=>A_sh8(2), s_mux=>(sh8), c_mux=>A_shifted_sh8(10));
	m11 : mux port map(a_mux=>A_sh8(11), b_mux=>A_sh8(3), s_mux=>(sh8), c_mux=>A_shifted_sh8(11));
	m12 : mux port map(a_mux=>A_sh8(12), b_mux=>A_sh8(4), s_mux=>(sh8), c_mux=>A_shifted_sh8(12));
	m13 : mux port map(a_mux=>A_sh8(13), b_mux=>A_sh8(5), s_mux=>(sh8), c_mux=>A_shifted_sh8(13));
	m14 : mux port map(a_mux=>A_sh8(14), b_mux=>A_sh8(6), s_mux=>(sh8), c_mux=>A_shifted_sh8(14));
	m15 : mux port map(a_mux=>A_sh8(15), b_mux=>A_sh8(7), s_mux=>(sh8), c_mux=>A_shifted_sh8(15));
	
end behav;
