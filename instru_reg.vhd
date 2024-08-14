library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity instru_reg is
  port (
    clk_ir, ld_ir : in  std_logic;
    instr_in : in  std_logic_vector(15 downto 0);
    instr_out : out std_logic_vector(15 downto 0));
end instru_reg;

architecture behavioral of instru_reg is
  signal ir : std_logic_vector(15 downto 0);
begin

  process(clk_ir)
  begin
    if clk_ir = '1' and rising_edge(clk_ir) then
      if ld_ir = '1' then
        ir <= instr_in;
      end if;
    end if;

    instr_out <= ir;
  end process;

  

end behavioral;
