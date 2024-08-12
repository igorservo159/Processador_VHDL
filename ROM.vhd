LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY ROM IS
PORT(
           clock : IN STD_LOGIC; 
           rom_enable : IN STD_LOGIC;
           address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
           data_output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END ROM;
ARCHITECTURE behav OF ROM IS
     TYPE rom_type IS ARRAY(0 to 15) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    
     CONSTANT mem: rom_type :=
           (2 => "01011001", -- Aloca um dado no endereço 2
            3 => "00000100", -- Aloca um dado no endereço 3
            4 => "00100101", -- Aloca um dado no endereço 4
            others => "00000000"  -- Aloca 0 no outros endereços
            );

BEGIN

PROCESS(clock) IS
BEGIN
    IF (RISING_EDGE(clock) AND rom_enable = '1') THEN
           data_output <= mem(conv_integer(unsigned(address)));
    END IF;
END PROCESS;
END behav;