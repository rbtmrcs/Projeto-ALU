-- Codigo para Enable
library ieee;
use ieee.std_logic_1164.all;

entity enable is port (
	en: in std_logic;
	zin: in std_logic_vector (3 downto 0);
	zout: out std_logic_vector (3 downto 0));
end enable;

architecture dataflow of enable is

begin 
	zout <= "0000" when en = '0' else
				zin when en = '1' ;
		  
END dataflow;