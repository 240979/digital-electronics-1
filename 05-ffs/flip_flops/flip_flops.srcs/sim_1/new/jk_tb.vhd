----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2023 02:17:30 PM
-- Design Name: 
-- Module Name: jk_tb - Behavioral
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

entity jk_tb is
    Port ( j : in STD_LOGIC;
           k : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst: in STD_LOGIC;
           q : out STD_LOGIC;
           q_bar : out STD_LOGIC);
end jk_tb;

architecture testbench_jk of tb_ff_rst is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal sig_clk_100MHz : std_logic;
    signal sig_j          : std_logic;
    signal sig_k          : std_logic;
    signal sig_q          : std_logic;
    signal sig_q_bar      : std_logic;
    signal sig_rst        : std_logic;

begin
    -- Connecting testbench signals with jk_ff
    -- (Unit Under Test)
    uut_jk_ff : entity work.jk_ff
        port map (
            clk   => sig_clk_100MHz,
            j   => sig_j,
            k     => sig_k,
            rst => sig_rst,
            q     => sig_q,
            q_bar => sig_q_bar
        );
    --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    p_clk_gen : process is
    begin
        while now < 300 ns loop -- 30 periods of 100MHz clock
            sig_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            sig_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                -- Process is suspended forever
    end process p_clk_gen;
    
    p_reset_gen : process is
    begin
        sig_rst <= '0';
        wait for 4 ns;
        sig_rst <= '1';
        wait for 2 ns;
        sig_rst <= '0';
        wait for 66 ns;
        sig_rst <= '1';
        wait for 66 ns;
        sig_rst <= '0';
        -- ACTIVATE AND DEACTIVATE RESET HERE
        -- wait for XXX ns;
        -- sig_rst <= XXX;
        -- wait for XXX ns;
        -- sig_rst <= XXX;

        wait;
    end process p_reset_gen;
    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process is
    begin
        report "Stimulus process started";
        sig_j <='0';
        sig_k <='1';
        wait for 13 ns;
        sig_j <='1';
        sig_k <='0';
        wait for 26 ns;
        sig_j <='0';
        sig_k <='0';
        wait for 13 ns;
        sig_j <='1';
        sig_k <='1';
        report "Stimulus process finished";
        wait;
    end process p_stimulus;

end architecture testbench_jk;