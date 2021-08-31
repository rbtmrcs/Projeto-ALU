-- Projeto Incremento +1
library ieee;
use ieee.std_logic_1164.all;

entity inc1_4bit is
    port (
        a_inc1: in std_logic_vector(3 downto 0);
        c_ou_inc1: out std_logic;
        s_inc1: out std_logic_vector(3 downto 0)
    );
end inc1_4bit;

architecture structural of inc1_4bit is

component fa_1bit is
    port (
        a_fa1, b_fa1, c_n_fa1: in std_logic;
        s_fa1, c_ou_fa1: out std_logic
    );
end component;

signal temp0, temp1, temp2: std_logic;

begin
    inc0: fa_1bit port map(a_fa1 => a_inc1(0), b_fa1 => '1', c_n_fa1 => '0', c_ou_fa1 => temp0, s_fa1 => s_inc1(0));
    inc1: fa_1bit port map(a_fa1 => a_inc1(1), b_fa1 => '0', c_n_fa1 => temp0, c_ou_fa1 => temp1, s_fa1 => s_inc1(1));
    inc2: fa_1bit port map(a_fa1 => a_inc1(2), b_fa1 => '0', c_n_fa1 => temp1, c_ou_fa1 => temp2, s_fa1 => s_inc1(2));
    inc3: fa_1bit port map(a_fa1 => a_inc1(3), b_fa1 => '0', c_n_fa1 => temp2, c_ou_fa1 => c_ou_inc1, s_fa1 => s_inc1(3));
end structural;
