----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2020 07:48:15 PM
-- Design Name: 
-- Module Name: Counter - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
  Port (
    clk: in std_logic;
    clk_en: in std_logic;
    R: in std_logic;
    load: in std_logic_vector(1 downto 0);
    dir: in std_logic;
    count: out std_logic_vector(15 downto 0)
  );
end Counter;

architecture Behavioral of Counter is
signal count_aux: std_logic_vector(15 downto 0) := (others => '0');
begin

--process (clk,R,load)
--begin
--    if R='1' then
--         count_aux <= (others => '0');
--    elsif load="01" then
--        count_aux <= count_aux + 1;
--    elsif load="10" then
--        count_aux <= count_aux + x"0100";
--    elsif clk='1' and clk'event then
--        if clk_en='1' then
--            if dir='0' then
--               count_aux <= count_aux + 1;
--            else
--               count_aux <= count_aux - 1;
--            end if;
--         end if;
--    end if;
--end process;

process (clk,R,load)
begin
    if clk='1' and clk'event then
        if R='1' then
            count_aux <= (others => '0');
        elsif load="01" then
            if count_aux(7 downto 0) = x"59" then
                count_aux(7 downto 0) <= x"00";
            elsif count_aux(3 downto 0) = x"9" then
                count_aux(3 downto 0) <= x"0";
                count_aux(15 downto 4) <= count_aux(15 downto 4) + 1;
            else
                count_aux <= count_aux + 1;
            end if;
        elsif load="10" then
            if count_aux(15 downto 8) = x"99" then
                count_aux(15 downto 8) <= x"00";
            elsif count_aux(11 downto 8) = x"9" then
                count_aux(11 downto 8) <= x"0";
                count_aux(15 downto 12) <= count_aux(15 downto 12) + 1;
            else
                count_aux <= count_aux + x"0100";
            end if;
        elsif clk_en='1' then
            if dir='0' then
               if count_aux(15 downto 0) = x"9959" then
                    count_aux(15 downto 0) <= x"0000";
                elsif count_aux(11 downto 0) = x"959" then
                    count_aux(11 downto 0) <= x"000";
                    count_aux(15 downto 12) <= count_aux(15 downto 12) + 1;
                elsif count_aux(7 downto 0) = x"59" then
                    count_aux(7 downto 0) <= x"00";
                    count_aux(15 downto 8) <= count_aux(15 downto 8) + 1;
                elsif count_aux(3 downto 0) = x"9" then
                    count_aux(3 downto 0) <= x"0";
                    count_aux(15 downto 4) <= count_aux(15 downto 4) + 1;
                else
                    count_aux <= count_aux + 1;
               end if;
               
            else
               if count_aux(15 downto 0) = x"0000" then
                    
                elsif count_aux(11 downto 0) = x"000" then
                    count_aux(11 downto 0) <= x"959";
                    count_aux(15 downto 12) <= count_aux(15 downto 12) - 1;
                elsif count_aux(7 downto 0) = x"00" then
                    count_aux(7 downto 0) <= x"59";
                    count_aux(11 downto 8) <= count_aux(11 downto 8) - 1;
                elsif count_aux(3 downto 0) = x"0" then
                    count_aux(3 downto 0) <= x"9";
                    count_aux(7 downto 4) <= count_aux(7 downto 4) - 1;
                else
                    count_aux <= count_aux - 1;
                end if;
               
            end if;
         end if;
    end if;
end process;

count <= count_aux;

end Behavioral;
