-- Projeto Componente Somador bit-a-bit
library ieee;
use ieee.std_logic_1164.all;

entity fa_1bit is
    port (
        a_fa1, b_fa1, c_n_fa1: in std_logic;
        s_fa1, c_ou_fa1:   out std_logic
    );
end fa_1bit;

architecture dataflow of fa_1bit is
begin
    s_fa1    <= a_fa1 xor b_fa1 xor c_n_fa1;
    c_ou_fa1 <= (b_fa1 and c_n_fa1) or (a_fa1 and b_fa1) or (a_fa1 and c_n_fa1);
end dataflow;