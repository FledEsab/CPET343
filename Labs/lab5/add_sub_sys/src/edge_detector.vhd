-------------------------------------------------------------------------------
-- Dr. Kaputa
--  edge detect
--[sub-module]
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE edge_detector_pkg IS
  COMPONENT edge_detector
    PORT (
      clock       : IN  std_logic;
      reset_n     : IN  std_logic;
      data_i      : IN  std_logic;
      --
      RisingEdge  : OUT std_logic;
      FallingEdge : OUT std_logic
      );
  END COMPONENT edge_detector;
END PACKAGE edge_detector_pkg;


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY edge_detector IS
  PORT (
    clock       : IN  std_logic;
    reset_n     : IN  std_logic;
    data_i     : IN  std_logic;
    --
    RisingEdge  : OUT std_logic;
    FallingEdge : OUT std_logic
    );
END ENTITY edge_detector;

ARCHITECTURE behave OF edge_detector IS

  SIGNAL prev_d_i1 : std_logic;
  SIGNAL prev_d_i2 : std_logic;

BEGIN


  RisingEdgeDetector : PROCESS (reset_n, clock)
  BEGIN
    IF (reset_n = '0') THEN
      prev_d_i1 <= '0';
      prev_d_i2 <= '0';
      RisingEdge  <= '0';
      FallingEdge <= '0';
    ELSIF (clock'event AND clock = '1') THEN
      prev_d_i1 <= data_i;
      prev_d_i2 <= prev_d_i1;
      RisingEdge  <= ((NOT prev_d_i2) AND prev_d_i1);
      FallingEdge <= (prev_d_i2 AND (NOT prev_d_i1));
    END IF;
  END PROCESS RisingEdgeDetector;



END ARCHITECTURE behave;

