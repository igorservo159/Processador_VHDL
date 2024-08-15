library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ROM is
port(
   clk_rom : in std_logic; 
   rom_en : in std_logic;
   rom_addr : in std_logic_vector(3 downto 0);
   data_out_rom : out std_logic_vector(15 downto 0));
end ROM;
architecture behav of ROM is
 type rom_type is array(0 to 15) of std_logic_vector(15 downto 0);

   constant mem: rom_type :=
   (0 => "0011000000000110",  -- "0011 0000 00000110 load_const"
    1 => "0011000100000101",  -- "0011 0001 00000101 load_const"
    2 => "0110001000000001",  -- "0110 0010 0000 0001 shift left"
    3 => "0001001000000000",  -- "0001 0010 00000000 store"
    4 => "0000001000000000",  -- "0000 0011 00000000 load"
    others => "0000001000000000");

begin

process(clk_rom) is
begin
  if (rising_edge(clk_rom) and rom_en = '1') then
     data_out_rom <= mem(conv_integer(unsigned(rom_addr)));
  end if;
end process;

end behav;
