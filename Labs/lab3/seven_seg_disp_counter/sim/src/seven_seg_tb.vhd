-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg_tb is
end seven_seg_tb;

architecture arch of seven_seg_tb is

  constant period : time := 20 ns;

  signal clk           : std_logic := '0';
  signal reset         : std_logic := '1';
  signal bcd           : std_logic_vector(3 downto 0) := (others => '0');
  signal seven_seg_out : std_logic_vector(6 downto 0);

begin

  sequential_tb : process
  begin
    report "****************** sequential testbench start ****************";
    wait for 80 ns;
    for i in 0 to 9 loop
      bcd <= std_logic_vector(unsigned(bcd)+1);
      wait for 40 ns;
    end loop;
    report "****************** sequential testbench stop ****************";
    wait;
  end process;

  clock : process
  begin
    clk <= not clk;
    wait for period / 2;
  end process;

  async_reset : process
  begin
    wait for 2 * period;
    reset <= '0';
    wait;
  end process;

  uut : entity work.seven_seg_sim
    port map (
    clk           => clk,
    reset         => reset,
    bcd           => bcd,
    seven_seg_out => open
    );

end arch;