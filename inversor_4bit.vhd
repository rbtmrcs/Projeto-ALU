-- Projeto Inversor de Sinal 4 bits
library ieee;
use ieee.std_logic_1164.all;

Entity inversor_4bit is
    port (
        a_inv4: in std_logic_vector(3 downto 0);
        s_inv4: out std_logic_vector(3 downto 0)
    );
end inversor_4bit;

architecture dataflow of inversor_4bit is

signal a_inv4_not: std_logic_vector (3 downto 0);
signal tmp0: std_logic;
    
component fa_4bit is
	port (
		a_fa4, b_fa4: in std_logic_vector(3 downto 0);
      c_n_fa4: in std_logic;
      c_ou_fa4: out std_logic;
		ov_fa4: out std_logic;
      s_fa4: out std_logic_vector(3 downto 0)
   );
end component;

begin	 
	 a_inv4_not <= not a_inv4;
	 tmp0 <= '0';
    sum: fa_4bit port map (
		a_fa4 => a_inv4_not, b_fa4 => "0000", c_n_fa4 => '1', 
		c_ou_fa4 => tmp0, ov_fa4 => tmp0, s_fa4 => s_inv4
	 );
	 
end dataflow;