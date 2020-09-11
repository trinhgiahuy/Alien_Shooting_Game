--
-- VHDL Architecture tb_lib.debounce_tester.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 13:49:05 27.07.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
-- Adapted from dls_17.tb_sync_debounce.tb_sync_debounce
-- Created:
--          by - alhonena.UNKNOWN (BUMMALO)
--          at - 15:39:24 23.07.2008
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY debounce_tester IS
   PORT( 
      button_from_duv : IN     std_logic;
      button_to_DUV   : OUT    std_logic;
      clk             : OUT    std_logic;
      rst_n           : OUT    std_logic
   );

-- Declarations

END debounce_tester ;

--
ARCHITECTURE testbench OF debounce_tester IS
  
  signal clk_tb : std_logic := '0';
  signal rst_n_tb : std_logic := '0';
  
  constant clock_period_c : time := 20 ns;
  
  constant varahtelykesto_c : integer := 5000;
  constant painalluskesto_c : integer := 50000;
  signal laskuri_r : integer;
  type state_type is (odotus, painallus, loppuvarahtely);
  signal state_r : state_type;
  signal kavi_ylhaalla_r : std_logic;
  
  signal lahto_r : std_logic;
  
begin  -- testbench
  
  -- kellon ja resetin generointi
  clk_tb <= not clk_tb after clock_period_c/2;
  rst_n_tb <= '1' after clock_period_c*3;
  clk <= clk_tb;
  rst_n <= rst_n_tb;
  
  
  button_to_DUV <= lahto_r;
  
  tbproc: process (clk_tb, rst_n_tb)
  begin
    if rst_n_tb = '0' then       -- reset
      state_r <= odotus;
      kavi_ylhaalla_r <= '0';
      laskuri_r <= 0;
      lahto_r <= '0';
      
    elsif clk_tb'event and clk_tb = '1' then
      case state_r is
        when odotus => 
          if laskuri_r = varahtelykesto_c then
            state_r <= painallus;
            laskuri_r <= 0;
          else
            laskuri_r <= laskuri_r + 1;
            assert button_from_DUV = '0' 
            report "Your debouncer does not work: pulse or metavalue ('X','U','Z') detected with no button pressed." 
            severity failure;
          end if;
        when painallus => 
          if laskuri_r = varahtelykesto_c + painalluskesto_c then
            assert kavi_ylhaalla_r = '1' report "Your debouncer does not work: no pulse." severity failure;
            state_r <= loppuvarahtely;
            laskuri_r <= 0;
          else
            laskuri_r <= laskuri_r + 1;
            if laskuri_r < varahtelykesto_c then
              lahto_r <= not lahto_r; -- varahtelya
            else
              lahto_r <= '1'; -- vakaata painallusta loppuaika
            end if;
                           
            if button_from_DUV = '1' then
              if kavi_ylhaalla_r = '0' then
                kavi_ylhaalla_r <= '1';
              else
                assert false report "Your debouncer does not work: more than one pulse." severity failure;
              end if;
            end if;
          end if;
       when loppuvarahtely =>
         if laskuri_r = varahtelykesto_c then
           assert false report "Simulation successful!" severity failure;
         else
           laskuri_r <= laskuri_r + 1;
           lahto_r <= not lahto_r;
           assert button_from_DUV = '0' report "Your debouncer does not work: more than one pulse." severity failure;
         end if;                          
                            
      end case;
      
    end if;
  end process tbproc;

END ARCHITECTURE testbench;