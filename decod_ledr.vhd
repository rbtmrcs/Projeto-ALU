-- Codigo para Decodificador p/ LEDR
library ieee;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY decod_ledr IS
	PORT ( 
		x: in bit_vector(1 downto 0);
		y: out bit_vector(17 downto 0)
	);
END decod_ledr;

ARCHITECTURE dataflow OF decod_3bit IS
	
	BEGIN
		y <= "0000000000100000" when x = "00" else -- LEDR6
			  "0000000001000000" when x = "01" else -- LEDR7
			  "0000000010000000" when x = "10" else -- LEDR8
			  "0000000100000000" when x = "11";     -- LEDR9
			  
END dataflow;