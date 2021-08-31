-- Código de Subtrator c/ Comp. 2
library ieee;
use ieee.std_logic_1164.all;

Entity sub_4bit is port(
	a_sub4, b_sub4: in std_logic_vector(3 downto 0);
   c_ou_sub4: out std_logic;
	ov_sub4: out std_logic;
   s_sub4: out std_logic_vector(3 downto 0));
end sub_4bit;

Architecture structural of sub_4bit is

signal temp0: std_logic_vector(3 downto 0);

component fa_4bit is
    port (
        a_fa4, b_fa4: in std_logic_vector(3 downto 0);
        c_n_fa4: in std_logic;
        c_ou_fa4: out std_logic;
		  ov_fa4: out std_logic;
        s_fa4: out std_logic_vector(3 downto 0)
    );
end component;

component inversor_4bit is
    port (
        a_inv4: in std_logic_vector(3 downto 0);
        s_inv4: out std_logic_vector(3 downto 0)
    );
end component;

begin
	invert: inversor_4bit port map(a_inv4 => b_sub4, s_inv4 => temp0);
	soma: fa_4bit port map (a_fa4 => a_sub4, b_fa4 => temp0, c_n_fa4 => '0', 
									c_ou_fa4 => c_ou_sub4, ov_fa4 => ov_sub4, s_fa4 => s_sub4);
	
end structural;