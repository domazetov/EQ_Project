----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2019 03:56:31 AM
-- Design Name: 
-- Module Name: conv48to32 - Behavioral
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

entity conv48to32 is
    Port ( x : in STD_LOGIC_VECTOR (47 downto 0);
           y : out STD_LOGIC_VECTOR (31 downto 0));
end conv48to32;

architecture Behavioral of conv48to32 is
begin
    y(31 downto 24) <= (others => '0');
    y(23 downto 0) <= x(23 downto 0);
    
end Behavioral;
