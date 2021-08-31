-- Código de Multiplexador 8:1 p/ 4 bits
library ieee;
use ieee.std_logic_1164.all;

entity mux_81 is port(
	E0, E1, E2, E3, E4, E5, E6, E7: in std_logic_vector(3 downto 0);
	s_mu8 : in std_logic_vector(2 downto 0);
	z_mu8: out std_logic_vector(3 downto 0)
);
end mux_81;

Architecture dataflow of mux_81 is

begin		
	z_mu8 <=  E0 when s_mu8 = "000" else
			E1 when s_mu8 = "001" else
			E2 when s_mu8 = "010" else
			E3 when s_mu8 = "011" else
			E4 when s_mu8 = "100" else
			E5 when s_mu8 = "101" else
			E6 when s_mu8 = "110" else
			E7 when s_mu8 = "111";
	

end dataflow;