library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity memory_tb is
end memory_tb;

architecture Behavioral of memory_tb is
    constant WIDTH_1            :integer:=24;
    constant WIDTH_2            :integer:=11;
   
    type pr is array(0 to 8) of integer;
    constant PRAGOVI: pr := (5, 10, 19, 35, 70, 117, 163, 232, 348);
        
    type p is array(0 to 9) of integer;
    constant POJACANJA: p := (1, 2, 3, 4, 5, 6, 7, 8, 9, 10); 
    
    signal clk_s: std_logic;
    signal reset_s: std_logic;
    
    signal s_reg_data_i          : std_logic_vector(WIDTH_1-1 downto 0);
    signal s_p1_wr_i             : std_logic;
    signal s_p2_wr_i             : std_logic;
    signal s_p3_wr_i             : std_logic;
    signal s_p4_wr_i             : std_logic;
    signal s_p5_wr_i             : std_logic;
    signal s_p6_wr_i             : std_logic;
    signal s_p7_wr_i             : std_logic;
    signal s_p8_wr_i             : std_logic;
    signal s_p9_wr_i             : std_logic;
    signal s_p10_wr_i            : std_logic;
    signal s_pr1_wr_i            : std_logic;
    signal s_pr2_wr_i            : std_logic;
    signal s_pr3_wr_i            : std_logic;
    signal s_pr4_wr_i            : std_logic;
    signal s_pr5_wr_i            : std_logic;
    signal s_pr6_wr_i            : std_logic;
    signal s_pr7_wr_i            : std_logic;
    signal s_pr8_wr_i            : std_logic;
    signal s_pr9_wr_i            : std_logic;
    signal s_p1_o                : std_logic_vector(WIDTH_1-1 downto 0);
    signal s_p2_o                : std_logic_vector(WIDTH_1-1 downto 0);
    signal s_p3_o                : std_logic_vector(WIDTH_1-1 downto 0);
    signal s_p4_o                : std_logic_vector(WIDTH_1-1 downto 0);
    signal s_p5_o                : std_logic_vector(WIDTH_1-1 downto 0);
    signal s_p6_o                : std_logic_vector(WIDTH_1-1 downto 0);
    signal s_p7_o                : std_logic_vector(WIDTH_1-1 downto 0);
    signal s_p8_o                : std_logic_vector(WIDTH_1-1 downto 0);
    signal s_p9_o                : std_logic_vector(WIDTH_1-1 downto 0);
    signal s_p10_o               : std_logic_vector(WIDTH_1-1 downto 0);
    signal s_pr1_o               : std_logic_vector(WIDTH_2-1 downto 0);
    signal s_pr2_o               : std_logic_vector(WIDTH_2-1 downto 0);
    signal s_pr3_o               : std_logic_vector(WIDTH_2-1 downto 0);
    signal s_pr4_o               : std_logic_vector(WIDTH_2-1 downto 0);
    signal s_pr5_o               : std_logic_vector(WIDTH_2-1 downto 0);
    signal s_pr6_o               : std_logic_vector(WIDTH_2-1 downto 0);
    signal s_pr7_o               : std_logic_vector(WIDTH_2-1 downto 0);
    signal s_pr8_o               : std_logic_vector(WIDTH_2-1 downto 0);
    signal s_pr9_o               : std_logic_vector(WIDTH_2-1 downto 0);
    
begin

MEM_SYS: entity work.mem_subsystem(struct)
generic map 
( 
	WIDTH_1                => WIDTH_1,
    WIDTH_2                => WIDTH_2
)
port map
(
    clk                 =>      clk_s,
    reset               =>      reset_s,
    reg_data_i          =>      s_reg_data_i,
    p1_wr_i             =>      s_p1_wr_i,
    p2_wr_i             =>      s_p2_wr_i,
    p3_wr_i             =>      s_p3_wr_i,
    p4_wr_i             =>      s_p4_wr_i,
    p5_wr_i             =>      s_p5_wr_i,
    p6_wr_i             =>      s_p6_wr_i,
    p7_wr_i             =>      s_p7_wr_i,
    p8_wr_i             =>      s_p8_wr_i,
    p9_wr_i             =>      s_p9_wr_i,
    p10_wr_i            =>      s_p10_wr_i,
    pr1_wr_i            =>      s_pr1_wr_i,
    pr2_wr_i            =>      s_pr2_wr_i,
    pr3_wr_i            =>      s_pr3_wr_i,
    pr4_wr_i            =>      s_pr4_wr_i,
    pr5_wr_i            =>      s_pr5_wr_i,
    pr6_wr_i            =>      s_pr6_wr_i,
    pr7_wr_i            =>      s_pr7_wr_i,
    pr8_wr_i            =>      s_pr8_wr_i,
    pr9_wr_i            =>      s_pr9_wr_i,
    p1_o                =>      s_p1_o,
    p2_o                =>      s_p2_o,
    p3_o                =>      s_p3_o,
    p4_o                =>      s_p4_o,
    p5_o                =>      s_p5_o,
    p6_o                =>      s_p6_o,
    p7_o                =>      s_p7_o,                 
    p8_o                =>      s_p8_o,                 
    p9_o                =>      s_p9_o,                 
    p10_o               =>      s_p10_o,                
    pr1_o               =>      s_pr1_o,                
    pr2_o               =>      s_pr2_o,                
    pr3_o               =>      s_pr3_o,                
    pr4_o               =>      s_pr4_o,                
    pr5_o               =>      s_pr5_o,                
    pr6_o               =>      s_pr6_o,                
    pr7_o               =>      s_pr7_o,                
    pr8_o               =>      s_pr8_o,                
    pr9_o               =>      s_pr9_o                
);

    clk_gen: process
    begin
    clk_s <= '0', '1' after 100 ns;
    wait for 200 ns;
    end process;

test: process
begin
    reset_s <= '0';
    
    for i in 1 to 5 loop
        wait until rising_edge(clk_s);
    end loop;
        
    reset_s <= '1';
        
    wait until falling_edge(clk_s);
    s_reg_data_i <= conv_std_logic_vector(POJACANJA(0), WIDTH_2);
    wait until falling_edge(clk_s);
    s_p1_wr_i <= '1';
    wait until falling_edge(clk_s);
    s_p1_wr_i <= '0';
    
    for i in 1 to 5 loop
    wait until falling_edge(clk_s);
    end loop;
    
    s_reg_data_i <= conv_std_logic_vector(POJACANJA(1), WIDTH_2);
    wait until falling_edge(clk_s);
    s_p2_wr_i <= '1';
    wait until falling_edge(clk_s);
    s_p2_wr_i <= '0';
    
    for i in 1 to 5 loop
    wait until falling_edge(clk_s);
    end loop;
        
    s_reg_data_i <= conv_std_logic_vector(POJACANJA(2), WIDTH_2);
    wait until falling_edge(clk_s);
    s_p3_wr_i <= '1';
    wait until falling_edge(clk_s);
    s_p3_wr_i <= '0';
    
    for i in 1 to 5 loop
    wait until falling_edge(clk_s);
    end loop;

    s_reg_data_i <= conv_std_logic_vector(POJACANJA(3), WIDTH_2);
    wait until falling_edge(clk_s);
    s_p4_wr_i <= '1';
    wait until falling_edge(clk_s);
    s_p4_wr_i <= '0';
    
    for i in 1 to 5 loop
    wait until falling_edge(clk_s);
    end loop;

    s_reg_data_i <= conv_std_logic_vector(POJACANJA(4), WIDTH_2);
    wait until falling_edge(clk_s);
    s_p5_wr_i <= '1';
    wait until falling_edge(clk_s);
    s_p5_wr_i <= '0';
    
    for i in 1 to 5 loop
    wait until falling_edge(clk_s);
    end loop;
    
    s_reg_data_i <= conv_std_logic_vector(POJACANJA(5), WIDTH_2);
    wait until falling_edge(clk_s);
    s_p6_wr_i <= '1';
    wait until falling_edge(clk_s);
    s_p6_wr_i <= '0';
    

    for i in 1 to 5 loop
    wait until falling_edge(clk_s);
    end loop;
    
    s_reg_data_i <= conv_std_logic_vector(POJACANJA(6), WIDTH_2);
    wait until falling_edge(clk_s);
    s_p7_wr_i <= '1';
    wait until falling_edge(clk_s);
    s_p7_wr_i <= '0';


    for i in 1 to 500 loop
    wait until falling_edge(clk_s);
    end loop;
    

    -- I TAKO DALJE ZA OSTALE P6, P7 ... P10 i PR1 ..... PR9

end process;

end Behavioral;