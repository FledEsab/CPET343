----------------------------------------------------------------------------------
--Ethan Saber
--Generic Adder sub-module [arch]
--09.06.26
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

    entity generic_adder_arch_sub is
        port(
            a        :in std_logic;
            b        :in std_logic;
            cin      :in std_logic;
            sum      :out std_logic;
            cout     :out std_logic -- no semi col here
        );
        end generic_adder_arch_sub;

    architecture arch of generic_adder_arch_sub is
    begin

    sum  <= (a xor b) xor cin;
    cout <= (a and b) or (a and cin) or (b and cin);

    end arch;
