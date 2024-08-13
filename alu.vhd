library ieee;
use ieee.std_logic_1164.all;

entity alu is
	Port(
		x, y: in std_logic;
		A, B: in std_logic_vector(15 downto 0);
		S: out std_logic_vector(15 downto 0));
end alu;

architecture behav of alu is

	signal IA, IB: std_logic_vector(15 downto 0);
	signal cin, cout: std_logic;
	
	component barrel_shifter is
		port(
			x_bs, y_bs: in std_logic;
			A_bs: in std_logic_vector(15 downto 0);
			B_bs: in std_logic_vector(3 downto 0);
			A_shifted_bs: out std_logic_vector(15 downto 0));
	end component;

	component alext is
		Port(
			x_al, y_al: in std_logic;
			a_al, b_al: in std_logic;
			ia_al, ib_al: out std_logic);
		end component;
	
	component somador16 is
		port(
			A_s16, B_s16: in std_logic_vector(15 downto 0);
			cin_s16: in std_logic;
			cout_s16: out std_logic;
			Z_s16: out std_logic_vector(15 downto 0));
	end component;
	
begin

  	bs : barrel_shifter port map(x_bs=>x, y_bs=>y, A_bs=>A, B_bs=>B, A_shifted_bs=>A);

	-- extensão AL
	u0 : alext port map(x_al=>x, y_al=>y, a_al=>A(0), b_al=>B(0), ia_al=>IA(0), ib_al=>IB(0));
	u1 : alext port map(x_al=>x, y_al=>y, a_al=>A(1), b_al=>B(1), ia_al=>IA(1), ib_al=>IB(1));
	u2 : alext port map(x_al=>x, y_al=>y, a_al=>A(2), b_al=>B(2), ia_al=>IA(2), ib_al=>IB(2));
	u3 : alext port map(x_al=>x, y_al=>y, a_al=>A(3), b_al=>B(3), ia_al=>IA(3), ib_al=>IB(3));
	u4 : alext port map(x_al=>x, y_al=>y, a_al=>A(4), b_al=>B(4), ia_al=>IA(4), ib_al=>IB(4));
	u5 : alext port map(x_al=>x, y_al=>y, a_al=>A(5), b_al=>B(5), ia_al=>IA(5), ib_al=>IB(5));
	u6 : alext port map(x_al=>x, y_al=>y, a_al=>A(6), b_al=>B(6), ia_al=>IA(6), ib_al=>IB(6));
	u7 : alext port map(x_al=>x, y_al=>y, a_al=>A(7), b_al=>B(7), ia_al=>IA(7), ib_al=>IB(7));
	u8 : alext port map(x_al=>x, y_al=>y, a_al=>A(8), b_al=>B(8), ia_al=>IA(8), ib_al=>IB(8));
	u9 : alext port map(x_al=>x, y_al=>y, a_al=>A(9), b_al=>B(9), ia_al=>IA(9), ib_al=>IB(9));
	u10 : alext port map(x_al=>x, y_al=>y, a_al=>A(10), b_al=>B(10), ia_al=>IA(10), ib_al=>IB(10));
	u11 : alext port map(x_al=>x, y_al=>y, a_al=>A(11), b_al=>B(11), ia_al=>IA(11), ib_al=>IB(11));
	u12 : alext port map(x_al=>x, y_al=>y, a_al=>A(12), b_al=>B(12), ia_al=>IA(12), ib_al=>IB(12));
	u13 : alext port map(x_al=>x, y_al=>y, a_al=>A(13), b_al=>B(13), ia_al=>IA(13), ib_al=>IB(13));
	u14 : alext port map(x_al=>x, y_al=>y, a_al=>A(14), b_al=>B(14), ia_al=>IA(14), ib_al=>IB(14));
	u15 : alext port map(x_al=>x, y_al=>y, a_al=>A(15), b_al=>B(15), ia_al=>IA(15), ib_al=>IB(15));
	
	cin <= x and not y;
	
	-- Somador de 6 bits
	
	s0 : somador16 port map(A_s16=>IA, B_s16=>IB, cin_s16=>cin, cout_s16=>cout, Z_s16=>S);
	
end behav;
