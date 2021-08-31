-- Codigo para Decodificador de 3 bits
library ieee;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY decod_3bit IS
	Generic(N:integer:=3);
	PORT ( 
		x: in bit_vector(N-1 downto 0);
		y: out bit_vector((2**N)-1 downto 0)
	);
END decod_3bit;

ARCHITECTURE dataflow OF decod_3bit IS
	
	BEGIN
		y <= "00000001" when x = "000" else
			  "00000010" when x = "001" else
			  "00000100" when x = "010" else
			  "00001000" when x = "011" else
			  "00010000" when x = "100" else
			  "00100000" when x = "101" else
			  "01000000" when x = "110" else
			  "10000000" when x = "111";
			  
END dataflow;