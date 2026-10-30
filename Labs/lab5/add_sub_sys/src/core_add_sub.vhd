--------------------------------------------------------------------------------------
--Designer:               Ethan Saber
--Purpose:                Functional Top
--Original Date Created:  10.29.24
--Date Modified:          10.29.26
--------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package core_add_sub_pkg is
    component core_add_sub is

        port(
            --ports here
            --name clk: clock_50Mhz
            clock_50mhz                              :in std_logic;
            bcd_input                                :in std_logic_vector(7 downto 0);
            rst_n                                    :in std_logic;
            manual_event_clk_push_button             :in std_logic := '0';
            hex0_ones                                :out std_logic_vector(6 downto 0);
            hex1_tens                                :out std_logic_vector(6 downto 0);
            hex2_hundreds                            :out std_logic_vector(6 downto 0);
            state_debug_led                          :out std_logic_vector(3 downto 0) := "0000"
        );
    end component;
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;

--work files here please
library work;
use work.generic_subtractor_pkg.all;
use work.generic_adder_pkg.all;
use work.synchronizer_8bit_pkg.all;
use work.bcd_to_sev_seg_pkg.all;
use work.double_dabble_pkg.all;
--use work.falling_edge_synchronizer_pkg.all; -- this needs to be implimented and instantiated
use work.edge_detector_pkg.all;

--work files end here

--begin entity for core
entity core_add_sub is
    port(
        clock_50mhz                              :in std_logic;
        bcd_input                                :in std_logic_vector(7 downto 0);
        rst_n                                    :in std_logic;
        manual_event_clk_push_button             :in std_logic := '0';
        hex0_ones                                :out std_logic_vector(6 downto 0);
        hex1_tens                                :out std_logic_vector(6 downto 0);
        hex2_hundreds                            :out std_logic_vector(6 downto 0);
        state_debug_led                          :out std_logic_vector(3 downto 0) := "0000"

    );
end core_add_sub;
--end entity for core

--architecture of core here begin
architecture core_logic of core_add_sub is

    --FSM states
    ------------------------------------------------------------------
    type fsm_states is (input_a, input_b, disp_sum, disp_diff);
    signal current_state, next_state : fsm_states;--signals defining states
    ------------------------------------------------------------------
    --internal signals
    ------------------------------------------------------------------
    signal a_sync                     : std_logic_vector(7 downto 0);
    signal b_sync                     : std_logic_vector(7 downto 0);
    signal a_d                        : std_logic_vector(7 downto 0);
    signal b_d                        : std_logic_vector(7 downto 0);
    signal add_o                      : std_logic_vector(7 downto 0);
    signal sub_o                      : std_logic_vector(7 downto 0);
    signal add_d                      : std_logic_vector(7 downto 0);
    signal sub_d                      : std_logic_vector(7 downto 0);
    signal sig_o                      : std_logic_vector(7 downto 0);
    signal r_o_12bits                 : std_logic_vector(11 downto 0);
    signal hex_ones, hex_tens, hex_hundreds : std_logic_vector(3 downto 0);
    signal manual_event_clk_push_button_sync : std_logic;
    signal rst_edge                   : std_logic;
    signal button_pulse               :std_logic;
    signal brc_a, brc_s               : std_logic;
    signal brc_a_d : std_logic;
    signal brc_s_d : std_logic;

    -------------------------------------------------------------------
    --constants for state debug led and other, we want this to never change!!!
    constant led_o_0  : std_logic_vector(3 downto 0) := "0001";
    constant led_o_1  : std_logic_vector(3 downto 0) := "0010";
    constant led_o_2  : std_logic_vector(3 downto 0) := "0100";
    constant led_o_3  : std_logic_vector(3 downto 0) := "1000";
    constant cZero0   : std_logic_vector(7 downto 0) := (others => '0');
    constant cZero1   : std_logic_vector(11 downto 0) := (others => '0');
    constant pad4Bits : std_logic_vector(3 downto 0) := "0000";
    constant pad3Bits : std_logic_vector(2 downto 0) := "000";
    constant pb_i     :std_logic := '1';

    --------------------------------------------------------------------
begin

    --port maping
    --------------------------------------------------------------------
    u_sync_a: synchronizer_8bit
        port map (

            clk => clock_50mhz,
            reset =>  rst_n,
            async_in => bcd_input,
            sync_out => a_sync

        );
    u_sync_b: synchronizer_8bit
        port map (
            clk      => clock_50mhz,
            reset    =>  rst_n,
            async_in => bcd_input,
            sync_out => b_sync
        );
    ---------------------------------------------------------------------------------------------
    u_add: generic_adder
        generic map(
            bits => 8
        )
        port map(
            a => a_d,
            b => b_d,
            cin => '0',
            bcd_result_1 => add_o,
            bcd_result_cout => brc_a --a denotes add
        );

    u_subtract: generic_subtractor

        generic map(
            bits => 8
        )
        port map(
            a => a_d,
            b => b_d,
            cin => '0',
            bcd_result_1 => sub_o,
            bcd_result_cout => brc_s --brc denotes bcd_result_cout
        );
    -----------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------
    u_hex_disp_1: bcd_to_sev_seg --disp a input
        port map(
            bcd => hex_ones,
            seven_segment_display_out => hex0_ones
        );
    --------------------------------------------------------------------------------------------
    u_hex_disp_10: bcd_to_sev_seg
        port map(
            bcd => hex_tens ,
            seven_segment_display_out => hex1_tens
        );
    ------------------------------------------------------------------------------------------
    u_hex_disp_100: bcd_to_sev_seg
        port map(
            bcd => hex_hundreds,
            seven_segment_display_out => hex2_hundreds
        );
    -------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------
    ------------------------------------------------
    --a_bcd_sync <= '0' & a_sync;
    -------------------------------------------------

    -------------------------------------------------
    --b_bcd_sync <= '0' & b_sync; --
    ------------------------------------------------
    manual_event_clk: edge_detector
        port map(
            clock => clock_50mhz,
            reset_n => rst_n,
            data_i => manual_event_clk_push_button,
            RisingEdge => open,
            FallingEdge =>  manual_event_clk_push_button_sync
        );

    edge_detector_rst: edge_detector
        port map(
            clock => clock_50mhz,
            reset_n => '1',
            data_i => rst_n,
            RisingEdge => rst_edge,
            FallingEdge => open

        );


    u_dd: double_dabble
        port map(

            result_padded => r_o_12bits,
            ones          => hex_ones,
            tens          => hex_tens ,
            hundreds      => hex_hundreds

        );
    --------------------------------------------------------------------
    --end port maping
    ----------------------------------------------------------------------------------------
    synchronized_output: process(rst_edge, clock_50mhz)
    begin
        if rst_edge = '1' then
            current_state <= input_a;
        elsif rising_edge(clock_50mhz) then
            current_state <= next_state;
        end if;
    end process;
    ------------------------------------------------------------------------------------------------------
    FSM_Logic: process(current_state, a_sync, b_sync, rst_edge,manual_event_clk_push_button_sync)
    begin
        case(current_state) is
            when input_a => state_debug_led <= led_o_0;
                if(manual_event_clk_push_button_sync = pb_i) then
                    next_state <= input_b;
                else
                    next_state <= input_a;
                end if;
            when input_b => state_debug_led <= led_o_1;
                if(manual_event_clk_push_button_sync = pb_i) then
                    next_state <= disp_sum;
                else
                    next_state <= input_b;
                end if;
            when disp_sum => state_debug_led <= led_o_2;
                if(manual_event_clk_push_button_sync = pb_i) then
                    next_state <= disp_diff;
                else
                    next_state <= disp_sum;
                end if;
            when disp_diff => state_debug_led <= led_o_3;
                if(manual_event_clk_push_button_sync = pb_i) then
                    next_state <= input_a;
                else
                    next_state <= disp_diff;
                end if;
            --when others (like a reset press)
            when others => next_state <= input_a;
        end case;
    end process;
    --process input_a stuff
    a_i: process(clock_50mhz, rst_edge, current_state, a_sync)
    begin
        if(rst_edge = '1') then
            a_d <= cZero0;
        elsif(clock_50mhz'event and clock_50mhz = '1')then
            case(current_state) is
                when input_a => a_d <= a_sync;
                when input_b => a_d <= a_d;
                when disp_sum => a_d <= a_d;
                when disp_diff => a_d <= a_d;
                when others=>a_d<=a_d;
            end case;
        end if;
    end process;

    --process input_b stuff(state)
    b_i:process(clock_50mhz, rst_edge, current_state, b_sync)
    begin
        if(rst_edge = '1') then
            b_d <= cZero0;
        elsif(clock_50mhz'event and clock_50mhz = '1')then
            case(current_state) is
                when input_a => b_d <= b_d;
                when input_b => b_d <= a_sync;
                when disp_sum => b_d <= b_d;
                when disp_diff => b_d <= b_d;
                when others => b_d <= b_d;
            end case;
        end if;
    end process;
    --we need to set adding process
    --stuff
    s_add: process(clock_50mhz, rst_edge)
    begin
        if rst_edge = '1' then
            add_d <= cZero0;
            brc_a_d <= '0';

        elsif rising_edge(clock_50mhz) then
            if current_state = disp_sum then
                add_d <= add_o;
                brc_a_d <= brc_a;
            end if;
        end if;
    end process;
    s_sub: process(clock_50mhz, rst_edge)
    begin
        if rst_edge = '1' then
            sub_d <= cZero0;
            brc_s_d <= '0';

        elsif rising_edge(clock_50mhz) then
            if current_state = disp_diff then
                sub_d <= sub_o;
                brc_s_d <= brc_s;
            end if;
        end if;
    end process;
    s_o_state: process(clock_50mhz, rst_edge, current_state, sig_o)
    begin
        if(rst_edge = '1') then
            sig_o <= cZero0;
        elsif(clock_50mhz'event and clock_50mhz = '1') then
            case(current_state) is
                when input_a => sig_o <= a_d;
                when input_b => sig_o <= b_d;
                when disp_sum => sig_o <= add_d;
                when disp_diff => sig_o <= sub_d;
                when others => sig_o <= sig_o;
            end case;
        end if;
    end process;


    --we need to set output to 12-bits
    --stuff
    s_o_12b: process(clock_50mhz, rst_edge, current_state, sig_o)    --r_o denotes result out and 12-bit size
    begin
        if(rst_edge = '1') then
            r_o_12bits <= cZero1;
        elsif(clock_50mhz'event and clock_50mhz = '1') then
            case(current_state) is
                when input_a   => r_o_12bits <= pad4Bits & sig_o;
                when input_b   => r_o_12bits <= pad4Bits & sig_o;
                when disp_sum  => r_o_12bits <= pad3Bits & brc_a_d & sig_o;
                when disp_diff => r_o_12bits <= pad3Bits & brc_s_d & sig_o;
            end case;
        end if;
    end process;


end core_logic;