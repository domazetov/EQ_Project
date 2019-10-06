library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;

entity IP is
    generic ( DATA_WIDTH: positive := 24; -- input signal wordlength and input amplification wordlength 
              AMPLIFICATION_WIDTH: positive := 24; -- wordlength of package_length *** := 11
              BOUNDARIES_WIDTH: positive := 11;
              C_S_AXI_DATA_WIDTH : positive := 32;
              PACKAGE_LENGTH: positive := 1024);
 
    Port ( x_re : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- input signal real part
           x_im : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- input signal imaginar part
           p1 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- amplification for range 1
           p2 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- amplification for range 2
           p3 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- amplification for range 3
           p4 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- amplification for range 4
           p5 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- amplification for range 5
           p6 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- amplification for range 6
           p7 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- amplification for range 7
           p8 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- amplification for range 8
           p9 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- amplification for range 9
           p10 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- amplification for range 10
           pr1 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- end boundary for range 1
           pr2 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- end boundary for range 2
           pr3 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- end boundary for range 3
           pr4 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- end boundary for range 4
           pr5 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- end boundary for range 5
           pr6 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- end boundary for range 6
           pr7 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- end boundary for range 7
           pr8 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- end boundary for range 8
           pr9 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0); -- end boundary for range 9
           clk : in STD_LOGIC;
           start: in std_logic;
           reset: in std_logic;
           
           y_re : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- output signal real part
           y_im : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- output signal imaginary part
           valid: out std_logic); -- indicate when output signal is ready to read
end IP;

architecture Behavioral of IP is
    type state_type is (idle, st_0000, st_0001, st_0010, st_0011, st_0100, st_0101, st_0110, st_0111, st_1000, st_1001); -- ten states for ten ranges
    signal state_reg, state_next: state_type;
    signal status_next: std_logic; -- indicate to go in next state
    signal status_back: std_logic; -- indicate to go in previous state
    signal status_end: std_logic; -- indicate to end calculation
    signal adder_reg, adder_next: unsigned(BOUNDARIES_WIDTH-1 downto 0);
    signal adder_out: unsigned(BOUNDARIES_WIDTH-1 downto 0);
    signal subtraction_out: unsigned(BOUNDARIES_WIDTH-1 downto 0);
    signal y_re_reg, y_re_next: signed((AMPLIFICATION_WIDTH+DATA_WIDTH)-1 downto 0);
    signal y_im_reg, y_im_next: signed ((AMPLIFICATION_WIDTH+DATA_WIDTH)-1 downto 0);
    signal mux1: signed(AMPLIFICATION_WIDTH-1 downto 0);
    signal mux2: unsigned(BOUNDARIES_WIDTH-1 downto 0);
    signal mux3: unsigned(BOUNDARIES_WIDTH-1 downto 0); 
begin

     -- control path: state register
    process (clk, reset, start)
    begin
        if reset = '0' then
            state_reg <= idle;
        elsif (clk'event and clk = '1') then
            state_reg <= state_next;
        end if;
    end process; 

     -- control path: next-state/output logic
     process (state_reg, start, status_next, status_back, status_end)
     begin
        case state_reg is
            when idle =>
                if start = '1' then
                    state_next <= st_0000;
                else
                    state_next <= idle;
                end if;
            when st_0000 =>
                if start = '0' then
                    state_next <= idle;
                elsif status_next = '1' then
                    state_next <= st_0001;
                elsif status_end = '1' then
                    state_next <= idle;
                else 
                    state_next <= st_0000;
                end if;
            when st_0001 =>
                if start = '0' then
                    state_next <= idle;
                elsif status_next = '1' then
                    state_next <= st_0010;
                elsif status_back = '1' then
                    state_next <= st_0000;
                else
                    state_next <= st_0001;
                end if;
            when st_0010 =>
                if start = '0' then
                    state_next <= idle;
                elsif status_next = '1' then
                    state_next <= st_0011;
                elsif status_back = '1' then
                    state_next <= st_0001;
                else
                    state_next <= st_0010;
                end if;
            when st_0011 =>            
                if start = '0' then
                    state_next <= idle;
                elsif status_next = '1' then
                    state_next <= st_0100;
                elsif status_back = '1' then
                    state_next <= st_0010;
                else
                    state_next <= st_0011;
                end if;
           when st_0100 =>            
                if start = '0' then
                   state_next <= idle;
                elsif status_next = '1' then
                   state_next <= st_0101;
                elsif status_back = '1' then
                   state_next <= st_0011;
                else
                   state_next <= st_0100;
                end if;
           when st_0101 =>            
                if start = '0' then
                   state_next <= idle;
                elsif status_next = '1' then
                   state_next <= st_0110;
                elsif status_back = '1' then
                   state_next <= st_0100; 
                else
                   state_next <= st_0101;
                end if;
           when st_0110 =>            
                if start = '0' then
                   state_next <= idle;
                elsif status_next = '1' then
                   state_next <= st_0111;
                elsif status_back = '1' then
                   state_next <= st_0101; 
                else
                   state_next <= st_0110;
                end if;
           when st_0111 =>            
                if start = '0' then
                   state_next <= idle;
                elsif status_next = '1' then
                   state_next <= st_1000;
                elsif status_back = '1' then
                   state_next <= st_0110; 
                else
                   state_next <= st_0111;
                end if;
           when st_1000 =>            
                if start = '0' then
                   state_next <= idle;
                elsif status_next = '1' then
                   state_next <= st_1001;
                elsif status_back = '1' then
                   state_next <= st_0111; 
                else
                   state_next <= st_1000;
                end if;
           when st_1001 =>            
                if start = '0' then
                   state_next <= idle;
                elsif status_back = '1' then
                   state_next <= st_1000;
                else 
                   state_next <= st_1001;
                end if; 
        end case;
    end process; 
    
    -- control path: output logic
    valid <= '0' when y_re_reg = conv_signed(0, 2*DATA_WIDTH) or y_im_reg = conv_signed(0, 2*DATA_WIDTH) else '1';
        
    -- datapath: data register
     process (clk, reset)
     begin
        if reset = '0' then
            y_re_reg <= (others => '0');
            y_im_reg <= (others => '0');
            adder_reg <= (others => '0');
        elsif (clk'event and clk='1') then
            y_re_reg <= y_re_next;
            y_im_reg <= y_im_next;
            adder_reg <= adder_next;
        end if;
     end process;
     
     -- datapath: routing input multiplexer
     process (state_reg) -- *** , p1, pr1, p2, pr2, p3, pr3, p4, pr4, p5, pr5, p6, pr6, p7, pr7, p8, pr8, p9, pr9, p10) when we are able to change this parametars during evaluation
     begin
       case state_reg is
           when idle =>
               mux1 <= (others => '0');
           when st_0000 =>
               mux1 <= signed(p1(AMPLIFICATION_WIDTH-1 downto 0));
               mux2 <= unsigned(pr1(BOUNDARIES_WIDTH-1 downto 0));
           when st_0001 =>
               mux1 <= signed (p2(AMPLIFICATION_WIDTH-1 downto 0));
               mux2 <= unsigned (pr2(BOUNDARIES_WIDTH-1 downto 0));
               mux3 <= unsigned (pr1(BOUNDARIES_WIDTH-1 downto 0));
           when st_0010 =>
               mux1 <= signed (p3(AMPLIFICATION_WIDTH-1 downto 0));
               mux2 <= unsigned (pr3(BOUNDARIES_WIDTH-1 downto 0));
               mux3 <= unsigned (pr2(BOUNDARIES_WIDTH-1 downto 0));
           when st_0011 =>
               mux1 <= signed (p4(AMPLIFICATION_WIDTH-1 downto 0));
               mux2 <= unsigned (pr4(BOUNDARIES_WIDTH-1 downto 0));
               mux3 <= unsigned (pr3(BOUNDARIES_WIDTH-1 downto 0));
           when st_0100 =>
               mux1 <= signed (p5(AMPLIFICATION_WIDTH-1 downto 0));
               mux2 <= unsigned (pr5(BOUNDARIES_WIDTH-1 downto 0));
               mux3 <= unsigned (pr4(BOUNDARIES_WIDTH-1 downto 0));
           when st_0101 =>
               mux1 <= signed (p6(AMPLIFICATION_WIDTH-1 downto 0));
               mux2 <= unsigned (pr6(BOUNDARIES_WIDTH-1 downto 0));
               mux3 <= unsigned (pr5(BOUNDARIES_WIDTH-1 downto 0));
           when st_0110 =>
               mux1 <= signed (p7(AMPLIFICATION_WIDTH-1 downto 0));
               mux2 <= unsigned (pr7(BOUNDARIES_WIDTH-1 downto 0));
               mux3 <= unsigned (pr6(BOUNDARIES_WIDTH-1 downto 0));
           when st_0111 =>
               mux1 <= signed (p8(AMPLIFICATION_WIDTH-1 downto 0));
               mux2 <= unsigned (pr8(BOUNDARIES_WIDTH-1 downto 0));
               mux3 <= unsigned (pr7(BOUNDARIES_WIDTH-1 downto 0));
           when st_1000 =>
               mux1 <= signed (p9(AMPLIFICATION_WIDTH-1 downto 0));
               mux2 <= unsigned (pr9(BOUNDARIES_WIDTH-1 downto 0));
               mux3 <= unsigned (pr8(BOUNDARIES_WIDTH-1 downto 0));
           when st_1001 =>
               mux1 <= signed (p10(AMPLIFICATION_WIDTH-1 downto 0));
               mux3 <= unsigned (pr9(BOUNDARIES_WIDTH-1 downto 0));
      end case;
    end process; 

    -- datapath: routing output multiplexer
    process (state_reg, adder_out)
    begin
      case state_reg is
         when idle =>
              adder_next <= (others => '0');
         when others =>
              adder_next <= adder_out;              
      end case;
   end process;
   
    -- datapath: functional units
   adder_out <= adder_reg + 1;
   subtraction_out <= (PACKAGE_LENGTH+1) - adder_out;
   y_re_next <= mux1 * signed(x_re);
   y_im_next <= mux1 * signed(x_im);
   
    -- datapath: status
   status_next <= '1' when adder_out = mux2 else '0';
   status_back <= '1' when subtraction_out = mux3 else '0';
   status_end <= '1' when subtraction_out = 1 else '0';
   
   -- datapath: output
    y_re <= std_logic_vector(y_re_reg((DATA_WIDTH+AMPLIFICATION_WIDTH)-3 downto AMPLIFICATION_WIDTH-2));
    y_im <= std_logic_vector(y_im_reg((DATA_WIDTH+AMPLIFICATION_WIDTH)-3 downto AMPLIFICATION_WIDTH-2)); 
       
end Behavioral;
