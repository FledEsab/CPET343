-----------------------------------------------------------------------------------
    --Top
    --Designer: Ethan Saber
    --Purpose:  Simulation of all possible 4-bit for 7 seg disp
    --Date:     09.16.26
-----------------------------------------------------------------------------------

    library ieee;
    use IEEE.STD_LOGIC_1164.all;
    use ieee.numeric_std.all;

    entity seven_seg_sim is
    port(

    clk            :in std_logic;
    reset          :in std_logic;
    bcd            :in std_logic_vector(3 downto 0);
    seven_seg_out  :out std_logic_vector(6 downto 0)

    );
    end seven_seg_sim;
    architecture beh of seven_seg_sim is
        signal output : std_logic;
-------------------------------------------------------------------
        --Components
-------------------------------------------------------------------
component hex_ones_dig is
    port(
        clk    : in std_logic;
        reset  : in std_logic;
        bcd    : in std_logic_vector(3 downto 0);
        hex0   : out std_logic_vector(6 downto 0)
    );
    end component;

component generic_counter is
    generic(
        max_count : integer := 3
    );
    port(
    clk      : in std_logic;
    reset    : in std_logic;
    output   : out std_logic
);
end component;
-------------------------------------------------------------------
        begin --lets begin the arch beh of svn seg disp sim
-------------------------------------------------------------------
-------------------------------------------------------------------
        --Port maps
-------------------------------------------------------------------
uut: hex_ones_dig
        port map(
            clk   => clk,
            reset => reset,
            hex0  => seven_seg_out,
            bcd   => bcd
        );
uut1: generic_counter
        port map(
            clk    =>   clk,
            reset  => reset,
            output => output

        );

end beh;

