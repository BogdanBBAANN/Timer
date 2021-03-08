----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2020 07:21:38 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
  Port (
    clk: in std_logic;
    START: in std_logic;
    M: in std_logic;
    S: in std_logic;
    R: in std_logic;
    set: out std_logic_vector(1 downto 0);
    rst: out std_logic;
    enable: out std_logic;
    dir: out std_logic
  );
end UC;

architecture Behavioral of UC is

type TIP_STARE is (idle, countUp, stopCounting, countDown, incremM, incremS);
signal Stare : TIP_STARE := idle;

begin

proc1: process (clk)
begin
    if R = '1' then
        Stare <= idle;
    elsif M='1' then
        Stare <= incremM;
    elsif S='1' then
        Stare <= incremS;
    else
        if RISING_EDGE (clk) then
            case Stare is
                when idle =>
                    if (START = '1') then
                        Stare <= countUp;
                    else -- else nu este necesar
                        Stare <= idle;
                    end if;
                when countUp =>
                    if (START = '1') then
                        Stare <= stopCounting;
                    else -- RW = '0'
                        Stare <= countUp;
                    end if;
                when stopCounting =>
                    if (START = '1') then
                        Stare <= countUp;
                    end if;
                when incremM =>
                    if (START = '1') then
                        Stare <= countDown;
                    end if;
                when incremS =>
                    if (START = '1') then
                        Stare <= countDown;
                    end if;
                when others =>
            end case;
        end if;
    end if;
end process;

proc2: process (Stare)
begin
    case Stare is
        when idle => set <= "00"; rst <= '1'; enable <= '0'; dir<='0';
        when countUp => set <= "00"; rst <= '0'; enable <= '1'; dir<='0';
        when stopCounting => set <= "00"; rst <= '0'; enable <= '0'; dir<='0';
        when countDown => set <= "00"; rst <= '0'; enable <= '1'; dir<='1';
        when incremM => set <= "10"; rst <= '0'; enable <= '0'; dir<='0';
        when incremS => set <= "01"; rst <= '0'; enable <= '0'; dir<='0';
        when others =>
    end case;
end process proc2;

end Behavioral;
