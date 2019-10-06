library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_bench is
   
end test_bench;

architecture Behavioral of test_bench is

    signal x_re_s: std_logic_vector(23 downto 0);
    signal x_im_s: std_logic_vector(23 downto 0);
    signal p1_s: std_logic_vector(23 downto 0);
    signal p2_s: std_logic_vector(23 downto 0);
    signal p3_s: std_logic_vector(23 downto 0);
    signal p4_s: std_logic_vector(23 downto 0);
    signal p5_s: std_logic_vector(23 downto 0);
    signal p6_s: std_logic_vector(23 downto 0);
    signal p7_s: std_logic_vector(23 downto 0);
    signal p8_s: std_logic_vector(23 downto 0);
    signal p9_s: std_logic_vector(23 downto 0);
    signal p10_s: std_logic_vector(23 downto 0);
    signal pr1_s: std_logic_vector(10 downto 0);
    signal pr2_s: std_logic_vector(10 downto 0);
    signal pr3_s: std_logic_vector(10 downto 0);
    signal pr4_s: std_logic_vector(10 downto 0);
    signal pr5_s: std_logic_vector(10 downto 0);
    signal pr6_s: std_logic_vector(10 downto 0);
    signal pr7_s: std_logic_vector(10 downto 0);
    signal pr8_s: std_logic_vector(10 downto 0);
    signal pr9_s: std_logic_vector(10 downto 0);    
    signal clk_s: std_logic;
    signal reset_s: std_logic;
    signal start_s: std_logic;
   
    signal y_re_s: std_logic_vector(23 downto 0);
    signal y_im_s: std_logic_vector(23 downto 0);
    signal valid_s: std_logic;
 begin
    
    mnozenje: entity work.IP(Behavioral)
      generic map(
      WIDTH_1 => 24,
      WIDTH_2 => 11,
      PACKAGE_LENGTH => 1025)
      
      port map(
      clk => clk_s,
      reset => reset_s,
      start => start_s,
      x_re => x_re_s,
      x_im => x_im_s,
      y_re => y_re_s,
      y_im => y_im_s,
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
      valid => valid_s);
      
    clk_gen: process
      begin
        clk_s <= '0', '1' after 100 ns;
        wait for 200 ns;
      end process;

    reset_s <= '0', '1' after 200 ns; --, '0' after 2000ns, '1' after 2220ns;
    start_s <= '0', '1' after 400 ns;
    p1_s <= x"200000";
    p2_s <= x"100000";
    p3_s <= x"080000";
    p4_s <= x"040000";
    p5_s <= x"020000";
    p6_s <= x"010000";
    p7_s <= x"008000";
    p8_s <= x"004000";
    p9_s <= x"002000";
    p10_s <= x"001000";

    pr1_s <= "00000000101";
    pr2_s <= "00000001010";
    pr3_s <= "00000010011";
    pr4_s <= "00000100011";
    pr5_s <= "00001000110";
    pr6_s <= "00001110101";
    pr7_s <= "00010100011";
    pr8_s <= "00011101000";
    pr9_s <= "00101011100";

    process 
    begin
    x_re_s <= x"000000";
    x_im_s <= x"000000";
    
    wait until start_s = '1';
    wait for 100ns;
    for i in 1 to 512 loop
    x_re_s <= x"010000";
    x_im_s <= x"010000";
    wait until rising_edge(clk_s);
    x_re_s <= x"008000";
    x_im_s <= x"008000";
    wait until rising_edge(clk_s);    
    end loop;
    
    for i in 1 to 50000 loop
    wait until rising_edge(clk_s);
    end loop;
    
    end process;
end Behavioral;