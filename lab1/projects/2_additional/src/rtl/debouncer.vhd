----------------------------------------------------------------------------------
--  Odsek za racunarsku tehniku i medjuracunarske komunikacije                  --
--  Copyright © 2009 All Rights Reserved                                        --
----------------------------------------------------------------------------------
--                                                                              --
-- Autor: LPRS2 TIM 2009/2010 <LPRS2@KRT.neobee.net>                            --
--                                                                              --
-- Datum izrade: /                                                              --
-- Naziv Modula: debouncer.vhd                                                  --
-- Naziv projekta: LabVezba1                                                    --
--                                                                              --
-- Opis: /                                                                      --
--                                                                              --
-- Ukljucuje module: onepulse, debounce                                         --
--                                                                              --
-- Verzija : 1.0                                                                --
--                                                                              --
-- Dodatni komentari: /                                                         --
--                                                                              --
-- ULAZI: pb_i                                                                  --     
--        clk_100Hz_i                                                           --
--        rst_i                                                                 --
--                                                                              --
-- IZLAZI: pb_debounced_o                                                       --
--         pb_debounced_one_pulse_o                                             --
--                                                                              --
-- PARAMETRI :  one_pulse - da li da bude ukljucen modul za jedan puls          --
--                                                                              --
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY debouncer IS GENERIC(
                            one_pulse : STD_LOGIC := '0'
                           );
                     PORT (
                            pb_i                     : IN  STD_LOGIC;
                            clk_100Hz_i              : IN  STD_LOGIC;
                            rst_i                    : IN  STD_LOGIC;
                            pb_debounced_o           : OUT STD_LOGIC;
                            pb_debounced_one_pulse_o : OUT STD_LOGIC
                          );
END debouncer;

ARCHITECTURE rtl OF debouncer IS
-- instanciranje komponenti
COMPONENT onepulse IS PORT
  (
    PB_debounced, clock  : IN  STD_LOGIC;
    PB_single_pulse      : OUT STD_LOGIC
  );
END COMPONENT onepulse;


COMPONENT debounce IS PORT
  (
    pb, clock_100Hz  : IN  STD_LOGIC;
    pb_debounced     : OUT STD_LOGIC);
END COMPONENT debounce;

-- signali za povezivanje
SIGNAL db_pulse_s : STD_LOGIC; -- SIGNAL koji predstavlja pritisnut taster

BEGIN

g1:IF one_pulse = '1' GENERATE
  onepulse_i:onepulse PORT MAP(
                               clock           => clk_100Hz_i              ,
                               PB_debounced    => db_pulse_s               ,
                               PB_single_pulse => pb_debounced_one_pulse_o
                              );
END GENERATE g1;

debounce_i: debounce PORT MAP(
                              pb           => pb_i        ,
                              clock_100Hz  => clk_100Hz_i ,
                              pb_debounced => db_pulse_s
                             );

pb_debounced_o <= db_pulse_s;

END rtl;