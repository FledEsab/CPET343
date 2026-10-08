-----------------------------------------------------------------------------------
    --Top
    --Designer: Ethan Saber
    --Purpose:  Calculator [top]
    --Date:     10.7.26
-----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use iee.numeric_std.all;

entity calculator_top is
    port(
    clk         :in std_logic;
    reset       :in std_logic;
    a           :in std_logic_vector(2 downto 0);
    b           :in std_logic_vector(2 downto 0);
    add_button  :in std_logic;
    sub_button  :in std_logic;
    a_bcd       :out std_logic_vector(6 downto 0);
    b_bcd       :out std_logic_vector(6 downto 0);
    result_bcd  :out std_logic_vector(6 downto 0)
);
    end entity calculator_top;

architecture beh of calculator_top is

--component declarations
component rising_edge_synchronizer is
port(
    clk :in std_logic;
    reset :in std_logic;
    input
    edge

    );
    end component;

component synchronizer_3bit is
    port(
    clk :in std_logic;
    reset :in std_logic;

    );

component generic_calculator is
    port(

    );
    end component;

