--------------------------------------------------------------------------------------
	--Designer:               Ethan Saber
	--Purpose:                Convert 4-bit input to 7-seg disp
	--Original Date Created:  12.05.24
	--Date Modified:          09.16.26
--------------------------------------------------------------------------------------

Library ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all; 


entity hex_ones_dig is

port(
	clk      :in std_logic;
	reset    :in std_logic;
	bcd      :in std_logic_vector(3 downto 0);
	hex0     :out std_logic_vector(6 downto 0)
);

end hex_ones_dig;

ARCHITECTURE beh of hex_ones_dig is
--what will ones dig be on hex display?
begin
process(reset,bcd)
begin
	if(reset = '1') then
		hex0 <= "1111111";--blank

	else

		case bcd is --this is case bcd since bcd is the 'value' we need to process

	    when "0000" => hex0 <= "1000000";  -- 0
      
		when "0001" => hex0 <= "1111001";  -- 1
      
		when "0010" => hex0 <= "0100100";  -- 2
      
		when "0011" => hex0 <= "0110000";  -- 3
      
		when "0100" => hex0 <= "0011001";  -- 4
      
		when "0101" => hex0 <= "0010010";  -- 5
      
		when "0110" => hex0 <= "0000010";  -- 6
      
		when "0111" => hex0 <= "1111000";  -- 7
      
		when "1000" => hex0 <= "0000000";  -- 8
      
		when "1001" => hex0 <= "0011000";  -- 9
      
		--when "0000001010" => ones_dig_1 <= "0001000";  -- A
      
		--when "0000001011" => ones_dig_1 <= "0000011";  -- B
      
		--when "0000001100" => ones_dig_1 <= "1000110";  -- C
      
		--when "0000001101" => ones_dig_1 <= "0100001";  -- D
      
		--when "0000001110" => ones_dig_1 <= "0000110";  -- E
      
		--when "0000001111" => ones_dig_1 <= "0001110";  -- F
      
		when others => hex0 <= "1111111";--sets all other segments off

        end case;
		end if;
end process;
end beh;
