-------------------------------------------------------------------------------
-- Ethan Saber
-- single bit full adder [struct]
--09.03.26
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;     


entity full_adder_single_bit_struct is
  port (
    a       : in std_logic_vector(1 downto 0);
    b       : in std_logic_vector(1 downto 0);
    cin     : in std_logic_vector(1 downto 0);
    sum     : out std_logic_vector(1 downto 0);
    cout    : out std_logic_vector(1 downto 0)
  );
end full_adder_single_bit_struct;

architecture struct of full_adder_single_bit_struct is


--component and operation
  component alu_and
    port(
      a   :in std_logic_vector(1 downto 0);
      b   :in std_logic_vector(1 downto 0);
      c_out :out std_logic_vector(1 downto 0)

    );
    end component;


--component or operation
  component alu_or
    port(
      a   :in std_logic_vector(1 downto 0);
      b   :in std_logic_vector(1 downto 0);
      c_a :in std_logic_vector(1 downto 0);
      c_out   :out std_logic_vector(1 downto 0)

    );
  end component;
--component xor operation
  component alu_xor
    port(
      a   :in std_logic_vector(1 downto 0);
      b   :in std_logic_vector(1 downto 0);
      c_out  :out std_logic_vector(1 downto 0)

    );
  end component;

 --end components--

--temp signals if needed

  signal temp1 : std_logic_vector(1 downto 0);
  signal temp2 : std_logic_vector(1 downto 0);
  signal temp3 : std_logic_vector(1 downto 0);
  signal temp4 : std_logic_vector(1 downto 0);
  signal temp5 : std_logic_vector(1 downto 0);
  signal temp6 : std_logic_vector(1 downto 0);
  signal temp7 : std_logic_vector(1 downto 0);

--end temp signals

begin
  --port maps / instance(s)

  --done
  u_and : alu_and
  port map(

    a => a,
    b => b,
    c_out =>temp1

  );
  --done
  u_and1 : alu_and
    port map(

    a => a,
    b => cin,
    c_out =>temp2

    );
  --done
  u_and2 : alu_and
    port map(

    a => b,
    b => cin,
    c_out =>temp3

    );

  u_or : alu_or
    port map(

    a => temp1,
    b => temp2,
    c_a => temp3,
    c_out => cout

    );

  u_xor : alu_xor
    port map(

    a => a,
    b => b,
    c_out => temp5

    );

  u_xor1 : alu_xor
    port map(

    a => temp5,
    b => cin,
    c_out => sum

    );

end struct; 