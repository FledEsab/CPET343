LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;

use work.generic_subtractor_pkg.all;
use work.generic_adder_pkg.all;
use work.synchronizer_8bit_pkg.all;
use work.bcd_to_sev_seg_pkg.all;
use work.double_dabble_pkg.all;
--use work.falling_edge_synchronizer_pkg.all; -- this needs to be implimented and instantiated
use work.edge_detector_pkg.all;
use work.core_add_sub_pkg.all;

ENTITY add_sub_8bit_tb IS
END add_sub_8bit_tb;

ARCHITECTURE arch OF add_sub_8bit_tb IS
  SIGNAL sim_done : boolean   := false;
  -- Constants for test bench design
  CONSTANT PERIOD_c    : time    := 20 ns;
  CONSTANT MAX_COUNT_c : integer := 7;
	constant ZERO_c  : std_logic_vector(6 downto 0) := "1000000";
	constant ONE_c   : std_logic_vector(6 downto 0) := "1111001";
	constant TWO_c   : std_logic_vector(6 downto 0) := "0100100";
	constant THREE_c : std_logic_vector(6 downto 0) := "0110000";
	constant FOUR_c  : std_logic_vector(6 downto 0) := "0011001";
	constant FIVE_c  : std_logic_vector(6 downto 0) := "0010010";
	constant SIX_c   : std_logic_vector(6 downto 0) := "0000010";
	constant SEVEN_c : std_logic_vector(6 downto 0) := "1111000";
	constant EIGHT_c : std_logic_vector(6 downto 0) := "0000000";
	constant NINE_c  : std_logic_vector(6 downto 0) := "0011000";
	constant A_c     : std_logic_vector(6 downto 0) := "0001000";
	constant B_c     : std_logic_vector(6 downto 0) := "0000011";
	constant C_c     : std_logic_vector(6 downto 0) := "1000110";
	constant D_c     : std_logic_vector(6 downto 0) := "0100001";
	constant E_c     : std_logic_vector(6 downto 0) := "0000110";
	constant F_c     : std_logic_vector(6 downto 0) := "0001110";
	constant BLANK_c : std_logic_vector(6 downto 0) := "1111111";

  -- signals for test bench design
  SIGNAL a_tb : std_logic_vector(7 DOWNTO 0) := "00000000";
  SIGNAL b_tb : std_logic_vector(7 DOWNTO 0) := "00000000";
  SIGNAL hexOut_tb        : std_logic_vector(6 DOWNTO 0) := (OTHERS => '0');
  SIGNAL hexA_tb          : std_logic_vector(6 DOWNTO 0) := (OTHERS => '0');
  SIGNAL hexB_tb          : std_logic_vector(6 DOWNTO 0) := (OTHERS => '0');
  SIGNAL clk_tb		   : std_logic := '0';
  signal reset_n_tb	   : std_logic;
  signal pb_tb		   : std_logic := '0'; --changed to 1
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

		procedure press_button is
		begin
			pb_tb <= '0';  -- Press (falling edge)
			WAIT FOR 4 * PERIOD_c;

			pb_tb <= '1';  -- Release
			WAIT FOR 4 * PERIOD_c;
		end procedure;

	BEGIN

		-- Reset
		reset_n_tb <= '0';
		pb_tb <= '1';

		WAIT FOR 4 * PERIOD_c;
		reset_n_tb <= '1';
		WAIT FOR 4 * PERIOD_c;

		------------------------------------------------
		-- TEST 1: A = 5, B = 2
		------------------------------------------------
		a_tb <= std_logic_vector(to_unsigned(5, 8));
		WAIT FOR 4 * PERIOD_c;
		press_button; -- input_a -> input_b

		a_tb <= std_logic_vector(to_unsigned(2, 8));
		WAIT FOR 4 * PERIOD_c;
		press_button; -- input_b -> disp_sum

		WAIT FOR 8 * PERIOD_c;
		press_button; -- disp_sum -> disp_diff

		WAIT FOR 8 * PERIOD_c;
		press_button; -- disp_diff -> input_a

		------------------------------------------------
		-- TEST 2: A = 2, B = 5
		------------------------------------------------
		a_tb <= std_logic_vector(to_unsigned(2, 8));
		WAIT FOR 4 * PERIOD_c;
		press_button;

		a_tb <= std_logic_vector(to_unsigned(5, 8));
		WAIT FOR 4 * PERIOD_c;
		press_button;

		WAIT FOR 8 * PERIOD_c;
		press_button;

		WAIT FOR 8 * PERIOD_c;
		press_button;

		------------------------------------------------
		-- TEST 3: A = 200, B = 100
		------------------------------------------------
		a_tb <= std_logic_vector(to_unsigned(200, 8));
		WAIT FOR 4 * PERIOD_c;
		press_button;

		a_tb <= std_logic_vector(to_unsigned(100, 8));
		WAIT FOR 4 * PERIOD_c;
		press_button;

		WAIT FOR 8 * PERIOD_c;
		press_button;

		WAIT FOR 8 * PERIOD_c;
		press_button;

		------------------------------------------------
		-- TEST 4: A = 100, B = 200
		------------------------------------------------
		a_tb <= std_logic_vector(to_unsigned(100, 8));
		WAIT FOR 4 * PERIOD_c;
		press_button;

		a_tb <= std_logic_vector(to_unsigned(200, 8));
		WAIT FOR 4 * PERIOD_c;
		press_button;

		WAIT FOR 8 * PERIOD_c;
		press_button;

		WAIT FOR 8 * PERIOD_c;
		press_button;

		------------------------------------------------
		-- END SIMULATION
		------------------------------------------------
		WAIT FOR 4 * PERIOD_c;

		sim_done <= true;

		REPORT "Simulation Completed Successfully.";

		WAIT;

	END PROCESS;

END ARCHITECTURE arch;