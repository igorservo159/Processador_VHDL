library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
	Port(
		clk_ctl_un, RP_zero_ctl_un: in std_logic;
		
		alu_s0_ctl_un, alu_s1_ctl_un: out std_logic;
		
		D_wr_ctl_un, D_rd_ctl_un: out std_logic;
		D_addr_ctl_un: out std_logic_vector(7 downto 0);
		
		W_addr_ctl_un, Rp_addr_ctl_un, Rq_addr_ctl_un: out std_logic_vector(3 downto 0);
		Rp_rd_ctl_un, Rq_rd_ctl_un, W_wr_ctl_un, RF_s0_ctl_un, RF_s1_ctl_un: out std_logic;
		W_data_ctl_un: out std_logic_vector(15 downto 0);
		S_out_ctl_un, N_out_ctl_un, OP_out_ctl_un: out std_logic_vector(3 downto 0);
		IR_out_ctl_un: out std_logic_vector(15 downto 0));

end control_unit;

architecture behav of control_unit is
	component controller is
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
	end component;

	component somador4 is
		Port(
		A_s4, B_s4	: in std_logic_vector(3 downto 0);
		cin_s4		: in std_logic;
		cout_s4	: out std_logic;
		Z_s4			: out std_logic_vector(3 downto 0));
	end component;
		
	component instru_reg is
		port (
    		clk_ir, ld_ir: in  std_logic;
    		instr_in: in  std_logic_vector(15 downto 0);
    		instr_out: out std_logic_vector(15 downto 0));
	end component;
	
	component programcounter is
		port (
    		clk_pc, ld_pc, clr_pc, up_pc: in std_logic;
    		offset: in std_logic_vector(3 downto 0);
    		out_pc: out std_logic_vector(3 downto 0));
	end component;
	
	component ROM is
		port(
   			clk_rom : in std_logic; 
   			rom_en : in std_logic;
   			rom_addr : in std_logic_vector(3 downto 0);
   			data_out_rom : out std_logic_vector(15 downto 0));
	end component;
	
	signal OP: std_logic_vector(3 downto 0);	
	signal PC: std_logic_vector(2 downto 0);
	signal IR_ctl_un: std_logic_vector(15 downto 0);
	signal I_ld_ctl_un, IR_ld_ctl_un: std_logic;
	signal rom_instr: std_logic_vector(15 downto 0);
	signal rom_addr_ctl_un: std_logic_vector(3 downto 0);
	signal sum_ctl_un: std_logic_vector(3 downto 0);
	signal sum_ctl_un_cout: std_logic;
	signal sum_ctl_un_B: std_logic_vector(3 downto 0);
	signal offset_ctl_un: std_logic_vector(3 downto 0);

	begin

		u1: controller port map(clk_ctl=>clk_ctl_un, RP_zero_ctl=>RP_zero_ctl_un, IR_ctl=>IR_ctl_un, 
							    alu_s0_ctl=>alu_s0_ctl_un, alu_s1_ctl=>alu_s1_ctl_un,
								D_wr_ctl=>D_wr_ctl_un, D_rd_ctl=>D_rd_ctl_un, D_addr_ctl=>D_addr_ctl_un,
								PC_ld_ctl=>PC(0), PC_up_ctl=>PC(1), PC_clr_ctl=>PC(2),
								I_ld_ctl=>I_ld_ctl_un, IR_ld_ctl=>IR_ld_ctl_un,
								W_addr_ctl=>W_addr_ctl_un, Rp_addr_ctl=>Rp_addr_ctl_un, Rq_addr_ctl=>Rq_addr_ctl_un,
								Rp_rd_ctl=>Rp_rd_ctl_un, Rq_rd_ctl=>Rq_rd_ctl_un, W_wr_ctl=>W_wr_ctl_un,
								RF_s0_ctl=>RF_s0_ctl_un, RF_s1_ctl=>RF_s1_ctl_un,
								W_data_ctl=>W_data_ctl_un,
								S_out_ctl=>S_out_ctl_un, N_out_ctl=>N_out_ctl_un, OP_out_ctl=>OP_out_ctl_un); 
		u2: instru_reg port map(clk_ir=>clk_ctl_un, ld_ir=>IR_ld_ctl_un, instr_in=>rom_instr, instr_out=>IR_ctl_un);
		
		u3: programcounter port map(clk_pc=>clk_ctl_un, ld_pc=>PC(0), clr_pc=>PC(2), up_pc=>PC(1),
									offset=>sum_ctl_un, out_pc=>rom_addr_ctl_un);
		
		IR_out_ctl_un <= IR_ctl_un;

		OP(3) <= IR_ctl_un(15);
		OP(2) <= IR_ctl_un(14);
		OP(1) <= IR_ctl_un(13);
		OP(0) <= IR_ctl_un(12);

		with OP select
			offset_ctl_un <= IR_ctl_un(3) & IR_ctl_un(2) & IR_ctl_un(1) & IR_ctl_un(0) when "0101",
							 "0000" when others;
		
		sum_ctl_un_B <= std_logic_vector(to_unsigned(to_integer(unsigned( offset_ctl_un )) - 1, 4));
		
		u4: somador4 port map(A_s4=>offset_ctl_un, B_s4=>sum_ctl_un_B, cin_s4=>'0', cout_s4=>sum_ctl_un_cout,
							  Z_s4=>sum_ctl_un);

		u5: ROM port map(clk_rom=>clk_ctl_un, rom_en=>I_ld_ctl_un, rom_addr=>rom_addr_ctl_un, data_out_rom=>rom_instr);
		
		

end behav;