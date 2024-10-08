library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity programcounter is
  port (
    clk_pc, ld_pc, clr_pc, up_pc: in std_logic;
    offset: in std_logic_vector(3 downto 0);
    out_pc: out std_logic_vector(3 downto 0)
  );
end programcounter;

architecture behav of programcounter is
  signal pc : std_logic_vector(3 downto 0);
begin

  process(clk_pc, clr_pc)
  begin
    if clr_pc = '1' then
      pc <= "0000";
    elsif clk_pc = '1' and rising_edge(clk_pc) then
      if ld_pc = '1' then
        pc <= std_logic_vector(to_unsigned(to_integer(unsigned( pc )) + to_integer(unsigned(offset)), 4));
      elsif up_pc = '1' then
        pc <= std_logic_vector(to_unsigned(to_integer(unsigned( pc )) + 1, 4));
        
      end if;
    end if;
  end process;

  out_pc <= pc;

end behav;

-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;

-- entity pc is
--     Port (
--         clk_pc, ld_pc, clr_pc, up_pc : in std_logic;
--         offset                       : in std_logic_vector(3 downto 0);
--         out_pc                       : out std_logic_vector(3 downto 0)
--     );
-- end pc;

-- architecture behav of pc is

--     signal inp_pc, it_pc : std_logic_vector(3 downto 0);
--     signal c_out_aux     : std_logic;

--     component reg16 is
--         port (
--             clk_r16, load_r16: in std_logic;
--             D_r16: in std_logic_vector(3 downto 0);
--             Q_r16: out std_logic_vector(3 downto 0)
--         );
--     end component;

--     component somador16 is
--         port (
--             A_s16, B_s16: in std_logic_vector(3 downto 0);
--             cin_s16: in std_logic;
--             cout_s16: out std_logic;
--             Z_s16: out std_logic_vector(3 downto 0)
--         );
--     end component;

-- begin

--     -- Instancia o somador
--     pc_it : somador16 port map (
--         A_s16 => out_pc,
--         B_s16 => (others => '0'), -- Soma com zero
--         cin_s16 => '1',
--         cout_s16 => c_out_aux,
--         Z_s16 => it_pc
--     );

--     -- Instancia o registrador
--     pc_reg : reg16 port map (
--         clk_r16 => clk_pc,
--         load_r16 => ld_pc,
--         D_r16 => inp_pc,
--         Q_r16 => out_pc
--     );

--     -- Processo de controle
--     process(clk_pc, clr_pc)
--     begin
--         if clr_pc = '1' then
--             inp_pc <= (others => '0'); -- Clear o registrador
--         elsif rising_edge(clk_pc) then
--             if ld_pc = '1' then
--                 inp_pc <= it_pc; -- Carrega o valor somado
--             elsif up_pc = '1' then
--                 inp_pc <= std_logic_vector(unsigned(out_pc) + 1); -- Incrementa o valor
--             end if;
--         end if;
--     end process;

-- end behav;
