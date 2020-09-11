-- VHDL Entity tb_lib.adv_test_case.symbol
--
-- Created:
--          by - kayra.UNKNOWN (LAPTOP-PGKK1HS3)
--          at - 16:02:51 10/07/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY adv_test_case IS
   PORT( 
      clk         : IN     std_logic;
      rst_n       : IN     std_logic;
      alien_x_adv : OUT    std_logic_vector (7 DOWNTO 0);
      alien_y     : OUT    std_logic_vector (7 DOWNTO 0);
      bullet_x    : OUT    std_logic_vector (7 DOWNTO 0);
      bullet_y    : OUT    std_logic_vector (7 DOWNTO 0);
      done_adv    : OUT    std_logic;
      ref_adv     : OUT    std_logic
   );

-- Declarations

END adv_test_case ;

--
-- VHDL Architecture tb_lib.adv_test_case.fsm
--
-- Created:
--          by - kayra.UNKNOWN (LAPTOP-PGKK1HS3)
--          at - 16:02:51 10/07/19
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2019.3 (Build 4)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
 
ARCHITECTURE fsm OF adv_test_case IS

   -- Architecture Declarations
   SIGNAL ref_hit_done : std_logic;  

   TYPE STATE_TYPE IS (
      all_tested,
      do_hit,
      end_timer,
      test,
      var_alien_x,
      start_wait,
      var_b_x,
      reset,
      var_b_y,
      var_alien_y
   );
 
   -- Declare current and next state signals
   SIGNAL current_state : STATE_TYPE;
   SIGNAL next_state : STATE_TYPE;

   -- Declare Wait State internal signals
   SIGNAL csm_timer : std_logic_vector(4 DOWNTO 0);
   SIGNAL csm_next_timer : std_logic_vector(4 DOWNTO 0);
   SIGNAL csm_timeout : std_logic;
   SIGNAL csm_to_end_timer : std_logic;
   SIGNAL csm_to_start_wait : std_logic;

   -- Declare any pre-registered internal signals
   SIGNAL alien_x_adv_cld : std_logic_vector (7 DOWNTO 0);
   SIGNAL alien_y_cld : std_logic_vector (7 DOWNTO 0);
   SIGNAL bullet_x_cld : std_logic_vector (7 DOWNTO 0);
   SIGNAL bullet_y_cld : std_logic_vector (7 DOWNTO 0);
   SIGNAL done_adv_cld : std_logic ;
   SIGNAL ref_adv_cld : std_logic ;

BEGIN

   -----------------------------------------------------------------
   clocked_proc : PROCESS ( 
      clk,
      rst_n
   )
   -----------------------------------------------------------------
   BEGIN
      IF (rst_n = '0') THEN
         current_state <= reset;
         csm_timer <= (OTHERS => '0');
         -- Default Reset Values
         alien_x_adv_cld <= "00100000";
         alien_y_cld <= "00010000";
         bullet_x_cld <= "00001000";
         bullet_y_cld <= "00000100";
         done_adv_cld <= '0';
         ref_adv_cld <= '0';
         ref_hit_done <= '0';
      ELSIF (clk'EVENT AND clk = '1') THEN
         current_state <= next_state;
         csm_timer <= csm_next_timer;

         -- Combined Actions
         CASE current_state IS
            WHEN all_tested => 
               done_adv_cld <='1';
            WHEN do_hit => 
               ref_hit_done<='1';
               ref_adv_cld<='1';
            WHEN test => 
               ref_adv_cld<='0';
            WHEN var_alien_x => 
               bullet_x_cld <="00000001";
               alien_x_adv_cld<=alien_x_adv_cld(6 downto 0) & '0';
               ref_hit_done<='0';
            WHEN start_wait => 
               IF (csm_timeout = '1') THEN 
                  alien_x_adv_cld<="00000001";
                  alien_y_cld<="00000001";
                  bullet_x_cld<="00000001";
                  bullet_y_cld<="00000001";
               END IF;
            WHEN var_b_x => 
               bullet_x_cld<=bullet_x_cld(6 downto 0) & '0';
               ref_hit_done<='0';
            WHEN var_b_y => 
               bullet_x_cld<="00000001";
               alien_x_adv_cld<="00000001";
               bullet_y_cld<=bullet_y_cld(6 downto 0) & '0';
               ref_hit_done<='0';
            WHEN var_alien_y => 
               bullet_x_cld<="00000001";
               alien_x_adv_cld<="00000001";
               bullet_y_cld<="00000001";
               alien_y_cld<=alien_y_cld(6 downto 0) & '0';
               ref_hit_done<='0';
            WHEN OTHERS =>
               NULL;
         END CASE;
      END IF;
   END PROCESS clocked_proc;
 
   -----------------------------------------------------------------
   nextstate_proc : PROCESS ( 
      alien_x_adv_cld,
      alien_y_cld,
      bullet_x_cld,
      bullet_y_cld,
      csm_timeout,
      current_state,
      ref_hit_done
   )
   -----------------------------------------------------------------
   BEGIN
      -- Default assignments to Wait State entry flags
      csm_to_end_timer <= '0';
      csm_to_start_wait <= '0';
      CASE current_state IS
         WHEN all_tested => 
            next_state <= all_tested;
         WHEN do_hit => 
            next_state <= test;
         WHEN end_timer => 
            IF (csm_timeout = '1') THEN 
               next_state <= all_tested;
            ELSE
               next_state <= end_timer;
            END IF;
         WHEN test => 
            IF (alien_x_adv_cld/="00000000" and 
                alien_x_adv_cld=bullet_x_cld and
                alien_y_cld/="00000000" and
                alien_y_cld=bullet_y_cld and
                ref_hit_done='0') THEN 
               next_state <= do_hit;
            ELSIF (alien_y_cld="00000000") THEN 
               next_state <= end_timer;
               csm_to_end_timer <= '1';
            ELSIF (bullet_y_cld="00000000") THEN 
               next_state <= var_alien_y;
            ELSIF (alien_x_adv_cld="00000000") THEN 
               next_state <= var_b_y;
            ELSIF (bullet_x_cld="00000000") THEN 
               next_state <= var_alien_x;
            ELSE
               next_state <= var_b_x;
            END IF;
         WHEN var_alien_x => 
            next_state <= test;
         WHEN start_wait => 
            IF (csm_timeout = '1') THEN 
               next_state <= test;
            ELSE
               next_state <= start_wait;
            END IF;
         WHEN var_b_x => 
            next_state <= test;
         WHEN reset => 
            next_state <= start_wait;
            csm_to_start_wait <= '1';
         WHEN var_b_y => 
            next_state <= test;
         WHEN var_alien_y => 
            next_state <= test;
         WHEN OTHERS =>
            next_state <= reset;
      END CASE;
   END PROCESS nextstate_proc;
 
   -----------------------------------------------------------------
   csm_wait_combo_proc: PROCESS (
      csm_timer,
      csm_to_end_timer,
      csm_to_start_wait
   )
   -----------------------------------------------------------------
   VARIABLE csm_temp_timeout : std_logic;
   BEGIN
      IF (unsigned(csm_timer) = 0) THEN
         csm_temp_timeout := '1';
      ELSE
         csm_temp_timeout := '0';
      END IF;

      IF (csm_to_end_timer = '1') THEN
         csm_next_timer <= "10011"; -- no cycles(20)-1=19
      ELSIF (csm_to_start_wait = '1') THEN
         csm_next_timer <= "00010"; -- no cycles(3)-1=2
      ELSE
         IF (csm_temp_timeout = '1') THEN
            csm_next_timer <= (OTHERS=>'0');
         ELSE
            csm_next_timer <= unsigned(csm_timer) - '1';
         END IF;
      END IF;
      csm_timeout <= csm_temp_timeout;
   END PROCESS csm_wait_combo_proc;

   -- Concurrent Statements
   -- Clocked output assignments
   alien_x_adv <= alien_x_adv_cld;
   alien_y <= alien_y_cld;
   bullet_x <= bullet_x_cld;
   bullet_y <= bullet_y_cld;
   done_adv <= done_adv_cld;
   ref_adv <= ref_adv_cld;
END fsm;