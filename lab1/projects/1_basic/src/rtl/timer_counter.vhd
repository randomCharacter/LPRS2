-------------------------------------------------------------------------------
--  Odsek za racunarsku tehniku i medjuracunarske komunikacije
--  Autor: LPRS2  <lprs2@rt-rk.com>                                           
--                                                                             
--  Ime modula: timer_counter                                                           
--                                                                             
--  Opis:                                                               
--                                                                             
--    Modul broji sekunde i prikazuje na LED diodama                                         
--                                                                             
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY timer_counter IS PORT (
                               clk_i     : IN STD_LOGIC; -- ulazni takt
                               rst_i     : IN STD_LOGIC; -- reset signal 
                               one_sec_i : IN STD_LOGIC; -- signal koji predstavlja proteklu jednu sekundu vremena 
                               cnt_en_i  : IN STD_LOGIC; -- signal dozvole brojanja                              
                               cnt_rst_i : IN STD_LOGIC; -- signal resetovanja brojaca (clear signal)
                               led_o     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- izlaz ka led diodama
                             );
END timer_counter;

ARCHITECTURE rtl OF timer_counter IS
SIGNAL counter_value_r : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

-- DODATI :
-- brojac koji na osnovu izbrojanih sekundi pravi izlaz na LE diode

	process(rst_i,clk_i)begin
		if(rst_i = '1')then
			counter_value_r <= "00000000";
		elsif(clk_i'event and clk_i='1')then
			if(cnt_rst_i='1')then
				counter_value_r <= "00000000";
			elsif(cnt_en_i = '1')then
				if(one_sec_i = '1')then
					counter_value_r <= counter_value_r + 1;
				else
					counter_value_r <= counter_value_r;		
				end if;		
			else
				counter_value_r <= counter_value_r;
			end if;	
		end if;
	end process;

	led_o <= counter_value_r;
	
END rtl;