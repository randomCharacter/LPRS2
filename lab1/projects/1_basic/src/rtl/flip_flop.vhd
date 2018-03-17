-- @license MIT
-- @brief D flip-flop based register.

library ieee;
use ieee.std_logic_1164.all;

entity flip_flop is
	generic(
		RST_INIT : boolean := false
	);
	port(
		i_clk  : in  std_logic;
		in_rst : in  std_logic;
		i_d    : in  std_logic;
		o_q    : out std_logic
	);
end entity flip_flop;

architecture arch_flip_flop of flip_flop is
	
	signal r_q : std_logic;
	
begin
	
	process(i_clk, in_rst)
	begin
		if in_rst = '0' then
			if RST_INIT then
				r_q <= '1';
			else
				r_q <= '0';
			end if;
		elsif rising_edge(i_clk) then
			r_q <= i_d;
		end if;
	end process;
	
	o_q <= r_q;
	
end architecture arch_flip_flop;

