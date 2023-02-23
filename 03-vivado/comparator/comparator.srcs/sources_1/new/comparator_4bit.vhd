library ieee;
  use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for 4-bit binary comparator
------------------------------------------------------------

entity comparator_4bit is
  port (
    b           : in    std_logic_vector(3 downto 0); --! Input data B[3:0]
    a           : in    std_logic_vector(3 downto 0); --! Input data A[3:0]
    b_greater_a : out   std_logic;                    --! Output is `1` if B>A
    b_equals_a  : out   std_logic;                    --! Output is `1` if B=A
    b_less_a    : out   std_logic                     --! Output is `1` if B<A
  );
end entity comparator_4bit;

------------------------------------------------------------
-- Architecture body for 4-bit binary comparator
------------------------------------------------------------

architecture behavioral of comparator_4bit is

begin

  b_greater_a <= '1' when (b > a) 
                        else '0';
  b_equals_a  <= '1' when (b = a)
                        else '0';
  b_less_a    <= '1' when (b < a)
                        else '0';
                        
end architecture behavioral;