-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic adder [behavioral]
-- Ethan Saber
-- 10/8/26
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_adder_beh is
    generic (
        bits    : integer := 3
    );
    port (
        a        : in  std_logic_vector(bits-1 downto 0);
        b        : in  std_logic_vector(bits-1 downto 0);
        flag     : in  std_logic;
        c        : out std_logic_vector(bits downto 0)
    );
end entity generic_adder_beh;

architecture beh of generic_adder_beh is

    signal add   : std_logic_vector(bits downto 0);
    signal sub   : std_logic_vector(bits downto 0);

begin
    add  <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b) + unsigned(a & b));
    sub  <= std_logic_vector(unsigned('0' & a) - unsigned('0' & b) + unsigned(a & b));
    c    <= add when flag = '0' else sub; -- when the flag is 0 we add when else subtract a & b
end beh;