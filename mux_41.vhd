-- Codigo para Multiplexador 4:1 p/ 4 bits
library ieee;
use ieee.std_logic_1164.all;

entity mux_41 is port(
	E0, E1, E2, E3: in std_logic_vector(3 downto 0);
	s_mu4 : in std_logic_vector(1 downto 0);
	z_mu4: out std_logic_vector(3 downto 0)
);
end mux_41;

Architecture dataflow of mux_41 is

begin
	z_mu4 <= E0 when s_mu4 = "00" else
				E1 when s_mu4 = "01" else
				E2 when s_mu4 = "10" else
				E3 when s_mu4 = "11";

end dataflow;
