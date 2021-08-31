-- Código Comparador 4 bit
library ieee;
use ieee.std_logic_1164.all;

entity comp_4bit is
    port (
        a_comp4, b_comp4: in std_logic_vector(3 downto 0);
        s_comp4: out std_logic_vector(3 downto 0)
    );
end comp_4bit;

architecture structural of comp_4bit is

component comp_1bit is
    port (
		a_comp1, b_comp1: in std_logic;
      ma_comp1, me_comp1, ig_comp1: out std_logic
    );
end component;

component mux_41 is port(
	E0, E1, E2, E3: in std_logic_vector(3 downto 0);
	s_mu4 : in std_logic_vector(1 downto 0);
	z_mu4: out std_logic_vector(3 downto 0)
);
end component;

signal ma0, ma1, ma2, ma3: std_logic;
signal me0, me1, me2, me3: std_logic;
signal ig0, ig1, ig2, ig3: std_logic;
signal maf, mef, igf: std_logic;

signal ch: std_logic_vector(1 downto 0);

begin
    c0: comp_1bit port map(a_comp1 => a_comp4(0), b_comp1 => b_comp4(0), ma_comp1 => ma0, me_comp1 => me0, ig_comp1 => ig0);
    c1: comp_1bit port map(a_comp1 => a_comp4(1), b_comp1 => b_comp4(1), ma_comp1 => ma1, me_comp1 => me1, ig_comp1 => ig1);
    c2: comp_1bit port map(a_comp1 => a_comp4(2), b_comp1 => b_comp4(2), ma_comp1 => ma2, me_comp1 => me2, ig_comp1 => ig2);
    c3: comp_1bit port map(a_comp1 => a_comp4(3), b_comp1 => b_comp4(3), ma_comp1 => ma3, me_comp1 => me3, ig_comp1 => ig3);
	 
    igf <= ig0 and ig1 and ig2 and ig3;
    maf <= ma3 or (ig3 and ma2) or (ig3 and ig2 and ma1) or (ig3 and ig2 and ig1 and ma0);
    mef <= me3 or (ig3 and me2) or (ig3 and ig2 and me1) or (ig3 and ig2 and ig1 and me0);
	 
	 ch(0) <= (not maf) and (mef) and (not igf);
	 ch(1) <= (not maf) and (not mef) and (igf);
	 
	 mux: mux_41 port map(
		E0 => a_comp4, E1 => b_comp4, E2 => a_comp4, E3 => "0000",
		s_mu4 => ch, z_mu4 => s_comp4
	 );
    
end structural;