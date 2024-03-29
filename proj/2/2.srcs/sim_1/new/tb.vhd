----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2023 01:53:49 PM
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
  -- Number of bits for testbench counter
  constant c_CNT_WIDTH         : natural := 3;
  constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
  signal sig_clk_100mhz : std_logic;
  signal sig_rst        : std_logic;
  signal sig_set_round : std_logic_vector (3 downto 0);
  signal sig_set_pause : std_logic_vector (5 downto 0);
  signal sig_set_run : std_logic_vector (5 downto 0);
  signal sig_out : std_logic_vector (5 downto 0);
begin
uut_state : entity work.statemachine
    port map (
      clk    => sig_clk_100mhz,
      rst    => sig_rst,
      set_round => sig_set_round,
      set_pause => sig_set_pause,
      set_run => sig_set_run,
      output => sig_out
    );
p_clk_gen : process is
  begin

    while now < 9990 ns loop             -- 75 periods of 100MHz clock

      sig_clk_100mhz <= '0';
      wait for c_CLK_100MHZ_PERIOD / 2;
      sig_clk_100mhz <= '1';
      wait for c_CLK_100MHZ_PERIOD / 2;

    end loop;
    wait;                               -- Process is suspended forever

  end process p_clk_gen;

  --------------------------------------------------------
  -- Reset generation process
  --------------------------------------------------------
  p_reset_gen : process is
  begin

    sig_rst <= '0';
    wait for 12 ns;

    -- Reset activated
    sig_rst <= '1';
    wait for 70 ns;

    -- Reset deactivated
    sig_rst <= '0';

    wait;

  end process p_reset_gen;
p_stimulus : process is
  begin

    report "Stimulus process started";
    sig_set_run <= "000011";
    sig_set_pause <= "000111";
    sig_set_round <= "0010";
    report "Stimulus process finished";
    wait;

  end process p_stimulus;
end Behavioral;
