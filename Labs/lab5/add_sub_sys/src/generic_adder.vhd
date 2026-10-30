-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic adder [behavioral] [sub-module]
-- Ethan Saber
-- 10/28/26
-------------------------------------------------------------------------------


library IEEE;
use ieee.std_logic_1164.all;

package generic_adder_pkg is
    component generic_adder is

        generic (
            bits :integer := 4
        );
        port(
            a              :in std_logic_vector(bits-1 downto 0);
            b              :in std_logic_vector(bits-1 downto 0);
            cin            :in std_logic;
            --flag           :in std_logic;
            bcd_result_1     :out std_logic_vector(bits-1 downto 0);
            bcd_result_cout  :out std_logic
        );
    end component;
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_adder is
    generic (
        bits    : integer := 4
    );
    port (
        a              :in std_logic_vector(bits-1 downto 0);
        b              :in std_logic_vector(bits-1 downto 0);
        cin            :in std_logic;
        --flag           :in std_logic;
        bcd_result_1     :out std_logic_vector(bits-1 downto 0);
        bcd_result_cout  :out std_logic
    );
end entity generic_adder;

architecture beh of generic_adder is

    signal bcd_initial        : std_logic_vector(bits downto 0);
    signal bcd_result_guard   : std_logic_vector(bits-1 downto 0) := (others => '0');

begin
    bcd_initial  <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b)
        + unsigned(bcd_result_guard & cin));

    bcd_result_1    <= bcd_initial(bits-1 downto 0);
    bcd_result_cout <= bcd_initial(bits);


end beh;