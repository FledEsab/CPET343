-------------------------------------------------------------------------------
-- generic subtractor [behavioral] [sub-module]
-- Ethan Saber
-- 10/28/26
-------------------------------------------------------------------------------

    library IEEE;
    use ieee.std_logic_1164;

    package generic_subtractor_pkg is
        component generic_subtractor is

        generic (
        bits :integer := 4
    );
        port(
            a              :in std_logic_vector(bits-1 downto 0);
            b              :in std_logic_vector(bits-1 downto 0);
            flag           :in std_logic;
            bcd_result_1   :out std_logic_vector(bits downto 0)
    );
    end component;
    end package;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_subtractor is
    generic (
        bits    : integer := 4
    );
    port (
        a                   : in  std_logic_vector(bits-1 downto 0);
        b                   : in  std_logic_vector(bits-1 downto 0);
        flag                : in  std_logic;
        bcd_result_1        : out std_logic_vector(bits downto 0)
    );
end entity generic_subtractor;

architecture beh of generic_subtractor is

    --signal add   : std_logic_vector(bits downto 0);
    signal sub   : std_logic_vector(bits downto 0);
    --possibly add buffer/guard here


begin
    --add  <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b));
    sub  <= std_logic_vector(unsigned('0' & a) - unsigned('0' & b));
    bcd_result_1    <= sub; -- when the flag is 0 we add when else subtract a & b
end beh;