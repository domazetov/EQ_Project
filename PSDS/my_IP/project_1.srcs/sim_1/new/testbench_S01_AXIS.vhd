
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity testbench_S01_AXIS is
end testbench_S01_AXIS;

architecture Behavioral of testbench_S01_AXIS is
    signal       x_re_s      :  std_logic_vector(24-1 downto 0);
    signal       x_im_s      :  std_logic_vector(24-1 downto 0);
    signal       start_ip_s  :  std_logic;
    signal		S_AXIS_ACLK	    :  std_logic;
    signal		S_AXIS_ARESETN	: std_logic;
    signal		S_AXIS_TREADY	:  std_logic;
    signal		S_AXIS_TDATA	:  std_logic_vector(48-1 downto 0);
    signal		S_AXIS_TVALID	:  std_logic;
begin

    Ip_core: entity work.axi_myip_v1_0_S01_AXIS(arch_imp)
    generic map( C_S_AXIS_TDATA_WIDTH => 48 )
    port map(    x_re_o         =>  x_re_s,
                 x_im_o         =>  x_im_s,
                 start_ip       =>  start_ip_s,
                 S_AXIS_ACLK    =>  S_AXIS_ACLK,
                 S_AXIS_ARESETN =>  S_AXIS_ARESETN,
                 S_AXIS_TREADY  =>  S_AXIS_TREADY,
                 S_AXIS_TDATA   =>  S_AXIS_TDATA,
                 S_AXIS_TVALID  =>  S_AXIS_TVALID );

    S_AXIS_ARESETN <= '0', '1'  after 150ns;

    clk_gen: process
    begin
        S_AXIS_ACLK <= '0', '1' after 100 ns;
        wait for 200 ns;
    end process;   

    S_AXIS_TVALID <= '0', '1' after 500ns, '0' after 1700ns;

    data: process
    begin
        --S_AXIS_TLAST   <= '0';
        wait until rising_edge(S_AXIS_ACLK); 
        S_AXIS_TDATA   <=  x"080000080000";
        wait until rising_edge(S_AXIS_ACLK);
        wait until rising_edge(S_AXIS_ACLK);
        S_AXIS_TDATA   <=  x"040000040000";
        wait until rising_edge(S_AXIS_ACLK);    
        S_AXIS_TDATA   <=  x"020000020000";
        wait until rising_edge(S_AXIS_ACLK);    
        S_AXIS_TDATA   <=  x"010000010000";
        wait until rising_edge(S_AXIS_ACLK);    
        S_AXIS_TDATA   <=  x"008000008000";
        wait until rising_edge(S_AXIS_ACLK);    
        S_AXIS_TDATA   <=  x"004000004000";
        wait until rising_edge(S_AXIS_ACLK);    
        S_AXIS_TDATA   <=  x"002000002000";              
    end process;
   
end Behavioral;