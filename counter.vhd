-- Codigo referente à contador de 10 bits a partir de um Clock
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter is Port ( 
	clock : in STD_LOGIC;
	count : buffer STD_LOGIC_VECTOR (9 downto 0);
	reset : in STD_LOGIC;
	load : in STD_LOGIC;
	start : in STD_LOGIC_VECTOR (9 downto 0)
);
end counter;

architecture behavioral of counter is
	begin
	-- Iniciando o processo de clock:
	upcount: process( clock ) 
	begin
		IF( clock'event and clock= '1' ) THEN
			IF reset = '1' THEN
				count <= "0000000000";
			ELSIF load = '1' THEN
				-- possibilidade de inserir carga paralela, para definir o inicio da contagem
				count <= start;
			ELSE
				-- implementando a contagem bit a bit
				count(0) <= NOT count(0);
				count(1) <= count(0) XOR count(1);
				count(2) <= ( count(0) AND count(1) ) XOR count(2);
				count(3) <= ( count(0) AND count(1) AND count(2) ) XOR
				count(3);
				count(4) <= ( count(0) AND count(1) AND count(2) AND
				count(3) ) XOR count(4);
				count(5) <= ( count(0) AND count(1) AND count(2) AND
				count(3) AND count(4) ) XOR count(5);
				count(6) <= ( count(0) AND count(1) AND count(2) AND
				count(3) AND count(4) AND count(5) ) XOR count(6);
				count(7) <= ( count(0) AND count(1) AND count(2) AND
				count(3) AND count(4) AND count(5) AND count(6) ) XOR count(7);
				count(8) <= ( count(0) AND count(1) AND count(2) AND
				count(3) AND count(4) AND count(5) AND count(6) AND count(7) ) XOR count(8);
				count(9) <= ( count(0) AND count(1) AND count(2) AND
				count(3) AND count(4) AND count(5) AND count(6) AND count(7) AND count(8) ) XOR
				count(9);
			END IF; -- IF reset = '1'
		END IF; -- clock'event AND clock= '1'
	END PROCESS upcount;
END behavioral;
