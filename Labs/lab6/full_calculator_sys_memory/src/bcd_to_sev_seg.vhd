--------------------------------------------------------------------------------------
--Designer:               Ethan Saber
--Purpose:                Convert 4-bit input to 7-seg disp [sub-module]
--Original Date Created:  12.05.24
--Date Modified:          10.28.26
--------------------------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;

package bcd_to_sev_seg_pkg is
    component bcd_to_sev_seg is

        port(
            bcd                                    :in std_logic_vector(3 downto 0);
            seven_segment_display_out              :out std_logic_vector(6 downto 0)
            --flag           :in std_logic;
            --bcd_result_1   :out std_logic_vector(bits downto 0)
        );
    end component;
end package;


Library ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;


entity bcd_to_sev_seg is

    port(
        --clk      :in std_logic;
        --reset    :in std_logic;
        bcd                       : in std_logic_vector(3 downto 0);
        seven_segment_display_out : out std_logic_vector(6 downto 0)
    );

end bcd_to_sev_seg;

ARCHITECTURE beh of bcd_to_sev_seg is
    --what will ones dig be on hex display?
begin
    process(bcd)
    begin
        case bcd is --this is case bcd since bcd is the 'value' we need to process

            when "0000" => seven_segment_display_out <= "1000000";  -- 0

            when "0001" => seven_segment_display_out <= "1111001";  -- 1

            when "0010" => seven_segment_display_out <= "0100100";  -- 2

            when "0011" => seven_segment_display_out <= "0110000";  -- 3

            when "0100" => seven_segment_display_out <= "0011001";  -- 4

            when "0101" => seven_segment_display_out <= "0010010";  -- 5

            when "0110" => seven_segment_display_out <= "0000010";  -- 6

            when "0111" => seven_segment_display_out <= "1111000";  -- 7

            when "1000" => seven_segment_display_out <= "0000000";  -- 8

            when "1001" => seven_segment_display_out <= "0011000";  -- 9

            when "1010" => seven_segment_display_out <= "0001000";  -- A

            when "1011" => seven_segment_display_out <= "0000011";  -- B

            when "1100" => seven_segment_display_out <= "1000110";  -- C

            when "1101" => seven_segment_display_out <= "0100001";  -- D

            when "1110" => seven_segment_display_out <= "0000110";  -- E

            when "1111" => seven_segment_display_out <= "0001110";  -- F

            when others => seven_segment_display_out <= "1111111";--sets all other segments off

        end case;
    end process;
end beh;
