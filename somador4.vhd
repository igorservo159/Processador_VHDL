library ieee;
use ieee.std_logic_1164.all;

entity somador4 is
	Port(
    A_s4, B_s4	: in std_logic_vector(3 downto 0);
    cin_s4		: in std_logic;
    cout_s4	: out std_logic;
    Z_s4			: out std_logic_vector(3 downto 0));
end somador4;

architecture behav of somador4 is
  signal cout_sig : std_logic_vector(3 downto 0);

	component full_adder is
		Port(
      a_fa, b_fa, cin_fa	: in std_logic;
      cout_fa, z_fa		: out std_logic);
  end component;

  begin

	a0 : full_adder port map(a_fa=>A_s4(0), b_fa=>B_s4(0), cin_fa=>cin_s4, cout_fa=>cout_sig(0), z_fa=>Z_s4(0));

  adders : for i in 1 to 3 generate
    adder : full_adder port map(a_fa=>A_s4(i), b_fa=>B_s4(i), cin_fa=>cout_sig(i-1), cout_fa=>cout_sig(i), z_fa=>Z_s4(i));
  end generate;
  
  cout_s4 <= cout_sig(3);

	-- a1 : full_adder port map(a=>A(1), b=>B(1), Cin=>cout_sig(0), cout=>cout_sig(1), z=>Z(1));
	-- a2 : full_adder port map(a=>A(2), b=>B(2), Cin=>cout_sig(1), cout=>cout_sig(2), z=>Z(2));
	-- a3 : full_adder port map(a=>A(3), b=>B(3), Cin=>cout_sig(2), cout=>cout_sig(3), z=>Z(3));
	
end behav;
