library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_ff is
    Port ( 
        CLK100MHZ : in STD_LOGIC;
        BTNC : in STD_LOGIC;
        D_IN : in STD_LOGIC;
        Q_OUT : out STD_LOGIC
    );
end top_ff;

architecture behavioral of top_ff is

  -- Internal signals between flip-flops
  signal sig_ff0 : std_logic;
  signal sig_ff1 : std_logic;
  signal sig_ff2 : std_logic;
  -- WRITE YOUR CODE HERE

begin

  --------------------------------------------------------------------
  -- Four instances (copies) of D-type FF entity
  d_ff_0 : entity work.d_ff_rst
      port map (
          d => D_IN,  
          clk => CLK100MHZ,
          rst => BTNC,
          -- WRITE YOUR CODE HERE
          q   => sig_ff0
      );

  d_ff_1 : entity work.d_ff_rst
      port map (
          d => sig_ff0,
          clk => CLK100MHZ,
          rst => BTNC,
          -- WRITE YOUR CODE HERE
          q   => sig_ff1
      );
d_ff_2 : entity work.d_ff_rst
      port map (
          d => sig_ff1,
          clk => CLK100MHZ,
          rst => BTNC,
          q   => sig_ff2
      );

d_ff_3 : entity work.d_ff_rst
      port map (
          d => sig_ff2,
          clk => CLK100MHZ,
          rst => BTNC,
          q => Q_OUT
          -- WRITE YOUR CODE HERE
      );

  -- PUT OTHER TWO FLIP-FLOP INSTANCES HERE

end architecture behavioral;