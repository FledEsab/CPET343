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
    manual_event_clk_push_button             :in std_logic := 0;
    hex0_ones                                :out std_logic_vector(7 downto 0);
    hex1_tens                                :out std_logic_vector(7 downto 0);
    hex2_hundreds                            :out std_logic_vector(7 downto 0);
    state_debug_led                          :out std_logic_vector(3 downto 0) := "0000"
);
end component;
    end package;

    library ieee;
    use ieee.std_logic_1164;
    use ieee.numeric_std;

    --work files here please
    library work;
    use work.generic_subtractor_pkg.all;
    use work.generic_adder_pkg.all;
    use work.synchronizer_8bit_pkg.all;
    use work.bcd_to_sev_sev_pkg.all;
    use work.double_dabble_pkg.all;

    --work files end here

    --begin entity for core
        entity core_add_sub is
    port(
--ports for core add sub
    );
    end core_add_sub;
    --end entity for core

    --architecture of core here begin
    architecture core_logic of core_add_sub is

    --FSM states
------------------------------------------------------------------
    type fsm_states is (input_a, input_b, disp_sum, disp_diff);
    signal --signals defining states
------------------------------------------------------------------
    --internal signals
------------------------------------------------------------------
    signal a_sync: std_logic_vector(7 downto 0);
    signal b_sync: std_logic_vector(7 downto 0);
    signal i_btn_sync : std_logic := '0'; --i denotes input pin, sync denotes synchronization
    signal add_en: std_logic;
    signal sub_en: std_logic;
    signal result: std_logic_vector(3 downto 0);
    signal result_signal: std_logic_vector(3 downto 0);
    signal flag: std_logic;
--------------------------------------------------------------------
    begin

    --port maping
--------------------------------------------------------------------
    u_sync_a: synchronizer_8bit
    port map (

    clk => clk,
        reset => reset,
        async_in => a,
    sync_out => a_sync

    );


    u_add: generic_adder

    generic map(
    bits => NUM_BITS
    )

    port map(
    a => a_sync,
        b => b_sync,
        flag => flag,
    c => result
    );

    u_subtract: generic_subtractor

    generic map(
    bits => NUM_BITS
    )

    port map(
    a => a_sync,
        --b => b_sync,
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
    u_manual_clk: rising_edge_synchronizer

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

    u_dd: double_dabble
    port map(

    result_padded => ,
    ones          => ,
    tens          => ,
    hundreds      => ,

    );
--------------------------------------------------------------------
    --end port maping
    synchronized_output: process(reset, clock_50mhz)
    begin
        if reset = '1' then
        result_signal <= "0000";
elsif rising_edge(clk) then
    result_signal <= result;
    end if;

    end process;
