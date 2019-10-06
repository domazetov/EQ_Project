library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axi_myip_v1_0_S01_AXIS is
generic ( C_S_AXIS_TDATA_WIDTH	: integer := 24);
port (   x_re_o         : out std_logic_vector(C_S_AXIS_TDATA_WIDTH/2-1 downto 0);
         x_im_o         : out std_logic_vector(C_S_AXIS_TDATA_WIDTH/2-1 downto 0);
         start_ip       : out std_logic;
         S_AXIS_ACLK	: in std_logic;
		 S_AXIS_ARESETN	: in std_logic;
		 S_AXIS_TREADY	: out std_logic;
		 S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		 S_AXIS_TVALID	: in std_logic);
end axi_myip_v1_0_S01_AXIS;

architecture arch_imp of axi_myip_v1_0_S01_AXIS is
	
	signal x_real, x_imag: std_logic_vector(C_S_AXIS_TDATA_WIDTH/2-1 downto 0);
	signal axis_tready: std_logic;
	signal wr_enable: std_logic;
    signal start_IP_s:std_logic;
begin
    wr_enable <= S_AXIS_TVALID and axis_tready;
     
    process(S_AXIS_ACLK)
    begin
       if rising_edge (S_AXIS_ACLK) then 
         if S_AXIS_ARESETN = '0' then
              axis_tready <= '1';
         end if;
         if wr_enable = '1' then
              x_real <= S_AXIS_TDATA(C_S_AXIS_TDATA_WIDTH/2-1 downto 0);
              x_imag <= S_AXIS_TDATA(C_S_AXIS_TDATA_WIDTH-1 downto C_S_AXIS_TDATA_WIDTH/2); 
         else
              x_real <= (others => '0');
              x_imag <= (others => '0');
         end if;
       end  if;        
    end process; 
	 
    process(S_AXIS_ACLK)
    begin
     if falling_edge (S_AXIS_ACLK) then --falling_edge
        if wr_enable = '1' then
            start_IP_s <= '1';
        else
            start_IP_s <= '0';
        end if;
      end if;
    end process; 
             
     x_re_o <= x_real;
     x_im_o <= x_imag;
     start_IP <= start_IP_s;
     S_AXIS_TREADY <= axis_tready;	

end arch_imp;