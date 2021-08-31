-- Projeto Somador Completo 4 bits
library ieee;
use ieee.std_logic_1164.all;

entity fa_4bit is
    port (
      a_fa4, b_fa4: in std_logic_vector(3 downto 0);
      c_n_fa4: in std_logic;
      c_ou_fa4: out std_logic;
		ov_fa4: out std_logic;
      s_fa4: out std_logic_vector(3 downto 0)
    );
end fa_4bit;

architecture structural of fa_4bit is

component fa_1bit is
    port (
        a_fa1, b_fa1, c_n_fa1: in std_logic;
        s_fa1, c_ou_fa1:   out std_logic
    );
end component;

signal temp0, temp1, temp2, temp3: std_logic;

begin
    fa0: fa_1bit port map(	a_fa1 => a_fa4(0), b_fa1 => b_fa4(0), c_n_fa1 => c_n_fa4, 
									c_ou_fa1 => temp0, s_fa1 => s_fa4(0));
									
    fa1: fa_1bit port map(	a_fa1 => a_fa4(1), b_fa1 => b_fa4(1), c_n_fa1 => temp0, 
									c_ou_fa1 => temp1, s_fa1 => s_fa4(1));
									
    fa2: fa_1bit port map(	a_fa1 => a_fa4(2), b_fa1 => b_fa4(2), c_n_fa1 => temp1, 
									c_ou_fa1 => temp2, s_fa1 => s_fa4(2));
									
    fa3: fa_1bit port map(	a_fa1 => a_fa4(3), b_fa1 => b_fa4(3), c_n_fa1 => temp2, 
									c_ou_fa1 => temp3, s_fa1 => s_fa4(3));
									
	 c_ou_fa4 <= temp3;
	 ov_fa4 <= (temp3 xor temp2);
end structural; 
