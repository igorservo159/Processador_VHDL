library ieee;
use ieee.std_logic_1164.all;

entity barrel_shifter is
    Port(
        x_bs, y_bs: in std_logic;
        A_bs: in std_logic_vector(15 downto 0);
        B_bs: in std_logic_vector(3 downto 0);
        A_shifted_bs: out std_logic_vector(15 downto 0)
    );
end barrel_shifter;

architecture behav of barrel_shifter is

    signal A_shifted_sh8, A_shifted_sh4, A_shifted_sh2, A_shifted_sh1: std_logic_vector(15 downto 0);

    component shifter_1 is
        Port(
            sh1: in std_logic;
            A_sh1: in std_logic_vector(15 downto 0);
            A_shifted_sh1: out std_logic_vector(15 downto 0)
        );
    end component;

    component shifter_2 is
        Port(
            sh2: in std_logic;
            A_sh2: in std_logic_vector(15 downto 0);
            A_shifted_sh2: out std_logic_vector(15 downto 0)
        );
    end component;

    component shifter_4 is
        Port(
            sh4: in std_logic;
            A_sh4: in std_logic_vector(15 downto 0);
            A_shifted_sh4: out std_logic_vector(15 downto 0)
        );
    end component;

    component shifter_8 is
        Port(
            sh8: in std_logic;
            A_sh8: in std_logic_vector(15 downto 0);
            A_shifted_sh8: out std_logic_vector(15 downto 0)
        );
    end component;

begin
    -- Deslocamento de 8 bits
    s3 : shifter_8 port map(sh8 => (x_bs and y_bs and B_bs(3)), A_sh8 => A_bs, A_shifted_sh8 => A_shifted_sh8);

    -- Deslocamento de 4 bits na saída de 8 bits
    s2 : shifter_4 port map(sh4 => (x_bs and y_bs and B_bs(2)), A_sh4 => A_shifted_sh8, A_shifted_sh4 => A_shifted_sh4);

    -- Deslocamento de 2 bits na saída de 4 bits
    s1 : shifter_2 port map(sh2 => (x_bs and y_bs and B_bs(1)), A_sh2 => A_shifted_sh4, A_shifted_sh2 => A_shifted_sh2);

    -- Deslocamento de 1 bit na saída de 2 bits
    s0 : shifter_1 port map(sh1 => (x_bs and y_bs and B_bs(0)), A_sh1 => A_shifted_sh2, A_shifted_sh1 => A_shifted_sh1);

    -- Saída final
    A_shifted_bs <= A_shifted_sh1;
    
end behav;
