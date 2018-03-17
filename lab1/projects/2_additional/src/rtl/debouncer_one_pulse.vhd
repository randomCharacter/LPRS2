----------------------------------------------------------------------------------
--  Odsek za racunarsku tehniku i medjuracunarske komunikacije                  --
--  Copyright © 2008 All Rights Reserved                                        --
----------------------------------------------------------------------------------
--                                                                              --
-- Autor: LPRS2 TIM 2008/2009 <LPRS2@KRT.neobee.net>                            --
--                                                                              --
-- Datum izrade: /                                                              --
-- Naziv Modula: debouncer_one_pulse.vhd                                        --
-- Naziv projekta: LabVezba1                                                    --
--                                                                              --
-- Opis: /                                                                      --
--                                                                              --
-- Ukljucuje module: clk_counter, debounce, onepulse                            --
--                                                                              --
-- Verzija : 1.0                                                                --
--                                                                              --
-- Dodatni komentari: /                                                         --
--                                                                              --
-- ULAZI: pb_i                                                                  --  
--        clk_2MHz_i                                                            --
--        rst_i                                                                 --
--                                                                              --
-- IZLAZI: pb_debounced_o                                                       --
--                                                                              --
-- PARAMETRI : /                                                                --
--                                                                              --
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY debouncer_one_pulse IS PORT (
    pb_i           : IN  STD_LOGIC;
    clk_2MHz_i     : IN  STD_LOGIC;
    rst_i          : IN  STD_LOGIC;
    pb_debounced_o : OUT STD_LOGIC
);
END debouncer_one_pulse;

ARCHITECTURE beh OF debouncer_one_pulse IS

-- instanciranje komponenti
COMPONENT clk_counter IS
GENERIC (
          max_cnt : integer := 2000000
        );
PORT (
      clk_i     : IN  STD_LOGIC;
      rst_i     : IN  STD_LOGIC; --active high
      en_i      : IN  STD_LOGIC;
      one_sec_o : OUT STD_LOGIC
);
END COMPONENT clk_counter;

COMPONENT debounce IS PORT
  (
    pb, clock_100Hz  : IN  STD_LOGIC;
    pb_debounced     : OUT STD_LOGIC);
END COMPONENT debounce;

COMPONENT onepulse IS PORT
  (
    PB_debounced    : IN  STD_LOGIC;
    clock           : IN  STD_LOGIC;
    PB_single_pulse : OUT STD_LOGIC
   );
END COMPONENT onepulse;

-- signali za povezivanje
SIGNAL clk_100Hz_s : STD_LOGIC;
SIGNAL debounced_s : STD_LOGIC;

BEGIN

clk_div_i:clk_counter GENERIC MAP(
                                  max_cnt => "000000100111000100000"   -- 20 000
                                 )
                      PORT MAP  (
                                 clk_i     => clk_2MHz_i  ,
                                 rst_i     => rst_i       ,
                                 en_i      => '1'         ,
                                 one_sec_o => clk_100Hz_s
                                );


debounce_i:debounce PORT MAP (
                               pb           => pb_i        ,
                               clock_100Hz  => clk_100Hz_s ,
                               pb_debounced => debounced_s
                             );

onepulse_i:onepulse PORT MAP (
                              PB_debounced    => debounced_s    ,
                              clock           => clk_100Hz_s    ,
                              PB_single_pulse => pb_debounced_o
                             );

END beh;
