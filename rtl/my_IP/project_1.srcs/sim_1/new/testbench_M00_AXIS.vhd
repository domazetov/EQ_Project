library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_M00_AXIS is
end testbench_M00_AXIS;

architecture Behavioral of testbench_M00_AXIS is

    signal     y_re_i :  std_logic_vector (24-1 downto 0);
    signal     y_im_i :  std_logic_vector (24-1 downto 0);
    signal    valid_i :  std_logic;
       
    signal      M_AXIS_ACLK	    :  std_logic;
    signal		M_AXIS_ARESETN	:  std_logic;
    signal		M_AXIS_TVALID	:  std_logic;
    signal		M_AXIS_TDATA	:  std_logic_vector(48-1 downto 0);
    signal		M_AXIS_TREADY	:  std_logic;
begin
    M00_AXIS: entity work.axi_myip_v1_0_M00_AXIS(implementation)
    generic map( C_M_AXIS_TDATA_WIDTH   => 48 )
    port map( y_re_i           =>  y_re_i,
              y_im_i           =>  y_im_i,
              valid_i         => valid_i,
              M_AXIS_ACLK      =>  M_AXIS_ACLK,
              M_AXIS_ARESETN   =>  M_AXIS_ARESETN,
              M_AXIS_TVALID    =>  M_AXIS_TVALID,
              M_AXIS_TDATA     =>  M_AXIS_TDATA,
              M_AXIS_TREADY    =>  M_AXIS_TREADY);
   
    M_AXIS_ARESETN <= '0', '1' after 150 ns;  
    M_AXIS_TREADY <= '1';
    valid_i <= '0', '1' after 500ns, '0' after 1500ns;   
   
    clk_gen: process
    begin
        M_AXIS_ACLK <= '0', '1' after 100 ns;
        wait for 200 ns;
    end process;
     
    data: process
    begin
        wait until valid_i = '1';     
        y_re_i <= x"080000";
        y_im_i <= x"080000";
        wait until rising_edge(M_AXIS_ACLK);
        y_re_i <= x"040000";
        y_im_i <= x"040000";    
        wait until rising_edge(M_AXIS_ACLK);
        y_re_i <= x"020000";
        y_im_i <= x"020000";
        wait until rising_edge(M_AXIS_ACLK);
        y_re_i <= x"010000";
        y_im_i <= x"010000";         
        wait until rising_edge(M_AXIS_ACLK);
        y_re_i <= x"008000";
        y_im_i <= x"008000";
        wait until rising_edge(M_AXIS_ACLK);
        y_re_i <= x"000000";
        y_im_i <= x"000000";
        
        for i in 1 to 5000 loop
        wait until rising_edge(M_AXIS_ACLK);
        end loop;
        
  end process;   

end Behavioral;