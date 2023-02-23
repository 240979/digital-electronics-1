library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_3bit_4to1 is
    Port ( a_i : in STD_LOGIC_VECTOR (2 downto 0);
           b_i : in STD_LOGIC_VECTOR (2 downto 0);
           c_i : in STD_LOGIC_VECTOR (2 downto 0);
           d_i : in STD_LOGIC_VECTOR (2 downto 0); 
           sel_i : in STD_LOGIC_VECTOR (1 downto 0);
           f_o : out STD_LOGIC_VECTOR (2 downto 0));
end mux_3bit_4to1;

architecture Behavioral of mux_3bit_4to1 is

begin
with sel_i select
           f_o  <=  a_i when "00",
                    b_i when "01",
                    c_i when "10",
                    d_i when others;
end Behavioral;
