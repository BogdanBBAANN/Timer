----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2020 04:49:21 PM
-- Design Name: 
-- Module Name: UC_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC_tb is
--  Port ( );
end UC_tb;

architecture Behavioral of UC_tb is

constant CLK_PERIOD : TIME := 10 ns;
signal Clk: std_logic;
signal START:  std_logic := '0';
signal M:  std_logic := '0';
signal S:  std_logic := '0';
signal set:  std_logic_vector(1 downto 0);
signal rst:  std_logic;
signal enable:  std_logic;
signal dir:  std_logic;

begin

gen_clk: process
begin
    Clk <= '0';
    wait for (CLK_PERIOD/2);
    Clk <= '1';
    wait for (CLK_PERIOD/2);
end process gen_clk;

DUT: entity  WORK.UC port map(Clk,START,M,S,set,rst,enable,dir);
process
begin
    START <= '1'; wait for 30 ns;
    START <= '0'; wait for 30 ns;
    START <= '1'; wait for 30 ns;
    START <= '0'; wait for 30 ns;
    M <= '1'; wait for 30 ns;
    M <= '0'; wait for 30 ns;
    S <= '1'; wait for 30 ns;
    S <= '0'; wait for 30 ns;
    START <= '1'; wait for 30 ns;
end process;
end Behavioral;
