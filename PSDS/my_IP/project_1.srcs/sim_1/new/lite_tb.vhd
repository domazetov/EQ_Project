library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity lite_tb is
end lite_tb;

architecture Behavioral of lite_tb is
    constant WIDTH_1_C            :integer:=8;
    --constant WIDTH_2            :integer:=11;

    type pr is array(0 to 8) of integer;
    constant PRAGOVI: pr := (5, 10, 19, 35, 70, 117, 163, 232, 348);
    
    type p is array(0 to 9) of integer;
    constant POJACANJA: p := (1, 2, 3, 4, 5, 6, 7, 8, 9, 10); 
    

    constant C_S00_AXI_DATA_WIDTH_C : integer := 32;
    constant C_S00_AXI_ADDR_WIDTH_C : integer := 7;

    signal clk_s: std_logic;
    signal reset_s: std_logic;
    signal s00_axi_awaddr_s : std_logic_vector(C_S00_AXI_ADDR_WIDTH_C-1 downto 0) := (others => '0');
    signal s00_axi_awvalid_s : std_logic := '0';
    signal s00_axi_awready_s : std_logic := '0';
    signal s00_axi_wdata_s : std_logic_vector(C_S00_AXI_DATA_WIDTH_C-1 downto 0) := (others => '0');
    signal s00_axi_wstrb_s : std_logic_vector((C_S00_AXI_DATA_WIDTH_C/8)-1 downto 0) := (others => '0');
    signal s00_axi_wvalid_s : std_logic := '0';
    signal s00_axi_wready_s : std_logic := '0';
    signal s00_axi_bvalid_s : std_logic := '0';
    signal s00_axi_bready_s : std_logic := '0';
    signal s_reg_data_o          		  : std_logic_vector(WIDTH_1_C-1 downto 0);
	signal s_p1_wr_o             		  : std_logic;
    signal s_p2_wr_o             		  : std_logic;
    signal s_p3_wr_o             		  : std_logic;
    signal s_p4_wr_o             		  : std_logic;
    signal s_p5_wr_o             		  : std_logic;
    signal s_p6_wr_o             		  : std_logic;
    signal s_p7_wr_o             		  : std_logic;
    signal s_p8_wr_o             		  : std_logic;
    signal s_p9_wr_o             		  : std_logic;
    signal s_p10_wr_o            		  : std_logic;
    signal s_pr1_wr_o            		  : std_logic;
    signal s_pr2_wr_o            		  : std_logic;
    signal s_pr3_wr_o            		  : std_logic;
    signal s_pr4_wr_o            		  : std_logic;
    signal s_pr5_wr_o            		  : std_logic;
    signal s_pr6_wr_o            		  : std_logic;
    signal s_pr7_wr_o            		  : std_logic;
    signal s_pr8_wr_o            		  : std_logic;
	signal s_pr9_wr_o            		  : std_logic;

begin

AXI_LITE: entity work.axi_myip_v1_0_S00_AXIL(arch_imp)
	generic map 
	( 
		WIDTH_1                => WIDTH_1_C,
		C_S_AXI_DATA_WIDTH     => C_S00_AXI_DATA_WIDTH_C,
		C_S_AXI_ADDR_WIDTH	   => C_S00_AXI_ADDR_WIDTH_C
	)
	port map
	(
        S_AXI_ACLK         =>         clk_s,
        S_AXI_ARESETN      =>         reset_s,
        S_AXI_AWADDR       =>         s00_axi_awaddr_s,
        S_AXI_AWVALID      =>         s00_axi_awvalid_s, 
        S_AXI_WDATA        =>         s00_axi_wdata_s,
        S_AXI_WVALID       =>         s00_axi_wvalid_s,
        S_AXI_BREADY       =>         s00_axi_bready_s,
        S_AXI_WREADY       =>         s00_axi_wready_s,
        S_AXI_BVALID       =>         s00_axi_bvalid_s,
        S_AXI_AWREADY      =>         s00_axi_awready_s,
        
        reg_data_o         =>         s_reg_data_o,
        --write enable
        p1_wr_o            =>         s_p1_wr_o,   
        p2_wr_o            =>         s_p2_wr_o,
        p3_wr_o            =>         s_p3_wr_o,
        p4_wr_o            =>         s_p4_wr_o,
        p5_wr_o            =>         s_p5_wr_o,
        p6_wr_o            =>         s_p6_wr_o,
        p7_wr_o            =>         s_p7_wr_o,
        p8_wr_o            =>         s_p8_wr_o,
        p9_wr_o            =>         s_p9_wr_o,
        p10_wr_o           =>         s_p10_wr_o,
        pr1_wr_o           =>         s_pr1_wr_o,
        pr2_wr_o           =>         s_pr2_wr_o,
        pr3_wr_o           =>         s_pr3_wr_o,
        pr4_wr_o           =>         s_pr4_wr_o,
        pr5_wr_o           =>         s_pr5_wr_o,
        pr6_wr_o           =>         s_pr6_wr_o,
        pr7_wr_o           =>         s_pr7_wr_o,
        pr8_wr_o           =>         s_pr8_wr_o,
        pr9_wr_o           =>         s_pr9_wr_o
    );

    clk_gen: process
    begin
    clk_s <= '0', '1' after 100 ns;
    wait for 200 ns;
    end process;
    
stimulus_generator: process

begin
      
    reset_s <= '0';

    for i in 1 to 10 loop
        for i in 1 to 5 loop
        wait until falling_edge(clk_s);
        end loop;
      
        if i = 1 then
        reset_s <= '1';
        end if;
        
        wait until falling_edge(clk_s); 
        wait until falling_edge(clk_s);
        s00_axi_awaddr_s <= conv_std_logic_vector((i-1)*4, C_S00_AXI_ADDR_WIDTH_c);
        s00_axi_awvalid_s <= '1';
        s00_axi_wdata_s <= conv_std_logic_vector(POJACANJA(i-1), C_S00_AXI_DATA_WIDTH_c);
        s00_axi_wvalid_s <= '1';
        s00_axi_bready_s <= '1';
        wait until s00_axi_awready_s = '1';
        wait until s00_axi_awready_s = '0';
        wait until falling_edge(clk_s);
        s00_axi_awaddr_s <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_c);
        s00_axi_awvalid_s <= '0';
        s00_axi_wdata_s <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_c);
        s00_axi_wvalid_s <= '0';
        wait until s00_axi_bvalid_s = '0';
        wait until falling_edge(clk_s);
        s00_axi_bready_s <= '0';
        wait until falling_edge(clk_s);
     
    end loop;   
    
    for i in 1 to 9 loop
        for i in 1 to 5 loop
        wait until falling_edge(clk_s);
        end loop;
        
        wait until falling_edge(clk_s);
        s00_axi_awaddr_s <= conv_std_logic_vector((10+(i-1))*4, C_S00_AXI_ADDR_WIDTH_C); --4
        s00_axi_awvalid_s <= '1';
        s00_axi_wdata_s <= conv_std_logic_vector(PRAGOVI(i-1), C_S00_AXI_DATA_WIDTH_C);
        s00_axi_wvalid_s <= '1';
        s00_axi_bready_s <= '1';
        wait until s00_axi_awready_s = '1';
        wait until s00_axi_awready_s = '0';
        wait until falling_edge(clk_s);
        s00_axi_awaddr_s <= conv_std_logic_vector(0, C_S00_AXI_ADDR_WIDTH_C);
        s00_axi_awvalid_s <= '0';
        s00_axi_wdata_s <= conv_std_logic_vector(0, C_S00_AXI_DATA_WIDTH_C);
        s00_axi_wvalid_s <= '0';
        wait until s00_axi_bvalid_s = '0';
        wait until falling_edge(clk_s);
        s00_axi_bready_s <= '0';
        wait until falling_edge(clk_s);
    end loop;
          
end process;
	
end Behavioral;