library ieee;
use ieee.std_logic_1164.all;

entity comp_1bit is
    port (
        a_comp1, b_comp1: in std_logic;
        ma_comp1, me_comp1, ig_comp1: out std_logic
    );
end comp_1bit;

architecture dataflow of comp_1bit is
begin
    ma_comp1 <= a_comp1 and (not b_comp1);
    me_comp1 <= (not a_comp1) and b_comp1;
    ig_comp1 <= a_comp1 xnor b_comp1;
end dataflow;