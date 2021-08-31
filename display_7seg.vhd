-- Codigo para Display 7 segmentos
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity c2_7segment is port ( 
	c2in : in STD_LOGIC_VECTOR (3 downto 0);
	Seven_Segment : out STD_LOGIC_VECTOR (6 downto 0);
	Seven_Segment2 : out STD_LOGIC_VECTOR (6 downto 0));
end c2_7segment;
 
architecture dataflow of c2_7segment is
	begin
		Seven_Segment <= 	"0000001" when c2in = "0000" else 
								"1001111" when c2in = "0001" else 
								"0010010" when c2in = "0010" else 
								"0000110" when c2in = "0011" else 
								"1001100" when c2in = "0100" else 
								"0100100" when c2in = "0101" else 
								"0100000" when c2in = "0110" else 
								"0001111" when c2in = "0111" else 
								"0000000" when c2in = "1000" else 
								"1001111" when c2in = "1111" else 
								"0010010" when c2in = "1110" else 
								"0000110" when c2in = "1101" else 
								"1001100" when c2in = "1100" else 
								"0100100" when c2in = "1011" else 
								"0100000" when c2in = "1010" else 
								"0001111" when c2in = "1001" ;

		Seven_Segment2 <= "1111110" when c2in(3) = '1' else
								"1111111" when c2in(3) = '0' ;
 
end dataflow;