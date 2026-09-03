-------------------------------------------------------------------------------
-- Ethan Saber
-- single bit full adder [struct]
--09.03.26
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;     


entity full_adder_single_bit_struct is
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    sum     : out std_logic;
    cout    : out std_logic
  );
end full_adder_single_bit_struct;

architecture struct of full_adder_single_bit_struct is


--component and operation
  component alu_and
    port(
      a   :in std_logic;
      b   :in std_logic;
      c_out :out std_logic

    );
    end component;


--component or operation
  component alu_or
    port(
      a   :in std_logic;
      b   :in std_logic;
      c_a :in std_logic;
      c_out   :out std_logic

    );
  end component;
--component xor operation
  component alu_xor
    port(
      a   :in std_logic;
      b   :in std_logic;
      c_out  :out std_logic

    );
  end component;

 --end components--

--temp signals if needed

  signal temp1 : std_logic;
  signal temp2 : std_logic;
  signal temp3 : std_logic;
  signal temp4 : std_logic;
  signal temp5 : std_logic;
  signal temp6 : std_logic;
  signal temp7 : std_logic;

--end temp signals

begin
  --port maps / instance(s)

  --done
  and_instance : alu_and
  port map(

    a => a,
    b => b,
    c_out =>temp1

  );
  --done
  and1_instance : alu_and
    port map(

    a => a,
    b => cin,
    c_out =>temp2

    );
  --done
  and2_instance : alu_and
    port map(

    a => b,
    b => cin,
    c_out => temp3

    );

  or_instance : alu_or
    port map(

    a => temp1,
    b => temp2,
    c_a => temp3,
    c_out => cout

    );

  xor_instance : alu_xor
    port map(

    a => a,
    b => b,
    c_out => temp5

    );

  xor1_instance : alu_xor
    port map(

    a => temp5,
    b => cin,
    c_out => sum

    );

end struct; 