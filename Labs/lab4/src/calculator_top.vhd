-----------------------------------------------------------------------------------
--Top
--Designer: Ethan Saberr
--Purpose:  Calculator [top]
--Date:     10.7.26
-----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculator_top is
    port(
        clk: in std_logic;
        reset: in std_logic;
        a: in std_logic_vector(2 downto 0);
        b: in std_logic_vector(2 downto 0);
        add_button: in std_logic;
        sub_button: in std_logic;
        a_bcd: out std_logic_vector(6 downto 0);
        b_bcd: out std_logic_vector(6 downto 0);
        result_bcd: out std_logic_vector(6 downto 0)
    );
end entity calculator_top;

architecture beh of calculator_top is

    --component declarations
    component rising_edge_synchronizer is
        port(
            clk: in std_logic;
            reset: in std_logic;
            input: in std_logic;
            edge: out std_logic

        );
    end component;

    component synchronizer_3bit is
        port(
            clk: in std_logic;
            reset: in std_logic;
            async_in: in std_logic_vector(2 downto 0);
            sync_out: out std_logic_vector(2 downto 0)

        );
    end component;


    component bcd_to_sev_seg is
        port(
            bcd: in std_logic_vector(3 downto 0);
            hex0: out std_logic_vector(6 downto 0)

        );
    end component;

    component generic_calculator is
        generic (
            bits: integer := 3
        );
        port (
            a: in  std_logic_vector(bits - 1 downto 0);
            b: in  std_logic_vector(bits - 1 downto 0);
            flag: in  std_logic;
            c: out std_logic_vector(bits downto 0)
        );
    end component;
    -----------------------------------------------------------------
    --done w/ components
    -----------------------------------------------------------------

    --internal signals

    signal a_sync: std_logic_vector(2 downto 0);
    signal b_sync: std_logic_vector(2 downto 0);
    signal a_bcd_sync: std_logic_vector(3 downto 0);
    signal b_bcd_sync: std_logic_vector(3 downto 0);
    signal add_en: std_logic;
    signal sub_en: std_logic;
    signal result: std_logic_vector(3 downto 0);
    signal result_signal: std_logic_vector(3 downto 0);
    signal flag: std_logic;

    --end internal signals
    -----------------------------------------------------------------
    --const
    constant NUM_BITS: integer := 3;

    --port maps
begin

    u_sync_a: synchronizer_3bit
        port map (

            clk => clk,
            reset => reset,
            async_in => a,
            sync_out => a_sync

        );

    u_sync_b: synchronizer_3bit

        port map(

            clk => clk,
            reset => reset,
            async_in => b,
            sync_out => b_sync

        );

    u_add_sub: generic_calculator

        generic map(
            bits => NUM_BITS
        )

        port map(
            a => a_sync,
            b => b_sync,
            flag => flag,
            c => result
        );

    u_a_disp: bcd_to_sev_seg --disp a input

        port map(

            bcd => a_bcd_sync,
            hex0 => a_bcd

        );
    -------------------------------------------------
    a_bcd_sync <= '0' & a_sync;
    -------------------------------------------------
    u_b_disp: bcd_to_sev_seg --disp b input

        port map(
            bcd => b_bcd_sync,
            hex0 => b_bcd

        );
    -------------------------------------------------
    b_bcd_sync <= '0' & b_sync; --
    ------------------------------------------------
    u_add_button: rising_edge_synchronizer

        port map(

            clk => clk,
            reset => reset,
            input => add_button,
            edge => add_en


        );

    u_sub_button: rising_edge_synchronizer

        port map(
            clk => clk,
            reset => reset,
            input => sub_button,
            edge => sub_en

        );

    u_result_disp: bcd_to_sev_seg

        port map(
            bcd => result_signal,
            hex0 => result_bcd

        );

    --end port maps

    -----------------------------------------------
    --begin processes
    u_mux: process(reset, clk)
    begin
        if reset = '1' then
            flag <= '0';
        elsif rising_edge(clk) then
            if(add_en = '1') then
                flag <= '0';
            elsif (sub_en = '1') then
                flag <= '1';
            end if;
        end if;
    end process;


    synchronized_output: process(reset, clk)
    begin
        if reset = '1' then
            result_signal <= "0000";
        elsif rising_edge(clk) then
            result_signal <= result;
        end if;

    end process;




    ----------------------------------------------
end beh;
