library ieee;
use ieee.std_logic_1164.all;

entity reg16 is
	port(
		clk, load	: in std_logic;
		D				: in std_logic_vector(15 downto 0);
		Q				: out std_logic_vector(15 downto 0));
end reg16;

architecture behav of reg16 is
begin

	process(clk, load)
	begin
		if (clk'event and clk = '1' and load = '1') then
			Q <= D;
		end if;
	end process;

end architecture behav;
