library ieee;
use ieee.std_logic_1164.all;

package bus_aray_pkg is
        type bus_array is array(15 downto 0) of std_logic_vector(15 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use work.bus_array_pkg.all;

entity datapath is
	Port(
		clk_dp: in std_logic;

		D_addr: in std_logic_vector(7 downto 0);
		D_rd, D_wr: in std_logic;

		RF_W_data: in std_logic_vector(15 downto 0);
		RF_s1, RF_s0: in std_logic;
		
		RF_W_addr: in std_logic_vector(3 downto 0);
		RF_W_wr: in std_logic;
		
		RF_Rp_addr: in std_logic_vector(3 downto 0);
		RF_Rp_rd: in std_logic;

		RF_Rq_addr: in std_logic_vector(3 downto 0);
		RF_Rq_rd: in std_logic;

		RF_Rp_zero: out std_logic;
		
		ALU_s1, ALU_s0: in std_logic);
end datapath;

architecture behav of datapath is
  	signal A_aux, B_aux, C_aux, D_aux, R_data_aux: std_logic_vector(15 downto 0);

	component RAM is
		port(
			clk_ram : in std_logic; 
			rd_ram, wr_ram: in std_logic;
			addr_ram : in std_logic_vector(7 downto 0);
			data_input_ram : in std_logic_vector(15 downto 0);
			data_output_ram : out std_logic_vector(15 downto 0));
	end component;

	component mux4_1 is
		port(
			a_mux4, b_mux4, c_mux4: in std_logic_vector(15 downto 0);
			s1_mux4, s0_mux4: in std_logic;
			d_mux4: out std_logic_vector(15 downto 0));
	end component;
  
	component regfile is
		port(
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
	end component;

  -- DAR ENFOQUE NA REVISÃO DA ALU
	component alu is
		port(
			x, y: in std_logic;
			A, B: in std_logic_vector(15 downto 0);
			S: out std_logic_vector(15 downto 0));
	end component;

-- signal A_aux, B_aux, C_aux, D_aux, R_data_aux: std_logic_vector(15 downto 0);
begin
	d: RAM port map(clk_ram=>clk_dp, rd_ram=>D_rd, wr_ram=>D_wr, addr_ram=>D_addr, data_input_ram=>A_aux, data_output_ram=>R_data_aux);
  -- A_aux é o W_data e o R_data_aux é o R_data

	m: mux4_1 port map(a_mux4=>RF_W_data, b_mux4=>R_data_aux, c_mux4=>D_aux, s1_mux4=>RF_s1, s0_mux4=>RF_s0, d_mux4=>C_aux);
  -- C_aux é o W_data do RF

  rf: regfile port map(clk_rf=>clk_dp, W_data=>C_aux, W_addr=>RF_W_addr, W_wr=>RF_W_wr, Rp_addr=>RF_Rp_addr, Rp_rd=>RF_Rp_rd, Rp_data=>A_aux, Rq_addr=>RF_Rq_addr, Rq_rd=>RF_Rq_rd, Rq_data=>B_aux);

 	al: alu port map(x => ALU_s0, y => ALU_s1, A=>A_aux, B=>B_aux, S=>D_aux);

	RF_Rp_zero <= '1' when A_aux = "0000000000000000" else '0';
end behav;
