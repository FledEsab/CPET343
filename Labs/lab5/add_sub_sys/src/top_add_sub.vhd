-----------------------------------------------------------------------------------
--Top
--Designer: Ethan Saber
--Purpose:  sys absolute top
--Date:     10.27.26
-----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.core_add_sub_pkg.all;

entity top_add_sub is
    port(
        clock_50mhz: in std_logic;
        i_rst_n: in std_logic; --n denotes active low
        i_sw: in std_logic_vector(7 downto 0);
        i_btn: in std_logic_vector(0 downto 0); --i denotes "i"nput pin
        HEX0: out std_logic_vector(6 downto 0);
        HEX1: out std_logic_vector(6 downto 0);
        HEX2: out std_logic_vector(6 downto 0);
        o_led: out std_logic_vector(3 downto 0)
    );
end entity top_add_sub;


architecture arch of top_add_sub is

begin
    U_top_core: core_add_sub
        port map(
            clock_50mhz => clock_50mhz,
            bcd_input => i_sw(7 downto 0),
          rst_n => i_rst_n,
            hex0_ones => HEX0,
            hex1_tens => HEX1,
            hex2_hundreds => HEX2,
            manual_event_clk_push_button => i_btn(0),
            state_debug_led => o_led(3 downto 0)

        );

end arch;
