library ieee;
use ieee.std_logic_1164.all;

entity RF_ctl is
	Port(
		c_RF: in std_logic_vector(15 downto 0);
		S_RF: in std_logic_vector(3 downto 0);
		ra_RF, rb_RF, rc_RF: in std_logic_vector(3 downto 0);
		RF_W_addr_RF, RF_Rp_addr_RF, RF_Rq_addr_RF: out std_logic_vector(3 downto 0);
		RF_Rp_rd_RF, RF_Rq_rd_RF, RF_W_wr_RF, RF_s0_RF, RF_s1_RF: out std_logic;
		RF_W_data_RF: out std_logic_vector(15 downto 0));
		
end RF_ctl;

architecture behav of RF_ctl is
	signal load_const, RF_Rp_rd_RF_aux, RF_Rq_rd_RF_aux, RF_W_wr_RF_aux: std_logic;
	signal Rp_rarb: std_logic_vector(1 downto 0);
	begin
	
	RF_s0_RF <= not(S_RF(3)) and not(S_RF(2)) and S_RF(1) and S_RF(0);

	RF_s1_RF <= not(S_RF(3)) and S_RF(2) and S_RF(1) and not(S_RF(0));

	RF_W_wr_RF_aux <= (not(S_RF(3)) and not(S_RF(2)) and S_RF(1) and S_RF(0)) or 
			   (not(S_RF(3)) and S_RF(2) and not(S_RF(1)) and S_RF(0)) or 
			   (not(S_RF(3)) and S_RF(2) and S_RF(1)) or 
			   (S_RF(3) and not(S_RF(2)) and S_RF(1) and not(S_RF(0)));

	RF_W_wr_RF <= RF_W_wr_RF_aux;

	RF_Rp_rd_RF <= (not(S_RF(3)) and S_RF(2) and not(S_RF(1)) and not(S_RF(0))) or 
				(not(S_RF(3)) and S_RF(2) and not(S_RF(1)) and S_RF(0)) or 
				(S_RF(3) and S_RF(2) and S_RF(1) and S_RF(0)) or 
				(S_RF(3) and not(S_RF(2)) and not(S_RF(1)) and not(S_RF(0))) or 
				(S_RF(3) and not(S_RF(2)) and S_RF(1) and not(S_RF(0)));

	RF_Rq_rd_RF_aux <= (not(S_RF(3) and S_RF(2) and not(S_RF(1)) and S_RF(0))) or 
				(not(S_RF(3)) and S_RF(2) and S_RF(1) and S_RF(0)) or 
				(S_RF(3) and not(S_RF(2)) and S_RF(1) and not(S_RF(0)));

	RF_Rq_rd_RF <= RF_Rq_rd_RF_aux;
	
	load_const <= not(S_RF(3)) and S_RF(2) and S_RF(1) and not(S_RF(0));

	Rp_rarb(0) <= (not(S_RF(3)) and S_RF(2) and not(S_RF(1)) and not(S_RF(0))) or
			 (S_RF(3) and S_RF(2) and S_RF(1) and not(S_RF(0))) or
			 (S_RF(3) and not(S_RF(2)) and not(S_RF(1)) and not(S_RF(0)));

	Rp_rarb(1) <= (not(S_RF(3)) and S_RF(2) and not(S_RF(1)) and S_RF(0)) or 
			 (S_RF(3) and not(S_RF(2)) and S_RF(1) and not(S_RF(0)));

	with RF_Rq_rd_RF_aux select
		RF_Rq_addr_RF <= rc_RF when '1',
					  "0000" when '0';
	
	with RF_W_wr_RF_aux select
		RF_W_addr_RF <= ra_RF when '1',
					 "0000" when '0';

	with load_const select
		RF_W_data_RF <= c_RF when '1',
					 "0000000000000000" when '0';
		
	with Rp_rarb select
		RF_Rp_addr_RF <= ra_RF when "01",
					  rb_RF when "10",
					  "0000" when others;

end behav;
