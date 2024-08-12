library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package bus_array_pkg is
        type bus_array is array(15 downto 0) of std_logic_vector(15 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.bus_array_pkg.all;

entity mux16_1 is
	port(
		A_m16: in bus_array;
		S_m16: in std_logic_vector(3 downto 0);
		Z_m16: out std_logic_vector(15 downto 0));
end mux16_1;

architecture main of mux16_1 is
begin
	-- Seleciona a entrada com base no valor de S e atribui a Z
	Z_m16 <= A_m16(to_integer(unsigned(S)));
end architecture main;
