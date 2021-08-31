-- Projeto ALU - Top Entity
library ieee;
use ieee.std_logic_1164.all;

Entity SD_Trabalho_01 is port(
	-- Entradas de 4 bits
	A, B: in std_logic_vector(3 downto 0);
	-- Chave Seletora de 3 bits
	SEL : in std_logic_vector(2 downto 0);
	-- Entrada Enable
	CH_ENABLE : in std_logic;
	-- Flags de saida
	overflow, negative, zero, carry_ou: out std_logic;
	-- Saida de 4 bits
	S : out std_logic_vector(3 downto 0);
	
	-- -- Mapeamento de referencias para placa FPGA
	-- Clock
	CLOCK_50: in std_logic;	
	-- Displays 7 segmentos
	HEX0, HEX1, HEX4, HEX5, HEX6, HEX7: std_logic_vector(6 downto 0);
	-- LEDs de Flags
	LEDR: std_logic_vector(17 downto 0)
);
end SD_Trabalho_01;

Architecture ALU of SD_Trabalho_01 is

-- Operador 1: Componennte Somador de 4 bits
component fa_4bit is port (
	a_fa4, b_fa4: in std_logic_vector(3 downto 0);
   c_n_fa4: in std_logic;
   c_ou_fa4: out std_logic;
	ov_fa4: out std_logic;
   s_fa4: out std_logic_vector(3 downto 0));
end component;

-- Operador 2: Subtrator de 4 bits em Complemento 2
component sub_4bit is port(
	a_sub4, b_sub4: in std_logic_vector(3 downto 0);
   c_ou_sub4: out std_logic;
	ov_sub4: out std_logic;
   s_sub4: out std_logic_vector(3 downto 0));
end component;

-- Operacao 3: Incremento + 1
component inc1_4bit is port (
	a_inc1: in std_logic_vector(3 downto 0);
   c_ou_inc1: out std_logic;
   s_inc1: out std_logic_vector(3 downto 0));
end component;

-- Operacao 4: Troca de Sinal
component inversor_4bit is port(
	a_inv4: in std_logic_vector(3 downto 0);
   s_inv4: out std_logic_vector(3 downto 0));
end component;

-- Operacoes 5, 6 e 7: Comparador
component comp_4bit is port (
	a_comp4, b_comp4: in std_logic_vector(3 downto 0);
   s_comp4: out std_logic_vector(3 downto 0));
end component;

-- Modulo Multiplexador 8:1 p/ 4 bits
component mux_81 is port(
	E0, E1, E2, E3, E4, E5, E6, E7: in std_logic_vector(3 downto 0);
	s_mu8 : in std_logic_vector(2 downto 0);
	z_mu8: out std_logic_vector(3 downto 0));
end component;

-- Modulo Multiplexador 8:1 p/ 1 bit
component mux_81_1bit is port(
	E0, E1, E2, E3, E4, E5, E6, E7: in std_logic;
	s_mu8 : in std_logic_vector(2 downto 0);
	z_mu8: out std_logic);
end component;

-- Modulo Enable
component enable is port (
	en: in std_logic;
	zin: in std_logic_vector (3 downto 0);
	zout: out std_logic_vector (3 downto 0));
end component;

-- Modulo Decodificador p/ LEDR
component decod_ledr IS
	PORT ( 
		x: in bit_vector(1 downto 0);
		y: out bit_vector(17 downto 0)
	);
END component;

-- Modulo Display 7 segmentos
component c2_7segment is port ( 
	c2in : in STD_LOGIC_VECTOR (3 downto 0);
	Seven_Segment : out STD_LOGIC_VECTOR (6 downto 0);
	Seven_Segment2 : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal s_tmp_soma, s_tmp_sub, s_tmp_inc, s_tmp_troca, s_tmp_ma, s_tmp_me, s_tmp_ig, s_tmp_notA: std_logic_vector(3 downto 0);
signal ov_tmp_soma, ov_tmp_sub: std_logic;
signal c_tmp_soma, c_tmp_sub, c_tmp_inc: std_logic;
signal zero_tmp0, zero_tmp1, zero_tmp2, zero_tmp3: std_logic;
signal s_tmp_final: std_logic_vector(3 downto 0);
signal flag_ov, flag_c_ou, flag_neg, flag_zero: std_logic_vector(17 downto 0);

begin	
	-- -- Operacoes
	-- Operacao 1: Soma
	soma: fa_4bit port map (a_fa4 => A, b_fa4 => B, c_n_fa4 => '0', c_ou_fa4 => c_tmp_soma,
									ov_fa4 => Ov_tmp_soma, s_fa4 => s_tmp_soma);
	
	-- Operacao 2: Subtracao em Complemento de 2
	subtracao: sub_4bit port map (a_sub4 => A, b_sub4 => B, c_ou_sub4 => c_tmp_sub, 
											ov_sub4 => ov_tmp_sub, s_sub4 => s_tmp_sub);
	
	-- Operacao 3: Incremento + 1
	incremento: inc1_4bit port map(a_inc1 => A, c_ou_inc1 => c_tmp_inc, s_inc1 => s_tmp_inc);
	
	-- Operacao 4: Troca de Sinal
	troca: inversor_4bit port map(a_inv4 => A, s_inv4 => s_tmp_troca);
	
	-- Operacao 5: Comparador - Maior
	comp_ma: comp_4bit port map(a_comp4 => A, b_comp4 => B, s_comp4 => s_tmp_ma);
	
	-- Operacao 6: Comparador - Menor
	comp_me: comp_4bit port map(a_comp4 => A, b_comp4 => B, s_comp4 => s_tmp_me);
	
	-- Operacao 7: Comparador - Igual
	comp_ig: comp_4bit port map(a_comp4 => A, b_comp4 => B, s_comp4 => s_tmp_ig);
	
	-- Operacao 8: Not A
	s_tmp_notA <= not A;
	
	
	-- -- Display 7 segmentos	
	-- Display de Entrada A
	display0: c2_7segment port map(c2in => A, seven_segment => HEX6, seven_segment2 => HEX7);
	-- Display de Entrada B
	display1: c2_7segment port map(c2in => B, seven_segment => HEX5, seven_segment2 => HEX4);
	-- Display de Saída S
	display2: c2_7segment port map(c2in => S, seven_segment => HEX0, seven_segment2 => HEX1);
	
	-- -- Saídas
	-- MUX 8:1 para resultado S de operacao
	mux0: mux_81 port map(
		E0 => s_tmp_soma, E1 => s_tmp_sub, E2 => s_tmp_inc, E3 => s_tmp_troca,
		E4 => s_tmp_ma, E5 => s_tmp_me, E6 => s_tmp_ig, E7 => s_tmp_notA,
		s_mu8 => SEL, z_mu8 => s_tmp_final
	);
	
	-- Controle Enable
	enable_port: enable port map(en => CH_ENABLE, zin => s_tmp_final, zout => S);
	
	-- Flag Overflow
	mux1: mux_81_1bit port map(
		E0 => c_tmp_soma, E1 => c_tmp_sub, E2 => '0', E3 => '0',
		E4 => '0', E5 => '0', E6 => '0', E7 => '0',
		s_mu8 => SEL, z_mu8 => flag_ov
	);
	overflow <= flag_ov;
	
	-- Flag Carry Out
	mux2: mux_81_1bit port map(
		E0 => ov_tmp_soma, E1 => ov_tmp_sub, E2 => c_tmp_inc, E3 => '0',
		E4 => '0', E5 => '0', E6 => '0', E7 => '0',
		s_mu8 => SEL, z_mu8 => flag_c_ou
	);
	carry_ou <= flag_c_ou;
	
	-- Flag Negativo
	flag_zero <= s_tmp_final(3);
	negative <= flag_zero;
	
	-- Flag Zero
	zero_tmp0 <= S_tmp_final(0);
	zero_tmp1 <= S_tmp_final(1);
	zero_tmp2 <= S_tmp_final(2);
	zero_tmp3 <= S_tmp_final(3);
	flag_zero <= not (zero_tmp0 or zero_tmp1 or zero_tmp2 or zero_tmp3);
	zero <= flag_zero;

end ALU;