library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

--use work.utils_pkg.all;

entity mem_subsystem is
generic(
    C_S_AXI_DATA_WIDTH  : integer := 32
    );
port(                   
    clk                 : in std_logic;
    reset               : in std_logic;
    reg_data_i          : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    p1_wr_i             : in std_logic;
    p2_wr_i             : in std_logic;
    p3_wr_i             : in std_logic;
    p4_wr_i             : in std_logic;
    p5_wr_i             : in std_logic;
    p6_wr_i             : in std_logic;
    p7_wr_i             : in std_logic;
    p8_wr_i             : in std_logic;
    p9_wr_i             : in std_logic;
    p10_wr_i            : in std_logic;
    pr1_wr_i            : in std_logic;
    pr2_wr_i            : in std_logic;
    pr3_wr_i            : in std_logic;
    pr4_wr_i            : in std_logic;
    pr5_wr_i            : in std_logic;
    pr6_wr_i            : in std_logic;
    pr7_wr_i            : in std_logic;
    pr8_wr_i            : in std_logic;
    pr9_wr_i            : in std_logic;
    p1_o                : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    p2_o                : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    p3_o                : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    p4_o                : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    p5_o                : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    p6_o                : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    p7_o                : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    p8_o                : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    p9_o                : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    p10_o               : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    pr1_o               : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    pr2_o               : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    pr3_o               : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    pr4_o               : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    pr5_o               : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    pr6_o               : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    pr7_o               : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    pr8_o               : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    pr9_o               : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0) 
);
end mem_subsystem;
    

architecture struct of mem_subsystem is
    signal p1_s, p2_s, p3_s, p4_s, p5_s, p6_s, p7_s, p8_s, p9_s, p10_s: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal pr1_s, pr2_s, pr3_s, pr4_s, pr5_s, pr6_s, pr7_s, pr8_s, pr9_s: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
begin
    p1_o            <= p1_s;
    p2_o            <= p2_s;
    p3_o            <= p3_s;
    p4_o            <= p4_s;
    p5_o            <= p5_s;
    p6_o            <= p6_s;
    p7_o            <= p7_s;
    p8_o            <= p8_s;
    p9_o            <= p9_s;
    p10_o           <= p10_s;
    pr1_o           <= pr1_s;
    pr2_o           <= pr2_s;
    pr3_o           <= pr3_s;
    pr4_o           <= pr4_s;
    pr5_o           <= pr5_s;
    pr6_o           <= pr6_s;
    pr7_o           <= pr7_s;
    pr8_o           <= pr8_s;
    pr9_o           <= pr9_s;
 
-- P1 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                p1_s <= (others => '0');
            elsif p1_wr_i = '1' then
                p1_s <= reg_data_i;
            end if;
        end if;
    end process;
    
    -- P2 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                p2_s <= (others => '0');
            elsif p2_wr_i = '1' then
                p2_s <= reg_data_i;
            end if;
        end if;
    end process;
    
    -- P3 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                p3_s <= (others => '0');
            elsif p3_wr_i = '1' then
                p3_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- P4 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                p4_s <= (others => '0');
            elsif p4_wr_i = '1' then
                p4_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- P5 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                p5_s <= (others => '0');
            elsif p5_wr_i = '1' then
                p5_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- P6 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                p6_s <= (others => '0');
            elsif p6_wr_i = '1' then
                p6_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- P7 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                p7_s <= (others => '0');
            elsif p7_wr_i = '1' then
                p7_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- P8 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                p8_s <= (others => '0');
            elsif p8_wr_i = '1' then
                p8_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- P9 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                p9_s <= (others => '0');
            elsif p9_wr_i = '1' then
                p9_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- P10 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                p10_s <= (others => '0');
            elsif p10_wr_i = '1' then
                p10_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- PR1 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                pr1_s <= (others => '0');
            elsif pr1_wr_i = '1' then
                pr1_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- PR2 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                pr2_s <= (others => '0');
            elsif pr2_wr_i = '1' then
                pr2_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- PR3 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                pr3_s <= (others => '0');
            elsif pr3_wr_i = '1' then
                pr3_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- PR4 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                pr4_s <= (others => '0');
            elsif pr4_wr_i = '1' then
                pr4_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- PR5 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                pr5_s <= (others => '0');
            elsif pr5_wr_i = '1' then
                pr5_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- PR6 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                pr6_s <= (others => '0');
            elsif pr6_wr_i = '1' then
                pr6_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- PR7 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                pr7_s <= (others => '0');
            elsif pr7_wr_i = '1' then
                pr7_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- PR8 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                pr8_s <= (others => '0');
            elsif pr8_wr_i = '1' then
                pr8_s <= reg_data_i;
            end if;
        end if;
    end process;

    -- PR9 register
    process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '0' then
                pr9_s <= (others => '0');
            elsif pr9_wr_i = '1' then
                pr9_s <= reg_data_i;
            end if;
        end if;
    end process;

end struct;