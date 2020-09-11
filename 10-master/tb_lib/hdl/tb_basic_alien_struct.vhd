-- VHDL Entity tb_lib.tb_basic_alien.symbol
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 15:04:21 08/16/18
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY tb_basic_alien IS
-- Declarations

END tb_basic_alien ;

--
-- VHDL Architecture tb_lib.tb_basic_alien.struct
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 13:45:22 08/21/18
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY tb_lib;

ARCHITECTURE struct OF tb_basic_alien IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL clk               : std_logic;
   SIGNAL correct           : std_logic;
   SIGNAL duv_color_out     : std_logic_vector(23 DOWNTO 0);
   SIGNAL duv_x_out         : std_logic_vector(7 DOWNTO 0);
   SIGNAL duv_y_out         : std_logic_vector(7 DOWNTO 0);
   SIGNAL en                : std_logic;
   SIGNAL hit               : std_logic;
   SIGNAL rst_n             : std_logic;
   SIGNAL student_reset_val : std_logic_vector(2 DOWNTO 0);


   -- Component Declarations
   COMPONENT tester_up_down
   PORT (
      duv_color_out     : IN     std_logic_vector (23 DOWNTO 0);
      duv_x_out         : IN     std_logic_vector (7 DOWNTO 0);
      duv_y_out         : IN     std_logic_vector (7 DOWNTO 0);
      student_reset_val : IN     std_logic_vector (2 DOWNTO 0);
      clk               : OUT    std_logic ;
      correct           : OUT    std_logic ;
      en                : OUT    std_logic ;
      hit               : OUT    std_logic ;
      rst_n             : OUT    std_logic 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : tester_up_down USE ENTITY tb_lib.tester_up_down;
   -- pragma synthesis_on


BEGIN

   -- ModuleWare code(v1.12) for instance 'student_reset_value' of 'constval'
   student_reset_val <= "011";

   -- Instance port mappings.
   U_0 : tester_up_down
      PORT MAP (
         duv_color_out     => duv_color_out,
         duv_x_out         => duv_x_out,
         duv_y_out         => duv_y_out,
         student_reset_val => student_reset_val,
         clk               => clk,
         correct           => correct,
         en                => en,
         hit               => hit,
         rst_n             => rst_n
      );

END struct;
