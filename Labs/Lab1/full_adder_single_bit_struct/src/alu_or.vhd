------------------------------------------------------
--Ethan Saber
--alu_or.vhd
--09.03.26
--or operation of two inputs
------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity alu_or is
    port(

        a     :in std_logic;
        b     :in std_logic;
        c_a   :in std_logic;
        c_out :out std_logic

    );
    end alu_or;
ARCHITECTURE beh of alu_or is
begin

    c_out <= a or b or c_a;

end beh;
