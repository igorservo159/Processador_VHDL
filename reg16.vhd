library ieee;
use ieee.std_logic_1164.all;

entity reg16 is
	port(
		clk_r16, load_r16: in std_logic;
		D_r16: in std_logic_vector(15 downto 0);
		Q_r16: out std_logic_vector(15 downto 0));
end reg16;

architecture behav of reg16 is
begin

	process(clk_r16, load_r16)
	begin
		if (clk_r16'event and clk_r16 = '1' and load_r16 = '1') then
			Q_r16 <= D_r16;
		end if;
	end process;

end architecture behav;
