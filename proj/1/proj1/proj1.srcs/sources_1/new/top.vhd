----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2023 01:29:58 PM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( SW : in STD_LOGIC_VECTOR (0 to 15);
           CLK100MHZ : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (3 downto 0));
end top;

architecture Behavioral of top is
signal sig_en : std_logic;
signal sig_data_0 : std_logic_vector (3 downto 0);
signal sig_data_1 : std_logic_vector (3 downto 0);
signal sig_data_2 : std_logic_vector (3 downto 0);
signal sig_data_3 : std_logic_vector (3 downto 0);
signal sig_rst_0 : std_logic;
signal sig_rst_1 : std_logic;
signal sig_rst_2 : std_logic;
signal sig_rst_3 : std_logic;
begin
 clk_en0 : entity work.clock_enable
    generic map
    (
      -- FOR SIMULATION, KEEP THIS VALUE TO 4
      -- FOR IMPLEMENTATION, CHANGE THIS VALUE TO 400,000
      -- 4      @ 4 ns
      -- 400000 @ 4 ms
--      g_MAX => 4
       g_MAX => 100000000 --1s
    )
    port map 
    (
      clk => CLK100MHZ,
      rst => BTNC,
      ce  => sig_en
    );
 cnt_up_down0: entity work.cnt_preload
 generic map
 (
    g_CNT_WIDTH => 4
 )
 port map
 (
 --  cnt_preload(7 downto 0) => SW(7 downto 0),
    cnt_preload(0) => SW(0),
    cnt_preload(1) => SW(1),
    cnt_preload(2) => SW(2),
    cnt_preload(3) => SW(3),
    clk => CLK100MHZ,   --: in    std_logic; --! Main clock
    rst => sig_rst_0,    --: in    std_logic; --! Synchronous reset
    en => sig_en,     --: in    std_logic; --! Enable input
    cnt_up => '0', --: in    std_logic; --! Direction of the counter (1 @ UP, 0 @ DOWN)
    cnt=> sig_data_0     --: out   std_logic_vector(g_CNT_WIDTH - 1 downto 0) --! Counter value
 );
  cnt_up_down1: entity work.cnt_preload
 generic map
 (
    g_CNT_WIDTH => 4
 )
 port map
 (
    cnt_preload(4) => SW(4),
    cnt_preload(5) => SW(5),
    cnt_preload(6) => SW(6),
    cnt_preload(7) => SW(7),
    clk => CLK100MHZ,   --: in    std_logic; --! Main clock
    rst => sig_rst_1,    --: in    std_logic; --! Synchronous reset
    en => sig_en,     --: in    std_logic; --! Enable input
    cnt_up => '0', --: in    std_logic; --! Direction of the counter (1 @ UP, 0 @ DOWN)
    cnt=> sig_data_1     --: out   std_logic_vector(g_CNT_WIDTH - 1 downto 0) --! Counter value
 );
 driver_7seg_4digits0 : entity work.driver_7seg_4digits
 port  map
 (
     clk => CLK100MHZ,     --: in    std_logic;
    rst => BTNC,    --: in    std_logic;
    data0 => "1111",   --: in    std_logic_vector(3 downto 0);
    data1 => "1111",   --: in    std_logic_vector(3 downto 0);
    data2 => sig_data_0,  --: in    std_logic_vector(3 downto 0);
    data3 => sig_data_1,   --: in    std_logic_vector(3 downto 0);
    dp_vect => "1111", --: in    std_logic_vector(3 downto 0);
    --dp =>,    --: out   std_logic;
    seg(6) => CA,
    seg(5) => CB,
    seg(4) => CC,
    seg(3) => CD,
    seg(2) => CE,
    seg(1) => CF,
    seg(0) => CG,     --: out   std_logic_vector(6 downto 0);
    dig => AN     --: out   std_logic_vector(3 downto 0)
   );
   p_cnt : process (sig_data_0) is
    begin
    if(sig_data_0 > "0000")
    then 
        sig_rst_0 <= '1';
        sig_rst_1 <= '0';
        sig_rst_2 <= '1';
        sig_rst_3 <= '1';
    end if;
   end process;
end Behavioral;
