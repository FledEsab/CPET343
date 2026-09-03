------------------------------------------------------
--Ethan Saber
--alu_xor.vhd
--09.03.26
--xor\ operation of two inputs
------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity alu_and is
    port(

        a     :in std_logic_vector(1 downto 0);
        b     :in std_logic_vector(1 downto 0);
        c_out  :out std_logic_vector(1 downto 0);

    );

ARCHITECTURE beh of alu_and is
begin

    c_out <= a xor b;

end beh;
