library ieee;
use ieee.std_logic_1164.all;

entity RAM_ctl is
	Port(
		d_RAM: in std_logic_vector(7 downto 0);
		S_RAM: in std_logic_vector(3 downto 0);
		D_addr_RAM: out std_logic_vector(7 downto 0);
		D_wr_RAM, D_rd_RAM: out std_logic);
end RAM_ctl;

architecture behav of RAM_ctl is
	signal D_rd_aux: std_logic;

	begin

	D_wr_RAM <= not(S_RAM(3)) and S_RAM(2) and not(S_RAM(1)) and not(S_RAM(0));

	D_rd_aux <= not(S_RAM(3)) and not(S_RAM(2)) and S_RAM(1) and S_RAM(0);
				
	D_rd_RAM <= D_rd_aux;

	with D_rd_aux select
		D_addr_RAM <= d_RAM when '1',
				  "00000000" when '0';

end behav;
