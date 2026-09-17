-----------------------------------------------------------------------------------
    --Top
    --Designer: Ethan Saber
    --Purpose:  Counter [Simulation]
    --Date:     09.17.26
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
-------------------------------------------------------------------
        --Temporary signals
-------------------------------------------------------------------
        signal     sum       : std_logic_vector(3 downto 0)  :=  "0000";
        signal     sum_sig   : std_logic_vector(3 downto 0)  :=  "0000";
        signal     enable    : std_logic;
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

component generic_adder_beh is
        port(
            a         : in std_logic_vector(3 downto 0);
            b         : in std_logic_vector(3 downto 0);
            cin       : in std_logic;
            sum       : out std_logic_vector(3 downto 0);
            cout      : out std_logic

        );
        end component;
-------------------------------------------------------------------
        begin
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
uut: generic_adder_beh
        port map(
            a     =>    sum_sig,
            b     =>    "0001",
            cin   =>    '0',
            sum   =>    sum,
            cout  =>    open

        );
------------------------------------------------------------------
        --Process for sum register
------------------------------------------------------------------
        sum_register : process(clk,reset)
        begin
            if(reset='1')then
                sum_sig <= "1111";
                elsif(clk'event and clk ='1')then
                if(enable = '1') then
                    sum_sig <= sum;
                    end if;
                end if;
            end process sum_register;


        end beh;



