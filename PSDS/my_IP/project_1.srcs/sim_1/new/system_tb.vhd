library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity system_tb is
end system_tb;

architecture Behavioral of system_tb is
   
   type pr is array(0 to 8) of integer;
   constant PRAGOVI: pr := (5, 10, 19, 35, 70, 117, 163, 232, 348);
   
   type p is array(0 to 9) of integer;
   constant POJACANJA: p := (2097152, 1048576, 524288, 262144, 131072, 65536, 32768, 16384, 8192, 4096); 

   constant DATA_WIDTH : integer := 24;
   constant AMPLIFICATION_WIDTH : integer := 24;
   constant BOUNDARIES_WIDTH : integer := 11;
   constant PACKAGE_LENGTH: positive := 1024;
   constant C_S00_AXI_DATA_WIDTH_C : integer := 32;
   constant C_S00_AXI_ADDR_WIDTH_C : integer := 7;


signal s00_axil_awaddr_s	: std_logic_vector(C_S00_AXI_ADDR_WIDTH_C-1 downto 0);
signal	s00_axil_awvalid_s	: std_logic;
signal s00_axil_awready_s	: std_logic;
signal 	s00_axil_wdata_s	: std_logic_vector(C_S00_AXI_DATA_WIDTH_C-1 downto 0);
signal	s00_axil_wvalid_s	: std_logic;
signal 	s00_axil_wready_s	: std_logic;
signal	s00_axil_bvalid_s	: std_logic;
signal s00_axil_bready_s	: std_logic;

signal s01_axis_tready_s    : std_logic;
signal s01_axis_tdata_s	    : std_logic_vector(2*DATA_WIDTH-1 downto 0);
signal s01_axis_tvalid_s	: std_logic;

signal 	m00_axis_tvalid_s	: std_logic;
signal  m00_axis_tdata_s	    : std_logic_vector(2*DATA_WIDTH-1 downto 0);
signal 	m00_axis_tready_s	    : std_logic;

signal  clk_s               : std_logic;
signal  aresetn_s           : std_logic;
begin

    IP_TB: entity work.axi_myip_v1_0(arch_imp)
    generic map(
            DATA_WIDTH => DATA_WIDTH,
            AMPLIFICATION_WIDTH => AMPLIFICATION_WIDTH,
            BOUNDARIES_WIDTH => BOUNDARIES_WIDTH,
            PACKAGE_LENGTH => PACKAGE_LENGTH,
            C_S00_AXIL_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH_C,
            C_S00_AXIL_ADDR_WIDTH    => C_S00_AXI_ADDR_WIDTH_C
    )
    port map(
        s00_axil_awaddr => s00_axil_awaddr_s,
        s00_axil_awvalid => s00_axil_awvalid_s,
        s00_axil_awready => s00_axil_awready_s,
        s00_axil_wdata => s00_axil_wdata_s,
        s00_axil_wvalid => s00_axil_wvalid_s,
        s00_axil_wready => s00_axil_wready_s,
        s00_axil_bvalid => s00_axil_bvalid_s,
        s00_axil_bready => s00_axil_bready_s,
      
        s01_axis_tready => s01_axis_tready_s,
        s01_axis_tdata => s01_axis_tdata_s,
        s01_axis_tvalid => s01_axis_tvalid_s,
        
        m00_axis_tvalid => m00_axis_tvalid_s,
        m00_axis_tdata => m00_axis_tdata_s,
        m00_axis_tready => m00_axis_tready_s,
        
        axi_aclk => clk_s,
        axi_aresetn => aresetn_s
    );

    clk_gen: process
    begin
        clk_s <= '0', '1' after 100 ns;
    wait for 200 ns;
        end process;
        
stimulus_generator: process
      
        begin
              
            aresetn_s <= '0';
        
            for i in 1 to 10 loop
                for i in 1 to 5 loop
                wait until falling_edge(clk_s);
                end loop;
              
                if i = 1 then
                aresetn_s <= '1';
                end if;
                
                wait until falling_edge(clk_s); 
                wait until falling_edge(clk_s);
                s00_axil_awaddr_s <= conv_std_logic_vector((i-1)*4, C_S00_AXI_ADDR_WIDTH_C);
                s00_axil_awvalid_s <= '1';
                s00_axil_wdata_s <= conv_std_logic_vector(POJACANJA(i-1), C_S00_AXI_DATA_WIDTH_C);
                s00_axil_wvalid_s <= '1';
                s00_axil_bready_s <= '1';
                wait until s00_axil_awready_s = '1';
                wait until s00_axil_awready_s = '0';
                wait until falling_edge(clk_s);
                s00_axil_awaddr_s <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_C);
                s00_axil_awvalid_s <= '0';
                s00_axil_wdata_s <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_C);
                s00_axil_wvalid_s <= '0';
                wait until s00_axil_bvalid_s = '0';
                wait until falling_edge(clk_s);
                s00_axil_bready_s <= '0';
                wait until falling_edge(clk_s);
             
            end loop;   
            
            for i in 1 to 9 loop
                for i in 1 to 5 loop
                wait until falling_edge(clk_s);
                end loop;
                
                wait until falling_edge(clk_s);
                s00_axil_awaddr_s <= conv_std_logic_vector((10+(i-1))*4, C_S00_AXI_ADDR_WIDTH_C); --4
                s00_axil_awvalid_s <= '1';
                s00_axil_wdata_s <= conv_std_logic_vector(PRAGOVI(i-1), C_S00_AXI_DATA_WIDTH_C);
                s00_axil_wvalid_s <= '1';
                s00_axil_bready_s <= '1';
                wait until s00_axil_awready_s = '1';
                wait until s00_axil_awready_s = '0';
                wait until falling_edge(clk_s);
                s00_axil_awaddr_s <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_C);
                s00_axil_awvalid_s <= '0';
                s00_axil_wdata_s <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_C);
                s00_axil_wvalid_s <= '0';
                wait until s00_axil_bvalid_s = '0';
                wait until falling_edge(clk_s);
                s00_axil_bready_s <= '0';
                wait until falling_edge(clk_s);
            end loop;
                          
                for i in 1 to 5000 loop
                    wait until falling_edge(clk_s);
                end loop;
                  
        end process;
        
        process 
        begin
        s01_axis_tvalid_s <= '0';
        m00_axis_tready_s <= '1';
        
        for i in 1 to 205 loop
          wait until rising_edge(clk_s);
        end loop;
        
        s01_axis_tvalid_s <= '1';
       
        for i in 1 to 512 loop
          s01_axis_tdata_s   <= x"010000010000";
          wait until rising_edge(clk_s);
          s01_axis_tdata_s  <= x"008000008000";
          wait until rising_edge(clk_s);
        end loop;
                
        s01_axis_tvalid_s <= '0';

        for i in 1 to 5000 loop
          wait until rising_edge(clk_s);
        end loop;
    
        end process;
        
end Behavioral;
