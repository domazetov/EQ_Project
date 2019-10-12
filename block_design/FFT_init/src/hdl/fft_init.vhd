----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2019 04:12:14 AM
-- Design Name: 
-- Module Name: fft_init - Behavioral
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

entity fft_init is
    Port ( s_axis_config_tvalid_fft : out STD_LOGIC;
           s_axis_config_tdata_fft : out STD_LOGIC_VECTOR (23 downto 0);
           s_axis_config_tready_fft : in STD_LOGIC;
           s_axis_config_tvalid_ifft : out STD_LOGIC;
           s_axis_config_tdata_ifft : out STD_LOGIC_VECTOR (23 downto 0);
           s_axis_config_tready_ifft : in STD_LOGIC;
           aclk : in STD_LOGIC;
           aresetn : in STD_LOGIC);
end fft_init;

architecture Behavioral of fft_init is
begin
    
    s_axis_config_tdata_fft <= x"000003";
    s_axis_config_tdata_ifft <= x"0aaaaa";
    s_axis_config_tvalid_fft <= '1';
    s_axis_config_tvalid_ifft <= '1';
    
end Behavioral;
