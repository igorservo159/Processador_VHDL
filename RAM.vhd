library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
     port(
          clk_ram : in std_logic; 
          rd_ram, wr_ram: in std_logic;
          addr_ram : in std_logic_vector(7 downto 0);
          data_input_ram : in std_logic_vector(15 downto 0);
          data_output_ram : out std_logic_vector(15 downto 0));
end RAM;

architecture behav of RAM is
     type ram_type is array(0 to 255) of std_logic_vector(15 downto 0);
     signal ram: ram_type;
     signal temp_address: std_logic_vector(7 downto 0);
begin

process(clk_ram) is
begin
    if (rising_edge(clk_ram)) then
          if (wr_ram = '0') then
               temp_address <= addr_ram;
          elsif (wr_ram = '1') then
               ram(to_integer(unsigned(addr_ram))) <= data_input_ram;
          end if;
          if (rd_ram = '0') then
               data_output_ram <= "0000000000000000";
          elsif (rd_ram = '1') then
               data_output_ram <= ram(to_integer(unsigned(temp_address)));
          end if;
    end if;
end process;
end behav;
