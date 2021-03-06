-- VHDL Entity alien_game_lib.c5_t4_display_logic_top_level.symbol
--
-- Created:
--          by - ACER.UNKNOWN (LAPTOP-PGKK1HS3)
--          at - 01:05:07 05/31/2020
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY c5_t4_display_logic_top_level IS
   PORT( 
      clk           : IN     std_logic;
      frame_written : IN     std_logic;
      pixd_in       : IN     std_logic_vector (23 DOWNTO 0);
      rst_n         : IN     std_logic;
      write         : IN     std_logic;
      xw            : IN     std_logic_vector (7  DOWNTO 0);
      yw            : IN     std_logic_vector (7  DOWNTO 0);
      channel       : OUT    std_logic_vector (7 DOWNTO 0);
      lat           : OUT    std_logic;
      s_clk         : OUT    std_logic;
      s_rst         : OUT    std_logic;
      s_sda         : OUT    std_logic;
      sb            : OUT    std_logic;
      w_rdy         : OUT    std_logic
   );

-- Declarations

END c5_t4_display_logic_top_level ;

--
-- VHDL Architecture alien_game_lib.c5_t4_display_logic_top_level.struct
--
-- Created:
--          by - ACER.UNKNOWN (LAPTOP-PGKK1HS3)
--          at - 01:05:07 05/31/2020
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY alien_game_lib;

ARCHITECTURE struct OF c5_t4_display_logic_top_level IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL bit_out    : std_logic;
   SIGNAL bit_out1   : std_logic;
   SIGNAL done       : std_logic;
   SIGNAL dout       : std_logic;
   SIGNAL dout1      : std_logic;
   SIGNAL dout2      : std_logic;
   SIGNAL dout3      : std_logic;
   SIGNAL pixd_out   : std_logic_vector(23 DOWNTO 0);
   SIGNAL tx         : std_logic;
   SIGNAL tx1        : std_logic;
   SIGNAL x          : std_logic_vector(7 DOWNTO 0);
   SIGNAL y          : std_logic_vector(7 DOWNTO 0);
   SIGNAL zc1f6aeab5 : std_logic;

   -- Implicit buffer signal declarations
   SIGNAL sb_internal : std_logic;


   -- Component Declarations
   COMPONENT reg_bank
   PORT (
      clk      : IN     std_logic;
      pixd_in  : IN     std_logic_vector (23 DOWNTO 0);
      rst_n    : IN     std_logic;
      w_done   : IN     std_logic;
      write    : IN     std_logic;
      xr       : IN     std_logic_vector (7 DOWNTO 0);
      xw       : IN     std_logic_vector (7 DOWNTO 0);
      yr       : IN     std_logic_vector (7 DOWNTO 0);
      yw       : IN     std_logic_vector (7 DOWNTO 0);
      pixd_out : OUT    std_logic_vector (23 DOWNTO 0);
      w_rdy    : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT serial_led_cannon
   PORT (
      clk     : IN     std_logic;
      pixdata : IN     std_logic_vector (23 DOWNTO 0);
      rst_n   : IN     std_logic;
      run     : IN     std_logic;
      bit_out : OUT    std_logic;
      chans   : OUT    std_logic_vector (7 DOWNTO 0);
      lat     : OUT    std_logic;
      tx      : OUT    std_logic;
      x       : OUT    std_logic_vector (7 DOWNTO 0);
      y       : OUT    std_logic_vector (7 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT v2_gamma
   PORT (
      clk     : IN     std_logic;
      rst_n   : IN     std_logic;
      run     : IN     std_logic;
      bit_out : OUT    std_logic;
      sb      : OUT    std_logic;
      tx      : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT v2_rst
   PORT (
      clk   : IN     std_logic;
      rst_n : IN     std_logic;
      done  : OUT    std_logic;
      s_rst : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT v2_serial_tx
   PORT (
      bit_in     : IN     std_logic;
      clk        : IN     std_logic;
      rst_n      : IN     std_logic;
      run        : IN     std_logic;
      s_clk      : OUT    std_logic;
      s_sda      : OUT    std_logic;
      zc1f6aeab5 : OUT    std_logic
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : reg_bank USE ENTITY alien_game_lib.reg_bank;
   FOR ALL : serial_led_cannon USE ENTITY alien_game_lib.serial_led_cannon;
   FOR ALL : v2_gamma USE ENTITY alien_game_lib.v2_gamma;
   FOR ALL : v2_rst USE ENTITY alien_game_lib.v2_rst;
   FOR ALL : v2_serial_tx USE ENTITY alien_game_lib.v2_serial_tx;
   -- pragma synthesis_on


BEGIN

   -- ModuleWare code(v1.12) for instance 'U_5' of 'and'
   dout <= done AND zc1f6aeab5;

   -- ModuleWare code(v1.12) for instance 'U_6' of 'and'
   dout3 <= sb_internal AND zc1f6aeab5;

   -- ModuleWare code(v1.12) for instance 'U_8' of 'mux'
   u_8combo_proc: PROCESS(bit_out, bit_out1, sb_internal)
   BEGIN
      CASE sb_internal IS
      WHEN '0' => dout2 <= bit_out;
      WHEN '1' => dout2 <= bit_out1;
      WHEN OTHERS => dout2 <= 'X';
      END CASE;
   END PROCESS u_8combo_proc;

   -- ModuleWare code(v1.12) for instance 'U_7' of 'or'
   dout1 <= tx OR tx1;

   -- Instance port mappings.
   U_4 : reg_bank
      PORT MAP (
         clk      => clk,
         pixd_in  => pixd_in,
         rst_n    => rst_n,
         w_done   => frame_written,
         write    => write,
         xr       => x,
         xw       => xw,
         yr       => y,
         yw       => yw,
         pixd_out => pixd_out,
         w_rdy    => w_rdy
      );
   U_3 : serial_led_cannon
      PORT MAP (
         clk     => clk,
         pixdata => pixd_out,
         rst_n   => rst_n,
         run     => dout3,
         bit_out => bit_out1,
         chans   => channel,
         lat     => lat,
         tx      => tx1,
         x       => x,
         y       => y
      );
   U_1 : v2_gamma
      PORT MAP (
         clk     => clk,
         rst_n   => rst_n,
         run     => dout,
         bit_out => bit_out,
         sb      => sb_internal,
         tx      => tx
      );
   U_0 : v2_rst
      PORT MAP (
         clk   => clk,
         rst_n => rst_n,
         done  => done,
         s_rst => s_rst
      );
   U_2 : v2_serial_tx
      PORT MAP (
         bit_in     => dout2,
         clk        => clk,
         rst_n      => rst_n,
         run        => dout1,
         zc1f6aeab5 => zc1f6aeab5,
         s_clk      => s_clk,
         s_sda      => s_sda
      );

   -- Implicit buffered output assignments
   sb <= sb_internal;

END struct;
