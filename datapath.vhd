library ieee;
use ieee.std_logic_1164.all;

package bus_aray_pkg is
        type bus_array is array(15 downto 0) of std_logic_vector(15 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.bus_array_pkg.all;

entity datapath is
	Port(
		clk		      : in std_logic;
		R_data		  : in std_logic_vector(15 downto 0);
		RF_W_data	  : in std_logic_vector(7 downto 0);
		RF_W_addr	  : in std_logic_vector(3 downto 0);
		RF_W_wr		  : in std_logic;
		RF_s			  : in std_logic_vector(1 downto 0);
		RF_Rp_addr	: in std_logic_vector(3 downto 0);
		RF_Rp_rd		: in std_logic;
		RF_Rq_addr	: in std_logic_vector(3 downto 0);
		RF_Rq_rd		: in std_logic;
		ALU_s			  : in std_logic_vector(1 downto 0);
		W_data		  : out std_logic_vector(15 downto 0));
end datapath;

architecture behav of datapath is
  signal A, B, C : std_logic_vector(15 downto 0);

	component mux16_1 is
		port(
      A		: bus_array;
      S		: in std_logic_vector(3 downto 0);
      Z		: out std_logic_vector(15 downto 0));
	end component;
  
	component regfile is
		port(
      clk		  : in std_logic;
      W_data	: in std_logic_vector(7 downto 0);
      W_addr	: in std_logic_vector(3 downto 0);
      W_en		: in std_logic;
      R_addr	: in std_logic_vector(3 downto 0);
      R_en		: in std_logic;
      R_data	: out std_logic_vector(7 downto 0));
	end component;

	component alu is
		port(
      x, y    : in std_logic;
      A, B 		: in std_logic_vector(3 downto 0);
      S			  : out std_logic_vector(3 downto 0));
	end component;

begin
  rf0  : regfile port map(clk=>clk, W_data=>W_data, W_addr=>RF_W_addr, W_en=>RF_W_wr, R_addr=>RF_Rp_addr, R_en=>not(RF_W_wr), R_data=>A);
  rf1  : regfile port map(clk=>clk, W_data=>W_data, W_addr=>RF_W_addr, W_en=>RF_W_wr, R_addr=>RF_Rq_addr, R_en=>not(RF_W_wr), R_data=>B);

  al   : alu port map(x => ALU_s(0), y => ALU_s(1), A=>A, B=>B, S=>C);

end behav;
