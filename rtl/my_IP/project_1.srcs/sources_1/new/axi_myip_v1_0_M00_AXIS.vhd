library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axi_myip_v1_0_M00_AXIS is
generic ( C_M_AXIS_TDATA_WIDTH	: integer := 24);
port ( y_re_i 		: in STD_LOGIC_VECTOR (C_M_AXIS_TDATA_WIDTH/2-1 downto 0);
       y_im_i 		: in STD_LOGIC_VECTOR (C_M_AXIS_TDATA_WIDTH/2-1 downto 0);
	   valid_i		: in std_logic;
	   M_AXIS_ACLK	: in std_logic;
	   M_AXIS_ARESETN	: in std_logic;
	   M_AXIS_TVALID	: out std_logic;
	   M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
	   M_AXIS_TREADY	: in std_logic);
end axi_myip_v1_0_M00_AXIS;

architecture implementation of axi_myip_v1_0_M00_AXIS is

	signal y_real, y_imag : std_logic_vector(C_M_AXIS_TDATA_WIDTH/2-1 downto 0);
	signal valid_reg, valid_next : std_logic;
begin

	 valid_next <= valid_i;
	 
	 process(M_AXIS_ACLK)                                                                                                       
     begin                                                                         
       if rising_edge (M_AXIS_ACLK) then                                        
          if M_AXIS_ARESETN = '0' then                                            
            y_real <= (others => '0');
            y_imag <= (others => '0');
          elsif M_AXIS_TREADY = '1' then
            if  valid_next = '1' then 
                y_real <= y_re_i;
                y_imag <= y_im_i;                                           
            else
                y_real <= y_real;
                y_imag <= y_imag;
            end if;
          end if; 
       end if;    
     end process;
	
	 process(M_AXIS_ACLK) 
     begin
       if rising_edge (M_AXIS_ACLK) then                                        
          if M_AXIS_ARESETN = '0' then
              valid_reg <= '0';         
          else
              valid_reg <= valid_next;
          end if;
       end if;
    end process;
    
     M_AXIS_TDATA(C_M_AXIS_TDATA_WIDTH/2-1 downto 0)  <= y_real;
     M_AXIS_TDATA(C_M_AXIS_TDATA_WIDTH-1 downto C_M_AXIS_TDATA_WIDTH/2) <= y_imag;
	 M_AXIS_TVALID <= valid_reg;
end implementation;
