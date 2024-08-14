library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_16bits is
    port(
        A : in std_logic_vector(15 downto 0); --Pass A when 'sel = 1'
        B : in std_logic_vector(15 downto 0); --Pass B when 'sel = 0'
        sel : in std_logic;
        S : out std_logic_vector(15 downto 0)
    );
end entity;

architecture main of mux2x1_16bits is
begin
    process(sel, A, B)
    begin
        if(sel = '1') then
            S <= A;
        else
            S <= B;
        end if;
    end process;
end architecture;
