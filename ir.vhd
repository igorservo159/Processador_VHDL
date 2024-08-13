library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity instructionregister is
  port (
    clk_ir, clr_ir, ld_ir : in  std_logic;
    instr_in : in  std_logic_vector(15 downto 0);
    instr_out : out std_logic_vector(15 downto 0));
end instructionregister;

architecture behavioral of instructionregister is
  signal ir : std_logic_vector(15 downto 0);
begin

  process(clk_ir, clr_ir)
  begin
    if clr_ir = '1' then
      ir <= (others => '0');
    elsif rising_edge(clk_ir) then
      if ld_ir = '1' then
        ir <= instr_in;
      end if;
    end if;
  end process;

  instr_out <= ir;

end behavioral;
