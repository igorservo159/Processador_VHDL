library ieee;
use ieee.std_logic_1164.all;

entity reg16 is
	port(
		clk_reg4: in std_logic;
		D_reg4: in std_logic_vector(3 downto 0);
		Q_reg4: out std_logic_vector(3 downto 0));
end reg16;

architecture behav of reg16 is
begin

	process(clk_reg4)
	begin
		if (clk_reg4'event and clk_reg4 = '1') then
			Q_reg4 <= D_reg4;
		end if;
	end process;

end architecture behav;
