library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package memory_pkg is
component memory is
    generic (addr_width : integer := 2;
    data_width : integer := 8);
port (
    clk               : in std_logic;
    we                : in std_logic;
    addr              : in std_logic_vector(addr_width - 1 downto 0);
    din               : in std_logic_vector(data_width - 1 downto 0);
    dout              : out std_logic_vect bor(data_width - 1 downto 0)
    );
  end component;
 end package;

entity memory is
    port (
        clk               : in  std_logic;
        we                : in std_logic;--write enable
        addr              : in std_logic_vector(addr_width - 1 downto 0);
        din               : in std_logic_vector(data_width - 1 downto 0);
        dout              : out std_logic_vector(data_width - 1 downto 0)
    );
end memory;



architecture beh of memory is
    type
    signal
    begin