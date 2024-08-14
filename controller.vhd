library ieee;
use ieee.std_logic_1164.all;

entity controller is
	Port(
		clk_ctl, RP_zero_ctl: in std_logic;
		IR_ctl: in std_logic_vector(15 downto 0);

		alu_s0_ctl, alu_s1_ctl: out std_logic;
		
		D_wr_ctl, D_rd_ctl: out std_logic;
		D_addr_ctl: out std_logic_vector(7 downto 0);
		
		PC_ld_ctl, PC_up_ctl, PC_clr_ctl: out std_logic;
		I_ld_ctl, IR_ld_ctl: out std_logic;
		
		W_addr_ctl, Rp_addr_ctl, Rq_addr_ctl: out std_logic_vector(3 downto 0);
		Rp_rd_ctl, Rq_rd_ctl, W_wr_ctl, RF_s0_ctl, RF_s1_ctl: out std_logic;
		W_data_ctl: out std_logic_vector(15 downto 0);
		
		S_out_ctl, N_out_ctl, OP_out_ctl: out std_logic_vector(3 downto 0));

end controller;

architecture behav of controller is
	signal OP, ra, rb, rc, S, N: std_logic_vector(3 downto 0);
	signal c, D_rd_auxr: std_logic_vector(15 downto 0);
	signal d: std_logic_vector(7 downto 0);
	signal alu_S: std_logic_vector(1 downto 0);
	signal PC: std_logic_vector(2 downto 0);

	component reg4 is
		port(
		clk_reg4: in std_logic;
		D_reg4: in std_logic_vector(3 downto 0);
		Q_reg4: out std_logic_vector(3 downto 0));
	end component;

	component n_ctl is
		Port(
			OP_n: in std_logic_vector(3 downto 0);
			S_n: in std_logic_vector(3 downto 0);
			RP_zero_n: in std_logic;
			N_out: out std_logic_vector(3 downto 0));
	end component;
	
	component alu_ctl is
		Port(
			S_alu: in std_logic_vector(3 downto 0);
			alu_s1s0: out std_logic_vector(1 downto 0));
	end component;

	component RAM_ctl is
		Port(
		d_RAM: in std_logic_vector(7 downto 0);
		S_RAM: in std_logic_vector(3 downto 0);
		D_addr_RAM: out std_logic_vector(7 downto 0);
		D_wr_RAM, D_rd_RAM: out std_logic);
	end component;

	component PC_ctl is
		Port(
		S_PC: in std_logic_vector(3 downto 0);
		PC_out: out std_logic_vector(2 downto 0));
	end component;

	component RF_ctl is
		Port(
			c_RF: in std_logic_vector(15 downto 0);
			S_RF: in std_logic_vector(3 downto 0);
			ra_RF, rb_RF, rc_RF: in std_logic_vector(3 downto 0);
			RF_W_addr_RF, RF_Rp_addr_RF, RF_Rq_addr_RF: out std_logic_vector(3 downto 0);
			RF_Rp_rd_RF, RF_Rq_rd_RF, RF_W_wr_RF, RF_s0_RF, RF_s1_RF: out std_logic;
			RF_W_data_RF: out std_logic_vector(15 downto 0));
			
	end component;

	begin

		OP(0) <= IR_ctl(12);
		OP(1) <= IR_ctl(13);
		OP(2) <= IR_ctl(14);
		OP(3) <= IR_ctl(15);

		ra <= IR_ctl(11) & IR_ctl(10) & IR_ctl(9) & IR_ctl(8);
		
		with OP select
			rb <= IR_ctl(7) & IR_ctl(6) & IR_ctl(5) & IR_ctl(4) when "0010",
				  IR_ctl(7) & IR_ctl(6) & IR_ctl(5) & IR_ctl(4) when "0100",
				  IR_ctl(7) & IR_ctl(6) & IR_ctl(5) & IR_ctl(4) when "0110",
				  "0000" when others;

		with OP select
			rc <= IR_ctl(3) & IR_ctl(2) & IR_ctl(1) & IR_ctl(0) when "0010",
				  IR_ctl(3) & IR_ctl(2) & IR_ctl(1) & IR_ctl(0) when "0100",
				  IR_ctl(3) & IR_ctl(2) & IR_ctl(1) & IR_ctl(0) when "0110",
				  "0000" when others;

		with OP select
			c <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & IR_ctl(7) & IR_ctl(6) & IR_ctl(5) & IR_ctl(4) & IR_ctl(3) & IR_ctl(2) & IR_ctl(1) & IR_ctl(0) when "0011",
				  "0000000000000000" when others;
		
		with OP select
			d <= IR_ctl(7) & IR_ctl(6) & IR_ctl(5) & IR_ctl(4) & IR_ctl(3) & IR_ctl(2) & IR_ctl(1) & IR_ctl(0) when "0000",
				 IR_ctl(7) & IR_ctl(6) & IR_ctl(5) & IR_ctl(4) & IR_ctl(3) & IR_ctl(2) & IR_ctl(1) & IR_ctl(0) when "0001",
				 "00000000" when others;


		u1: reg4 port map(clk_reg4=>clk_ctl, D_reg4=>N, Q_reg4=>S);
		u2: n_ctl port map(OP_n=>OP, S_n=>S, RP_zero_n=>RP_zero_ctl, N_out=>N);
		u3: alu_ctl port map(S_alu=>S, alu_s1s0=>alu_S);

		alu_s0_ctl <= alu_S(0);
		alu_s1_ctl <= alu_S(1);

		u4: RAM_ctl port map(d_RAM=>d, S_RAM=>S, D_addr_RAM=>D_addr_ctl, D_wr_RAM=>D_wr_ctl, D_rd_RAM=>D_rd_ctl);
		u5: PC_ctl port map(S_PC=>S, PC_out=>PC);
		
		PC_ld_ctl <= PC(0);
		PC_up_ctl <= PC(1);
		PC_clr_ctl <= PC(0);

		IR_ld_ctl <= PC(1);
		I_ld_ctl <= PC(1);
	
		u6: RF_ctl port map(c_RF=>c, S_RF=>S, ra_RF=>ra, rb_RF=>rb, rc_RF=>rc, RF_W_addr_RF=>W_addr_ctl,
						    RF_Rp_addr_RF=>Rp_addr_ctl, RF_Rq_addr_RF=>Rq_addr_ctl, RF_Rp_rd_RF=>Rp_rd_ctl,
							RF_Rq_rd_RF=>Rq_rd_ctl, RF_W_wr_RF=>W_wr_ctl, RF_s0_RF=>RF_s0_ctl, RF_s1_RF=>RF_s1_ctl,
							RF_W_data_RF=>W_data_ctl);

		S_out_ctl<=S;
		N_out_ctl<=N;
		OP_out_ctl<=OP;
		
end behav;