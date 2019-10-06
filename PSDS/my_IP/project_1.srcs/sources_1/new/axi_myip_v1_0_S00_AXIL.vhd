library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

--use work.utils_pkg.all;

entity axi_myip_v1_0_S00_AXIL is
	generic (
		C_S_AXI_DATA_WIDTH	: integer := 32;
		C_S_AXI_ADDR_WIDTH	: integer := 7);
	port (
		reg_data_o          : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		p1_wr_o             : out std_logic;
    	p2_wr_o             : out std_logic;
    	p3_wr_o             : out std_logic;
    	p4_wr_o             : out std_logic;
    	p5_wr_o             : out std_logic;
    	p6_wr_o             : out std_logic;
    	p7_wr_o             : out std_logic;
    	p8_wr_o             : out std_logic;
    	p9_wr_o             : out std_logic;
    	p10_wr_o            : out std_logic;
    	pr1_wr_o            : out std_logic;
    	pr2_wr_o            : out std_logic;
    	pr3_wr_o            : out std_logic;
    	pr4_wr_o            : out std_logic;
    	pr5_wr_o            : out std_logic;
    	pr6_wr_o            : out std_logic;
    	pr7_wr_o            : out std_logic;
    	pr8_wr_o            : out std_logic;
		pr9_wr_o            : out std_logic;

		S_AXI_ACLK	: in std_logic;
        S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic
			);
end axi_myip_v1_0_S00_AXIL;

architecture arch_imp of axi_myip_v1_0_S00_AXIL is

	signal axi_awaddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_awready	: std_logic;
	signal axi_wready	: std_logic;
	signal axi_bvalid	: std_logic;
	constant ADDR_LSB  : integer := (C_S_AXI_DATA_WIDTH/32)+ 1;
	constant OPT_MEM_ADDR_BITS : integer := 4;
	signal slv_reg_wren	: std_logic;
	signal aw_en	: std_logic;

begin

	S_AXI_AWREADY	<= axi_awready;
	S_AXI_WREADY	<= axi_wready;
	S_AXI_BVALID	<= axi_bvalid;

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awready <= '0';
	      aw_en <= '1';
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
	           axi_awready <= '1';
	           aw_en <= '0';
	        elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then
	           aw_en <= '1';
	           axi_awready <= '0';
	      else
	        axi_awready <= '0';
	      end if;
	    end if;
	  end if;
	end process;

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awaddr <= (others => '0');
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
	        axi_awaddr <= S_AXI_AWADDR;
	      end if;
	    end if;
	  end if;                   
	end process; 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_wready <= '0';
	    else
	      if (axi_wready = '0' and S_AXI_WVALID = '1' and S_AXI_AWVALID = '1' and aw_en = '1') then         
	          axi_wready <= '1';
	      else
	        axi_wready <= '0';
	      end if;
	    end if;
	  end if;
	end process; 

	slv_reg_wren <= axi_wready and S_AXI_WVALID and axi_awready and S_AXI_AWVALID ;

	process (S_AXI_ACLK)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0); 
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
		  p1_wr_o		<= '0';
		  p2_wr_o		<= '0';
		  p3_wr_o		<= '0';
		  p4_wr_o		<= '0';
		  p5_wr_o		<= '0';
		  p6_wr_o		<= '0';
		  p7_wr_o		<= '0';
		  p8_wr_o		<= '0';
		  p9_wr_o		<= '0';
		  p10_wr_o		<= '0';
		  pr1_wr_o		<= '0';
		  pr2_wr_o		<= '0';
		  pr3_wr_o		<= '0';
		  pr4_wr_o		<= '0';
		  pr5_wr_o		<= '0';
		  pr6_wr_o		<= '0';
		  pr7_wr_o		<= '0';
		  pr8_wr_o		<= '0';
		  pr9_wr_o		<= '0';		  
		else
		  p1_wr_o		<= '0';
		  p2_wr_o		<= '0';
		  p3_wr_o		<= '0';
		  p4_wr_o		<= '0';
		  p5_wr_o		<= '0';
		  p6_wr_o		<= '0';
		  p7_wr_o		<= '0';
		  p8_wr_o		<= '0';
		  p9_wr_o		<= '0';
		  p10_wr_o		<= '0';
		  pr1_wr_o		<= '0';
		  pr2_wr_o		<= '0';
		  pr3_wr_o		<= '0';
		  pr4_wr_o		<= '0';
		  pr5_wr_o		<= '0';
		  pr6_wr_o		<= '0';
		  pr7_wr_o		<= '0';
		  pr8_wr_o		<= '0';
		  pr9_wr_o		<= '0';	
		  
	      loc_addr := axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	      if (slv_reg_wren = '1') then
	        case loc_addr is
	          when b"00000" =>
	            p1_wr_o <= '1';
			  when b"00001" =>
			  	p2_wr_o <= '1';	            
	          when b"00010" =>
	          	p3_wr_o <= '1';    
	          when b"00011" =>
			  	p4_wr_o <= '1'; 
	          when b"00100" =>
			  	p5_wr_o <= '1'; 
	          when b"00101" =>	            
			 	p6_wr_o <= '1'; 
	          when b"00110" =>
			 	p7_wr_o <= '1'; 
	          when b"00111" =>
			  	p8_wr_o <= '1'; 
	          when b"01000" =>
			  	p9_wr_o <= '1'; 
	          when b"01001" =>
			  	p10_wr_o <= '1'; 
	          when b"01010" =>
			  	pr1_wr_o <= '1'; 
	          when b"01011" =>
			  	pr2_wr_o <= '1'; 
	          when b"01100" =>
			  	pr3_wr_o <= '1'; 
	          when b"01101" =>
			  	pr4_wr_o <= '1'; 
	          when b"01110" =>
			  	pr5_wr_o <= '1'; 
	          when b"01111" =>
			  	pr6_wr_o <= '1'; 
	          when b"10000" =>
			  	pr7_wr_o <= '1'; 
	          when b"10001" =>
			  	pr8_wr_o <= '1'; 
	          when b"10010" =>
			  	pr9_wr_o <= '1';  
	          when others =>
	        end case;
	      end if;
	    end if;
	  end if;                   
	end process; 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_bvalid  <= '0';
	    else
	      if (axi_awready = '1' and S_AXI_AWVALID = '1' and axi_wready = '1' and S_AXI_WVALID = '1' and axi_bvalid = '0'  ) then
	        axi_bvalid <= '1';
	      elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then 
	        axi_bvalid <= '0';                                 
	      end if;
	    end if;
	  end if;                   
	end process; 

	process (S_AXI_ACLK)
	begin
	  if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
	  reg_data_o <= S_AXI_WDATA;
	  end if;
	end process;

end arch_imp;
