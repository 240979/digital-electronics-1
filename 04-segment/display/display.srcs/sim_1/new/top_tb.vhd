library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity top_tb is

end top_tb;

architecture Behavioral of top_tb is
 signal SW_s : STD_LOGIC_VECTOR (3 downto 0);
 signal LED_s : STD_LOGIC_VECTOR (7 downto 0);
 signal CA_s : STD_LOGIC;
 signal CB_s : STD_LOGIC;
 signal CC_s : STD_LOGIC;
 signal CD_s : STD_LOGIC;
 signal CE_s : STD_LOGIC;
 signal CF_s : STD_LOGIC;
 signal CG_s : STD_LOGIC;
 signal AN_s : STD_LOGIC_VECTOR (7 downto 0);
 signal BTNC_s : STD_LOGIC;
begin
uut_top : entity work.top
    port map (
      SW => SW_s,
      LED => LED_s,
      CA => CA_s,
      CB => CB_s,
      CC => CC_s,
      CD => CD_s,
      CE => CE_s,
      CF => CF_s,
      CG => CG_s,
      AN => AN_s,
      BTNC => BTNC_s
    );
p_stimulus : process is
  begin

    report "Stimulus process started";
    BTNC_s <= '0';

    -- Loop for all hex values
    for ii in 0 to 15 loop

      -- Convert ii decimal value to 4-bit wide binary
      -- s_hex <= std_logic_vector(to_unsigned(ii, s_hex'length));
      SW_s <= std_logic_vector(to_unsigned(ii, 4));
      wait for 50 ns;
    end loop;

    report "Stimulus process finished";
    wait;

  end process p_stimulus;

end Behavioral;
