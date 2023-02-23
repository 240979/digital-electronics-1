library ieee;
  use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------

entity tb_comparator_4bit is
  -- Entity of testbench is always empty
end entity tb_comparator_4bit;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------

architecture testbench of tb_comparator_4bit is

  -- Testbench local signals
  signal sig_a           : std_logic_vector(2 downto 0);
  signal sig_b           : std_logic_vector(2 downto 0);
  signal sig_c           : std_logic_vector(2 downto 0);
  signal sig_d           : std_logic_vector(2 downto 0);
  signal sig_sel           : std_logic_vector(1 downto 0);
  signal sig_f           : std_logic_vector(2 downto 0);
begin

  -- Connecting testbench signals with comparator_4bit
  -- entity (Unit Under Test)
  uut_mux_3bit_4to1 : entity work.mux_3bit_4to1
    port map (
      a_i           => sig_a,
      b_i           => sig_b,
      c_i           => sig_c,
      d_i           => sig_d,
      sel_i           => sig_sel,
      f_o => sig_f
    );

  --------------------------------------------------------
  -- Data generation process
  --------------------------------------------------------
  p_stimulus : process is
  begin

    -- Report a note at the beginning of stimulus process
    report "Stimulus process started";

    -- First test case ...
    
    sig_a <= "111";
    sig_b <= "001";
    sig_c <= "010";
    sig_d <= "100";
    sig_sel <= "01";
    wait for 100 ns;
    sig_a <= "000";
    sig_b <= "001";
    sig_c <= "010";
    sig_d <= "100";
    sig_sel <= "10";
    wait for 100 ns;
    sig_a <= "000";
    sig_b <= "001";
    sig_c <= "010";
    sig_d <= "100";
    sig_sel <= "11";
    wait for 100 ns;
    sig_a <= "111";
    sig_b <= "001";
    sig_c <= "010";
    sig_d <= "100";
    sig_sel <= "00";
    wait for 100 ns;
    sig_a <= "000";
    sig_b <= "000";
    sig_c <= "000";
    sig_d <= "000";
    sig_sel <= "00";
    -- Report a note at the end of stimulus process
    report "Stimulus process finished";

    wait; -- Data generation process is suspended forever

  end process p_stimulus;

end architecture testbench;
