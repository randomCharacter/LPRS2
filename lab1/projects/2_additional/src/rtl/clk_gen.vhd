-------------------------------------------------------------------------------
--  Odsek za racunarsku tehniku i medjuracunarske komunikacije
--  Autor: LPRS2  <lprs2@rt-rk.com>                                           
--                                                                             
--  Ime modula: clk_gen                                                           
--                                                                             
--  Opis:                                                               
--                                                                             
--    Modul za upravljanje taktom                                            
--                                                                             
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY clk_gen IS PORT (
                        clkin_i       : IN    STD_LOGIC;  -- ulazni takt koji dolazi od ploce (24MHz)
                        rst_i         : IN    STD_LOGIC;  -- reset aktivan na visokom nivou
                        clk_50MHz_o   : OUT   STD_LOGIC;  -- izlazni takt od  2MHz
                        clk_27MHz_o   : OUT   STD_LOGIC;  -- izlazni takt od 24MHz
                        reset_o       : OUT   STD_LOGIC   -- izlazni reset signal, koji je ustvari zakasnjen invertovan locked signal iz dcm-a,
                       );
END clk_gen;

ARCHITECTURE rtl OF clk_gen IS
-- instanciranje komponenti
-------------------------------------------------------------------
-- dcm27_to_50
-------------------------------------------------------------------
COMPONENT dcm27_to_50 is
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic;
  -- Status and control signals
  RESET             : in     std_logic;
  LOCKED            : out    std_logic
 );
end COMPONENT;

-------------------------------------------------------------------
-- SRL16
-------------------------------------------------------------------
COMPONENT SRL16 PORT (
                      A0  : IN  STD_LOGIC;
                      A1  : IN  STD_LOGIC;
                      A2  : IN  STD_LOGIC;
                      A3  : IN  STD_LOGIC;
                      CLK : IN  STD_LOGIC;
                      D   : IN  STD_LOGIC;
                      Q   : OUT STD_LOGIC
                     );
END COMPONENT SRL16;

-------------------------------------------------------------------
-- D FLIP-FLOP
-------------------------------------------------------------------
COMPONENT FD PORT (
                   Q : OUT STD_ULOGIC;
                   C : IN  STD_ULOGIC;
                   D : IN  STD_ULOGIC
                  );
END COMPONENT FD;

-- definisanje signala
SIGNAL clkin_ibufg_s : STD_LOGIC;
SIGNAL locked_s      : STD_LOGIC;
SIGNAL clk_div_s     : STD_LOGIC;
SIGNAL shift_rst_s   : STD_LOGIC;
SIGNAL dff_out_r     : STD_LOGIC;

BEGIN

-- povezivanje komponenti
DMC: dcm27_to_50 PORT MAP (
                CLK_IN1  => clkin_i,
                CLK_OUT1 => clk_div_s,
                RESET    => rst_i,
                LOCKED   => locked_s
                );
                

shift_reg16: SRL16 PORT MAP (
                             A0  => '1'         ,
                             A1  => '1'         ,
                             A2  => '1'         ,
                             A3  => '1'         ,
                             CLK => clk_div_s   ,
                             D   => locked_s    ,
                             Q   => shift_rst_s
                            );

dff: FD PORT MAP (
                  Q => dff_out_r  ,
                  C => clk_div_s  ,
                  D => shift_rst_s
                 );

clk_50MHz_o <= clk_div_s;

reset_o    <= NOT dff_out_r;

END rtl;











