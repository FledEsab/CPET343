LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
use work.generic_subtractor_pkg.all;
use work.generic_adder_pkg.all;
use work.synchronizer_8bit_pkg.all;
use work.bcd_to_sev_sev_pkg.all;
use work.double_dabble_pkg.all;
--use work.falling_edge_synchronizer_pkg.all; -- this needs to be implimented and instantiated
use work.edge_detector_pkg.all;

ENTITY add_sub_8bit_tb IS
END add_sub_8bit_tb;

ARCHITECTURE arch OF add_sub_8bit_tb IS
  SIGNAL sim_done : boolean   := false;
  -- Constants for test bench design
  CONSTANT PERIOD_c    : time    := 20 ns;
  CONSTANT MAX_COUNT_c : integer := 7;

  -- signals for test bench design
  SIGNAL a_tb : std_logic_vector(7 DOWNTO 0) := "00000000";
  SIGNAL b_tb : std_logic_vector(7 DOWNTO 0) := "00000000";
  SIGNAL hexOut_tb        : std_logic_vector(6 DOWNTO 0) := (OTHERS => '0');
  SIGNAL hexA_tb          : std_logic_vector(6 DOWNTO 0) := (OTHERS => '0');
  SIGNAL hexB_tb          : std_logic_vector(6 DOWNTO 0) := (OTHERS => '0');
  SIGNAL clk_tb		   : std_logic := '0';
  signal reset_n_tb	   : std_logic;
  signal pb_tb		   : std_logic := '0';
  signal led_tb        : std_logic_vector(3 downto 0) := "0000";

  -- create a new type, an array seven-segment values (ie: 2D array)
  TYPE seven_seg_t IS ARRAY (0 TO 16) OF std_logic_vector (6 DOWNTO 0);
  SIGNAL seven_seg_values : seven_seg_t := (
                          ZERO_c, ONE_c, TWO_c, THREE_c, FOUR_c, FIVE_c,
                          SIX_c, SEVEN_c, EIGHT_c, NINE_c, A_c, B_c, C_c,
						  D_c, E_c, F_c, BLANK_c);


BEGIN
clk_tb <= NOT clk_tb AFTER PERIOD_c/2 WHEN (NOT sim_done) ELSE '0';
--pb_tb <= NOT pb_tb AFTER 60ns WHEN (NOT sim_done) ELSE '0';
  -- instantiate the Unit Under Test
  UUT : core_add_sub PORT MAP(
    clock_50mhz   => clk_tb,
	bcd_input	    => a_tb,
	--b_in	    => b_tb,
	rst_n	    => reset_n_tb,
	manual_event_clk_push_button	    => pb_tb,
	--
	hex2_hundreds	             => hexA_tb,
	hex1_tens	             => hexB_tb,
	hex0_ones	             => hexOut_tb,
	state_debug_led      => led_tb
);


  -----------------------------------------------------------------------------
  -- PROCESS: Stimulus will generate a counter that counts from 0 to max count
  -- and then stop. For each input, out will be verified.
  -----------------------------------------------------------------------------
  stimulus : PROCESS
  BEGIN
	reset_n_tb <= '0';
	pb_tb <= '1';
    -- now lets sync the stimulus to the clock
    -- and move data off clock edge
    WAIT UNTIL (clk_tb'event and clk_tb = '1');
	reset_n_tb <= '1';
	pb_tb <= not pb_tb;
	a_tb <= "00000101"; -- A = 5
    WAIT FOR 8*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	a_tb <= "00000010"; -- B = 2
	WAIT FOR 8*PERIOD_c;
	--Wait for Addition and Subtraction
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 8*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 8*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;


	a_tb <= "00000010"; -- A = 2
    WAIT FOR 8*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	a_tb <= "00000101"; -- B = 5
	WAIT FOR 8*PERIOD_c;
	--Wait for Addition and Subtraction
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 8*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 8*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;

	a_tb <= "11001000"; -- A = 200
    WAIT FOR 8*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	a_tb <= "01100100"; -- B = 100
	WAIT FOR 8*PERIOD_c;
	--Wait for Addition and Subtraction
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 8*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 8*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;

    a_tb <= "01100100"; -- A = 100
    WAIT FOR 8*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	a_tb <= "11001000"; -- B = 200
	WAIT FOR 8*PERIOD_c;
	--Wait for Addition and Subtraction
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 8*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 8*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
	pb_tb <= not pb_tb;
	WAIT FOR 1*PERIOD_c;
    --WAIT FOR 75 * PERIOD_c;


    -- we are done to wait two more clocks & set flag sim_done to true
    WAIT FOR 2 * PERIOD_c;
    WAIT UNTIL clk_tb = '0';
    sim_done <= true;

    -- Added a simple message to say we are done
    REPORT "Simulation Completed Successfully.";

    WAIT;                               -- wait here forever
END PROCESS;

END ARCHITECTURE arch;