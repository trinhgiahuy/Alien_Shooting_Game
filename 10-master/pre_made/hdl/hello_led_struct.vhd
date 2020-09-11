-- VHDL Entity pre_made.HELLO_LED.symbol
--
-- Created:
--          by - ACER.UNKNOWN (LAPTOP-PGKK1HS3)
--          at - 15:38:30 02/15/2020
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY HELLO_LED IS
   PORT( 
      btn   : IN     std_logic_vector (3 DOWNTO 0);
      sw0   : IN     std_logic;
      color : OUT    std_logic_vector (23 DOWNTO 0);
      x     : OUT    std_logic_vector (7 DOWNTO 0);
      y     : OUT    std_logic_vector (7 DOWNTO 0)
   );

-- Declarations

END HELLO_LED ;

--
-- VHDL Architecture pre_made.HELLO_LED.struct
--
-- Created:
--          by - ACER.UNKNOWN (LAPTOP-PGKK1HS3)
--          at - 15:38:30 02/15/2020
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY alien_game_lib;

ARCHITECTURE struct OF HELLO_LED IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL color_BGR  : std_logic_vector(23 DOWNTO 0);
   SIGNAL color_BGR1 : std_logic_vector(23 DOWNTO 0);
   SIGNAL x_coord    : std_logic_vector(7 DOWNTO 0);
   SIGNAL x_coord1   : std_logic_vector(7 DOWNTO 0);
   SIGNAL y_coord    : std_logic_vector(7 DOWNTO 0);
   SIGNAL y_coord1   : std_logic_vector(7 DOWNTO 0);


   -- Component Declarations
   COMPONENT constant_value
   PORT (
      color_BGR : OUT    std_logic_vector (23 DOWNTO 0);
      x_coord   : OUT    std_logic_vector (7 DOWNTO 0);
      y_coord   : OUT    std_logic_vector (7 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT user_input
   PORT (
      din       : IN     std_logic_vector (3 DOWNTO 0);
      color_BGR : OUT    std_logic_vector (23 DOWNTO 0);
      x_coord   : OUT    std_logic_vector (7 DOWNTO 0);
      y_coord   : OUT    std_logic_vector (7 DOWNTO 0)
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : constant_value USE ENTITY alien_game_lib.constant_value;
   FOR ALL : user_input USE ENTITY alien_game_lib.user_input;
   -- pragma synthesis_on


BEGIN

   -- ModuleWare code(v1.12) for instance 'U_3' of 'mux'
   u_3combo_proc: PROCESS(x_coord1, x_coord, sw0)
   BEGIN
      CASE sw0 IS
      WHEN '0' => x <= x_coord1;
      WHEN '1' => x <= x_coord;
      WHEN OTHERS => x <= (OTHERS => 'X');
      END CASE;
   END PROCESS u_3combo_proc;

   -- ModuleWare code(v1.12) for instance 'U_4' of 'mux'
   u_4combo_proc: PROCESS(y_coord1, y_coord, sw0)
   BEGIN
      CASE sw0 IS
      WHEN '0' => y <= y_coord1;
      WHEN '1' => y <= y_coord;
      WHEN OTHERS => y <= (OTHERS => 'X');
      END CASE;
   END PROCESS u_4combo_proc;

   -- ModuleWare code(v1.12) for instance 'U_5' of 'mux'
   u_5combo_proc: PROCESS(color_BGR1, color_BGR, sw0)
   BEGIN
      CASE sw0 IS
      WHEN '0' => color <= color_BGR1;
      WHEN '1' => color <= color_BGR;
      WHEN OTHERS => color <= (OTHERS => 'X');
      END CASE;
   END PROCESS u_5combo_proc;

   -- Instance port mappings.
   U_1 : constant_value
      PORT MAP (
         color_BGR => color_BGR1,
         x_coord   => x_coord1,
         y_coord   => y_coord1
      );
   U_2 : user_input
      PORT MAP (
         din       => btn,
         color_BGR => color_BGR,
         x_coord   => x_coord,
         y_coord   => y_coord
      );

END struct;