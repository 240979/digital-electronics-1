----------------------------------------------------------
--
--! @title N-bit Up/Down binary counter
--! @author Tomas Fryza
--! Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
--!
--! @copyright (c) 2019 Tomas Fryza
--! This work is licensed under the terms of the MIT license
--!
--! Implementation of bidirectional N-bit counter. Number
--! of bits is set by `g_CNT_WIDTH` and counting direction
--! by `cnt_up` input.
--
-- Hardware: Nexys A7-50T, xc7a50ticsg324-1L
-- Software: TerosHDL, Vivado 2020.2, EDA Playground
--
----------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

----------------------------------------------------------
-- Entity declaration for N-bit counter
----------------------------------------------------------

entity cnt_preload is
  generic (
    g_CNT_WIDTH : natural := 4 --! Default number of counter bits
  );
  port (
    clk    : in    std_logic; --! Main clock
    rst    : in    std_logic; --! Synchronous reset
    en     : in    std_logic; --! Enable input
    cnt_up : in    std_logic; --! Direction of the counter (1 @ UP, 0 @ DOWN)
    cnt_preload: in std_logic_vector(g_CNT_WIDTH - 1 downto 0); 
    cnt    : out   std_logic_vector(g_CNT_WIDTH - 1 downto 0) --! Counter value
  );
end entity cnt_preload;

----------------------------------------------------------
-- Architecture body for N-bit counter
----------------------------------------------------------

architecture behavioral of cnt_preload is

--  signal sig_cnt : unsigned(g_CNT_WIDTH - 1 downto 0) := (others => '0'); --! Local counter
signal sig_cnt : unsigned(g_CNT_WIDTH - 1 downto 0) := unsigned(cnt_preload);
begin

  --------------------------------------------------------
  -- p_cnt_up_down:
  -- Clocked process with synchronous reset which implements
  -- n-bit up/down counter.
  --------------------------------------------------------
  p_cnt_preload : process (clk) is
  begin

    if rising_edge(clk) then
      if (rst = '1') then           -- Synchronous reset
 --       sig_cnt <= (others => '0'); -- Clear all bits
          sig_cnt <= unsigned(cnt_preload);
      elsif (en = '1') then         -- Test if counter is enabled

        -- TEST COUNTER DIRECTION HERE
            if (cnt_up = '1')
            then
                if( sig_cnt > "1001")
                then
                    sig_cnt <= unsigned(cnt_preload);
                else
                    
                 sig_cnt <= sig_cnt + 1;
                end if;
            else 
                if( sig_cnt < "0001")
                then
                    sig_cnt <= unsigned(cnt_preload);
                else
                    
                 sig_cnt <= sig_cnt - 1;
                end if;
            end if;
      end if;
    end if;

  end process p_cnt_preload;

  -- Output must be retyped from "unsigned" to "std_logic_vector"
  cnt <= std_logic_vector(sig_cnt);

end architecture behavioral;
