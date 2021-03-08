----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2020 07:12:52 PM
-- Design Name: 
-- Module Name: timer - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity timer is
    Port ( 
           reset_clk: in std_logic;
           clk: in std_logic;
           START : in STD_LOGIC;
           M : in STD_LOGIC;
           S : in STD_LOGIC;
           ResetTimer: in std_logic;
           seg: out std_logic_vector(6 downto 0);
           an: out std_logic_vector(3 downto 0)
           );
end timer;

architecture Behavioral of timer is

signal rst: std_logic := '0';
signal set: std_logic_vector(1 downto 0) := "00";
signal enable: std_logic := '0';
signal dir: std_logic := '0';

signal STARTT: std_logic;
signal MM: std_logic;
signal SS: std_logic;
signal Hz_clk: std_logic;
signal ResetTimerr: std_logic;

signal led : STD_LOGIC_VECTOR (15 downto 0);

component display is
  Port (
    clk: in std_logic;
    r: in std_logic;
    data: in std_logic_vector(15 downto 0);
    seg: out std_logic_vector(6 downto 0);
    an: out std_logic_vector(3 downto 0)
  );
end component;

component UC is
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
end component;

component Counter is
  Port (
    clk: in std_logic;
    clk_en: in std_logic;
    R: in std_logic;
    load: in std_logic_vector(1 downto 0);
    dir: in std_logic;
    count: out std_logic_vector(15 downto 0)
  );
end component;

component MPG is
  Port (
    en : out STD_LOGIC;
    input : in STD_LOGIC;
    clock : in STD_LOGIC
  );
end component;

component Clock_Divider is
port ( clk,reset: in std_logic;
clock_out: out std_logic);
end component;

begin

U0: Clock_Divider port map(clk, reset_clk, hz_clk);

U3: MPG port map(STARTT, START,clk);
U4: MPG port map(MM, M,clk);
U5: MPG port map(SS, S,clk);
U6: MPG port map(ResetTimerr, ResetTimer,clk);

U1: UC port map(clk,STARTT,MM,SS,ResetTimerr,set,rst,enable,dir);

U2: Counter port map(hz_clk,enable,rst,set,dir,led);

U8:display port map(clk,ResetTimerr,led,seg,an);

end Behavioral;
