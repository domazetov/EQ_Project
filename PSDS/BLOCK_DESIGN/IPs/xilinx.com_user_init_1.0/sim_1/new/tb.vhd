----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2019 04:39:14 AM
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    signal valid_fft, ready_fft, valid_ifft, ready_ifft, clk, res:std_logic;
    signal data_fft, data_ifft:std_logic_vector(23 downto 0);
begin
    init:entity work.init
    port map(aclk => clk,
             aresetn => res, 
             s_axis_config_tdata_fft => data_fft,
             s_axis_config_tdata_ifft => data_ifft,
             s_axis_config_tvalid_fft => valid_fft,
             s_axis_config_tvalid_ifft => valid_ifft,
             s_axis_config_tready_fft =>  ready_fft,
             s_axis_config_tready_ifft => ready_ifft);
             
    process
    begin
        clk <= '0', '1' after 100ns;
        wait for 200ns;
    end process;
    
    res <= '1', '0' after 300ns, '1' after 600ns;
    ready_fft <= '0', '1' after 650ns, '0' after 900ns;
    ready_ifft <= '0', '1' after 750ns, '0' after 1400ns;
    

end Behavioral;
