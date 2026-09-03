-------------------------------------------------------------------------------
-- Ethan Saber
-- single bit full adder [struct]
--09.03.26
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all;      

entity full_adder_single_bit_struct is
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    sum     : out std_logic;
    cout    : out std_logic
  );
end full_adder_single_bit_beh;

architecture struct of full_adder_single_bit_struct is

signal x : std_logic_vector(1 downto 0);
signal av: std_logic_vector(1 downto 0);
signal bv: std_logic_vector(1 downto 0);
signal cinv: std_logic_vector(1 downto 0);

--component and
  component alu_and
    port(
      a   :in std_logic_vector(1 downto 0);
      b   :in std_logic_vector(1 downto 0);
      c_in :out std_logic_vector(1 downto 0);

    );
    end component;
--component or
  component alu_or
    port(
      a   :in std_logic_vector(1 downto 0);
      b   :in std_logic_vector(1 downto 0);
      c_in   :out std_logic_vector(1 downto 0);

    );
  end component;
--component xor
  component alu_xor
    port(
      a   :in std_logic_vector(1 downto 0);
      b   :in std_logic_vector(1 downto 0);
      c_in  :out std_logic_vector(1 downto 0);

    );
  end component;
 --end components

--temp signals if needed
--end temp signals

begin
  --port maps
  u_and : alu_and
  port map(

    a => a,
    b => b,
    c_in =>

  );
  u_and1 : alu_and1
    port map(

    a => a,
    b => b,
    c_in =>

    );
  u_or : alu_or
    port map(

    a => b,
    b => cin,
    c_out =>

    );
  u_or1 : alu_or1
    port map(

    a =>
    b =>
    c_in =>

    );
  u_xor : alu_xor
    port map(

    a =>
    b =>
    c_in =>

    );
  u_xor1 : alu_xor1
    port map(

    a =>
    b =>
    c_in =>

    );

end beh; 