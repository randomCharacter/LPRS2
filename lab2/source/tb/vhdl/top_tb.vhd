-------------------------------------------------------------------------------
--  Department of Computer Engineering and Communications
--  Author: LPRS2  <lprs2@rt-rk.com>
--
--  Module Name: top_tb
--
--  Description:
--    
--    TB for top
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity top_tb is
end top_tb;

architecture behavior of top_tb is 

  -- component Declaration
  component top
  generic (
    RES_TYPE             : natural := 0;
    TEXT_MEM_DATA_WIDTH  : natural := 6;
    GRAPH_MEM_DATA_WIDTH : natural := 32
    );
  port (
    clk_i          : in  std_logic;
    reset_n_i      : in  std_logic;
    --
    direct_mode_i  : in  std_logic;
    display_mode_i : in  std_logic_vector(1 downto 0);
    -- vga
    vga_hsync_o    : out std_logic;
    vga_vsync_o    : out std_logic;
    blank_o        : out std_logic;
    pix_clock_o    : out std_logic;
    psave_o        : out std_logic;
    sync_o         : out std_logic;
    red_o          : out std_logic_vector(7 downto 0);
    green_o        : out std_logic_vector(7 downto 0);
    blue_o         : out std_logic_vector(7 downto 0)
   );
  end component;

  signal clk     : std_logic;
  signal reset_n : std_logic;

begin

  clk_gen : process
  begin
    clk <= '1';
    wait for 41.66 ns;
    clk <= '0';
    wait for 41.66 ns;
  end process clk_gen;
    
  -- component instantiation
  uut: top
  generic map(
    RES_TYPE             => 1,
    TEXT_MEM_DATA_WIDTH  => 6,
    GRAPH_MEM_DATA_WIDTH => 32
  )
  port map(
    clk_i          => clk,
    reset_n_i      => reset_n,
    --
    direct_mode_i  => '0',
    display_mode_i => "10"
  );

  --  test bench statements
  tb : process
  begin
    reset_n <= '0';
    wait for 100 us; -- wait until global set/reset completes
    reset_n <= '1';
    -- add user defined stimulus here

    wait; -- will wait forever
  end process tb;
  --  end test bench 

  end;