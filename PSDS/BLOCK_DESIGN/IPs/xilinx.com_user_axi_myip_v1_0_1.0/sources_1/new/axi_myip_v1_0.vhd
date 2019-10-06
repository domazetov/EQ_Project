library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--use work.utils_pkg.all;

entity axi_myip_v1_0 is
	generic (
		DATA_WIDTH         : integer := 24;
		AMPLIFICATION_WIDTH   :integer := 24;
		BOUNDARIES_WIDTH         : integer := 11;
        PACKAGE_LENGTH: positive := 1024;
		C_S00_AXIL_DATA_WIDTH	: integer := 32;
		C_S00_AXIL_ADDR_WIDTH	: integer := 7
	);
	port (
		-- Ports of Axi Slave Bus Interface S00_AXIL
		s00_axil_awaddr	: in std_logic_vector(C_S00_AXIL_ADDR_WIDTH-1 downto 0);
		s00_axil_awvalid: in std_logic;
		s00_axil_awready: out std_logic;
		s00_axil_wdata	: in std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
		s00_axil_wvalid	: in std_logic;
		s00_axil_wready	: out std_logic;
		s00_axil_bvalid	: out std_logic;
		s00_axil_bready	: in std_logic;

		-- Ports of Axi Slave Bus Interface S01_AXIS
		s01_axis_tready	: out std_logic;
		s01_axis_tdata	: in std_logic_vector(2*DATA_WIDTH-1 downto 0);
    	s01_axis_tvalid	: in std_logic;

		-- Ports of Axi Master Bus Interface M00_AXIS
		m00_axis_tvalid	: out std_logic;
		m00_axis_tdata	: out std_logic_vector(2*DATA_WIDTH-1 downto 0);
    	m00_axis_tready	: in std_logic;
    
       -- GLOBAL
        axi_aclk : in std_logic;
        axi_aresetn : in std_logic
	);
end axi_myip_v1_0;

architecture arch_imp of axi_myip_v1_0 is

signal reset_s : std_logic;
signal reg_data_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);   
signal p1_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal p2_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal p3_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal p4_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal p5_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal p6_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal p7_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal p8_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal p9_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal p10_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal pr1_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal pr2_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal pr3_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal pr4_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal pr5_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal pr6_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal pr7_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal pr8_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal pr9_s : std_logic_vector(C_S00_AXIL_DATA_WIDTH-1 downto 0);
signal p1_wr_s : std_logic;
signal p2_wr_s : std_logic;
signal p3_wr_s : std_logic;
signal p4_wr_s : std_logic;
signal p5_wr_s : std_logic;
signal p6_wr_s : std_logic;
signal p7_wr_s : std_logic;
signal p8_wr_s : std_logic;
signal p9_wr_s : std_logic;
signal p10_wr_s : std_logic;
signal pr1_wr_s : std_logic;
signal pr2_wr_s : std_logic;
signal pr3_wr_s : std_logic;
signal pr4_wr_s : std_logic;
signal pr5_wr_s : std_logic;
signal pr6_wr_s : std_logic;
signal pr7_wr_s : std_logic;
signal pr8_wr_s : std_logic;
signal pr9_wr_s : std_logic;
signal x_re_s : std_logic_vector(DATA_WIDTH-1 downto 0);
signal x_im_s : std_logic_vector(DATA_WIDTH-1 downto 0);
signal y_re_s : std_logic_vector(DATA_WIDTH-1 downto 0);
signal y_im_s : std_logic_vector(DATA_WIDTH-1 downto 0);
signal start_s : std_logic;
signal valid_s : std_logic;

begin

axi_myip_v1_0_S00_AXIL_inst : entity work.axi_myip_v1_0_S00_AXIL(arch_imp)
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXIL_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXIL_ADDR_WIDTH
	)
	port map (
		-- Users to add ports here
	    reg_data_o => reg_data_s,
		p1_wr_o => p1_wr_s,
		p2_wr_o => p2_wr_s,
		p3_wr_o => p3_wr_s,
		p4_wr_o => p4_wr_s,
		p5_wr_o => p5_wr_s,
		p6_wr_o => p6_wr_s,
		p7_wr_o => p7_wr_s,
		p8_wr_o => p8_wr_s,
		p9_wr_o => p9_wr_s,
		p10_wr_o => p10_wr_s,
		pr1_wr_o => pr1_wr_s,
		pr2_wr_o => pr2_wr_s,
		pr3_wr_o => pr3_wr_s,
		pr4_wr_o => pr4_wr_s,
		pr5_wr_o => pr5_wr_s,
		pr6_wr_o => pr6_wr_s,
		pr7_wr_o => pr7_wr_s,
		pr8_wr_o => pr8_wr_s,
		pr9_wr_o => pr9_wr_s,
		S_AXI_ACLK	    => axi_aclk,
		S_AXI_ARESETN	=> axi_aresetn,
		S_AXI_AWADDR	=> s00_axil_awaddr,
		S_AXI_AWVALID	=> s00_axil_awvalid,
		S_AXI_AWREADY	=> s00_axil_awready,
		S_AXI_WDATA	    => s00_axil_wdata,
		S_AXI_WVALID	=> s00_axil_wvalid,
		S_AXI_WREADY	=> s00_axil_wready,
		S_AXI_BVALID	=> s00_axil_bvalid,
		S_AXI_BREADY	=> s00_axil_bready
	);

axi_myip_v1_0_S01_AXIS_inst : entity work.axi_myip_v1_0_S01_AXIS(arch_imp)
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> 2*DATA_WIDTH
	)
	port map (
		S_AXIS_ACLK	    => axi_aclk,
		S_AXIS_ARESETN	=> axi_aresetn,
		S_AXIS_TREADY	=> s01_axis_tready,
		S_AXIS_TDATA	=> s01_axis_tdata,
		S_AXIS_TVALID	=> s01_axis_tvalid,
		start_ip        => start_s,
		x_re_o          => x_re_s,
		x_im_o          => x_im_s	
	);

axi_myip_v1_0_M00_AXIS_inst : entity work.axi_myip_v1_0_M00_AXIS(implementation)
	generic map (
		C_M_AXIS_TDATA_WIDTH	=> 2*DATA_WIDTH
	)
	port map (
		M_AXIS_ACLK	    => axi_aclk,
		M_AXIS_ARESETN	=> axi_aresetn,
		M_AXIS_TVALID	=> m00_axis_tvalid,
		M_AXIS_TDATA	=> m00_axis_tdata,
		M_AXIS_TREADY	=> m00_axis_tready,	
		y_re_i          => y_re_s,
		y_im_i          => y_im_s,
		valid_i           => valid_s
	);
	-- Memory subsystem
	memory_subsystem: entity work.mem_subsystem(struct)
	  generic map (
		  C_S_AXI_DATA_WIDTH => C_S00_AXIL_DATA_WIDTH
		)
	  port map (
		clk => axi_aclk,
		reset => axi_aresetn,
        reg_data_i => reg_data_s,
		p1_wr_i => p1_wr_s,
		p2_wr_i => p2_wr_s,
		p3_wr_i => p3_wr_s,
		p4_wr_i => p4_wr_s,
		p5_wr_i => p5_wr_s,
		p6_wr_i => p6_wr_s,
		p7_wr_i => p7_wr_s,
		p8_wr_i => p8_wr_s,
		p9_wr_i => p9_wr_s,
		p10_wr_i => p10_wr_s,
		pr1_wr_i => pr1_wr_s,
		pr2_wr_i => pr2_wr_s,
		pr3_wr_i => pr3_wr_s,
		pr4_wr_i => pr4_wr_s,
		pr5_wr_i => pr5_wr_s,
		pr6_wr_i => pr6_wr_s,
		pr7_wr_i => pr7_wr_s,
		pr8_wr_i => pr8_wr_s,
		pr9_wr_i => pr9_wr_s,
		p1_o => p1_s,
		p2_o => p2_s,
		p3_o => p3_s,
		p4_o => p4_s,
		p5_o => p5_s,
		p6_o => p6_s,
		p7_o => p7_s,
		p8_o => p8_s,
		p9_o => p9_s,
		p10_o => p10_s,
		pr1_o => pr1_s,
		pr2_o => pr2_s,
		pr3_o => pr3_s,
		pr4_o => pr4_s,
		pr5_o => pr5_s,
		pr6_o => pr6_s,
		pr7_o => pr7_s,
		pr8_o => pr8_s,
		pr9_o => pr9_s);

		-- Matrix multiplier module
matrix_multiplier: entity work.IP(Behavioral)
		generic map (
		    DATA_WIDTH => DATA_WIDTH,
            AMPLIFICATION_WIDTH => AMPLIFICATION_WIDTH,
            BOUNDARIES_WIDTH => BOUNDARIES_WIDTH,
            C_S_AXI_DATA_WIDTH => C_S00_AXIL_DATA_WIDTH,
            PACKAGE_LENGTH =>  PACKAGE_LENGTH
		)
		port map (
		clk => axi_aclk,
		reset => axi_aresetn,
		p1 => p1_s,
		p2 => p2_s,
		p3 => p3_s,
		p4 => p4_s,
		p5 => p5_s,
		p6 => p6_s,
		p7 => p7_s,
		p8 => p8_s,
		p9 => p9_s,
		p10 => p10_s,
		pr1 => pr1_s,
		pr2 => pr2_s,
		pr3 => pr3_s,
		pr4 => pr4_s,
		pr5 => pr5_s,
		pr6 => pr6_s,
		pr7 => pr7_s,
		pr8 => pr8_s,
		pr9 => pr9_s,
        x_re => x_re_s,
        x_im => x_im_s,
        y_im => y_im_s,
        y_re => y_re_s,
        valid => valid_s,
		start => start_s
		);
end arch_imp;
