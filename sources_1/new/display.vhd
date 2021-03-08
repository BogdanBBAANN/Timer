----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/18/2020 04:14:10 PM
-- Design Name: 
-- Module Name: display - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
  Port (
    clk: in std_logic;
    r: in std_logic;
    data: in std_logic_vector(15 downto 0);
    seg: out std_logic_vector(6 downto 0);
    an: out std_logic_vector(3 downto 0)
  );
end display;

architecture Behavioral of display is

constant CNT_100HZ : integer := 2**20;                  -- divizor pentru rata de reimprospatare de ~100 Hz (cu un ceas de 100 MHz)
signal Num         : integer range 0 to CNT_100HZ - 1 := 0;
signal NumV        : STD_LOGIC_VECTOR (19 downto 0) := (others => '0');    
signal LedSel      : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
signal Hex         : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

begin

-- Proces pentru divizarea ceasului
divclk: process (Clk)
    begin
    if (Clk'event and Clk = '1') then
        if (r = '1') then
            Num <= 0;
        elsif (Num = CNT_100HZ - 1) then
            Num <= 0;
        else
            Num <= Num + 1;
        end if;
    end if;
    end process;

    NumV <= CONV_STD_LOGIC_VECTOR (Num, 20);
    LedSel <= NumV (19 downto 18);

-- Selectia anodului activ
    An <= "1110" when LedSel = "00" else
          "1101" when LedSel = "01" else
          "1011" when LedSel = "10" else
          "0111" when LedSel = "11" else
          "1111";

-- Selectia cifrei active
    Hex <= Data (3  downto  0) when LedSel = "00" else
           Data (7  downto  4) when LedSel = "01" else
           Data (11 downto  8) when LedSel = "10" else
           Data (15 downto 12) when LedSel = "11" else
           X"0";

-- Activarea/dezactivarea segmentelor cifrei active
    Seg <= "1111001" when Hex = "0001" else            -- 1
           "0100100" when Hex = "0010" else            -- 2
           "0110000" when Hex = "0011" else            -- 3
           "0011001" when Hex = "0100" else            -- 4
           "0010010" when Hex = "0101" else            -- 5
           "0000010" when Hex = "0110" else            -- 6
           "1111000" when Hex = "0111" else            -- 7
           "0000000" when Hex = "1000" else            -- 8
           "0010000" when Hex = "1001" else            -- 9
           "0001000" when Hex = "1010" else            -- A
           "0000011" when Hex = "1011" else            -- b
           "1000110" when Hex = "1100" else            -- C
           "0100001" when Hex = "1101" else            -- d
           "0000110" when Hex = "1110" else            -- E
           "0001110" when Hex = "1111" else            -- F
           "1000000";
           

end Behavioral;
