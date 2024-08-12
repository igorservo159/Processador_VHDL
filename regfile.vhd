library ieee;
use ieee.std_logic_1164.all;

entity regfile is
	Port(
		clk		: in std_logic;
		W_data	: in std_logic_vector(15 downto 0);
		W_addr	: in std_logic_vector(3 downto 0);
		W_en		: in std_logic;
		R_addr	: in std_logic_vector(3 downto 0);
		R_en		: in std_logic;
		R_data	: out std_logic_vector(15 downto 0));
end regfile;

architecture behav of regfile is
	type tmp_array is array(0 to 15) of std_logic_vector(15 downto 0);

	signal out_deco: std_logic_vector(15 downto 0);
	signal out_regs: tmp_array;

component decode16 is
	port(
		en					: in std_logic;
		i					: in std_logic_vector(3 downto 0);
		D					: out std_logic_vector(15 downto 0));
end component;

component reg16 is
	port(
		clk, load	: in std_logic;
		D				: in std_logic_vector(15 downto 0);
		Q				: out std_logic_vector(15 downto 0));
end component;

component decode16 is
	port(
		A		: bus_array;
		S		: in std_logic_vector(3 downto 0);
		Z		: out std_logic_vector(15 downto 0));
end component;

begin

	deco0	: decode16 port map(en=>W_en, i=>W_addr, D=>out_deco);

	reg0 	: reg16 port map(clk=>clk, load=>out_deco(0), D=>W_data, Q=>out_regs(0));
	reg1 	: reg16 port map(clk=>clk, load=>out_deco(1), D=>W_data, Q=>out_regs(1));
	reg2 	: reg16 port map(clk=>clk, load=>out_deco(2), D=>W_data, Q=>out_regs(2));
	reg3 	: reg16 port map(clk=>clk, load=>out_deco(3), D=>W_data, Q=>out_regs(3));
	reg4 	: reg16 port map(clk=>clk, load=>out_deco(4), D=>W_data, Q=>out_regs(4));
	reg5 	: reg16 port map(clk=>clk, load=>out_deco(5), D=>W_data, Q=>out_regs(5));
	reg6 	: reg16 port map(clk=>clk, load=>out_deco(6), D=>W_data, Q=>out_regs(6));
	reg7 	: reg16 port map(clk=>clk, load=>out_deco(7), D=>W_data, Q=>out_regs(7));
	reg8 	: reg16 port map(clk=>clk, load=>out_deco(8), D=>W_data, Q=>out_regs(8));
	reg9 	: reg16 port map(clk=>clk, load=>out_deco(9), D=>W_data, Q=>out_regs(9));
	reg10 	: reg16 port map(clk=>clk, load=>out_deco(10), D=>W_data, Q=>out_regs(10));
	reg11 	: reg16 port map(clk=>clk, load=>out_deco(11), D=>W_data, Q=>out_regs(11));
	reg12 	: reg16 port map(clk=>clk, load=>out_deco(12), D=>W_data, Q=>out_regs(12));
	reg13 	: reg16 port map(clk=>clk, load=>out_deco(13), D=>W_data, Q=>out_regs(13));
	reg14 	: reg16 port map(clk=>clk, load=>out_deco(14), D=>W_data, Q=>out_regs(14));
	reg15 	: reg16 port map(clk=>clk, load=>out_deco(15), D=>W_data, Q=>out_regs(15));

	mux0	: mux16_1 port map(A=>out_regs, S=>R_addr, Z=>R_data);
	
end behav;
