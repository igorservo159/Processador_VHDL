library ieee;
use ieee.std_logic_1164.all;

entity regfile is
	Port(
		clk_rf: in std_logic;

		W_data: in std_logic_vector(15 downto 0);
		W_addr: in std_logic_vector(3 downto 0);
		W_wr: in std_logic;

		Rp_addr: in std_logic_vector(3 downto 0);
		Rp_rd: in std_logic;
		Rp_data: out std_logic_vector(15 downto 0);
		
		Rq_addr: in std_logic_vector(3 downto 0);
		Rq_rd: in std_logic;
		Rq_data: out std_logic_vector(15 downto 0));
end regfile;

architecture behav of regfile is
	type tmp_array is array(0 to 15) of std_logic_vector(15 downto 0);

	signal out_deco: std_logic_vector(15 downto 0);
	signal out_regs: tmp_array;
	signal auxP, auxQ: std_logic_vector(15 downto 0);

component decode16 is
	port(
		en_d16: in std_logic;
		i_d16: in std_logic_vector(3 downto 0);
		D_d16: out std_logic_vector(15 downto 0));
end component;

component reg16 is
	port(
		clk_r16, load_r16: in std_logic;
		D_r16: in std_logic_vector(15 downto 0);
		Q_r16: out std_logic_vector(15 downto 0));
end component;

component mux16_1 is
	port(
		A_m16: in bus_array;
		S_m16: in std_logic_vector(3 downto 0);
		Z_m16: out std_logic_vector(15 downto 0));
end component;

begin

	deco: decode16 port map(en_d16=>W_wr, i_d16=>W_addr, D_d16=>out_deco);

	reg0: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(0), D_r16=>W_data, Q_r16=>out_regs(0));
	reg1: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(1), D_r16=>W_data, Q_r16=>out_regs(1));
	reg2: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(2), D_r16=>W_data, Q_r16=>out_regs(2));
	reg3: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(3), D_r16=>W_data, Q_r16=>out_regs(3));
	reg4: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(4), D_r16=>W_data, Q_r16=>out_regs(4));
	reg5: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(5), D_r16=>W_data, Q_r16=>out_regs(5));
	reg6: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(6), D_r16=>W_data, Q_r16=>out_regs(6));
	reg7: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(7), D_r16=>W_data, Q_r16=>out_regs(7));
	reg8: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(8), D_r16=>W_data, Q_r16=>out_regs(8));
	reg9: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(9), D_r16=>W_data, Q_r16=>out_regs(9));
	reg10: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(10), D_r16=>W_data, Q_r16=>out_regs(10));
	reg11: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(11), D_r16=>W_data, Q_r16=>out_regs(11));
	reg12: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(12), D_r16=>W_data, Q_r16=>out_regs(12));
	reg13: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(13), D_r16=>W_data, Q_r16=>out_regs(13));
	reg14: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(14), D_r16=>W_data, Q_r16=>out_regs(14));
	reg15: reg16 port map(clk_r16=>clk_rf, load_r16=>out_deco(15), D_r16=>W_data, Q_r16=>out_regs(15));

	mux0: mux16_1 port map(A_m16=>out_regs, S_m16=>Rp_addr, Z_m16=>auxP);
	mux1: mux16_1 port map(A_m16=>out_regs, S_m16=>Rq_addr, Z_m16=>auxQ);

	Rp_data <= auxP and (others => Rp_rd);
	Rq_data <= auxQ and (others => Rq_rd);
	
end behav;
