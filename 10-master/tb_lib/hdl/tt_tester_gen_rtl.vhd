--
-- VHDL Architecture tb_lib.tt_tester_gen.rtl
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 15:36:54 12.06.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY tt_tester_gen IS
   PORT( 
      res     : IN     std_logic_vector (7 DOWNTO 0);
      to_duv  : OUT    std_logic_vector (2 DOWNTO 0);
      correct : OUT    std_logic;
      ref_res : IN     std_logic_vector (7 DOWNTO 0)
   );

-- Declarations

END tt_tester_gen ;

--
ARCHITECTURE rtl OF tt_tester_gen IS

	constant clk_period : time := 20 ns;
	
	signal clk_tb : std_logic:='0';
	signal rst_n_tb : std_logic:='0';
	
	signal correct_tb : std_logic:='0'; 

  signal cntr : integer :=0;

begin --rtl

  
  rst_n_tb <= '1' after clk_period*2;
  clk_tb <= not clk_tb after clk_period/2;
  correct <= correct_tb;
  
  clocked_simu : process (clk_tb, rst_n_tb)
  begin --clocked_simu
    if(rst_n_tb='0') then
      to_duv<="000";
      correct_tb<='1';
      cntr <= 0;
    elsif(clk_tb'event and clk_tb ='1') then
      if(cntr=7) then
        cntr<=0;
      else
        cntr <= cntr +1;
      end if;
      
      if(res = ref_res) then
        correct_tb <='1';
      else
        correct_tb <='0';
      end if;
      
      to_duv <=std_logic_vector(to_unsigned(cntr,3));
      
    end if;
  end process;

	corr_proc : process(correct_tb, rst_n_tb)
	begin -- corr_proc
   if(rst_n_tb ='1') then
    assert correct_tb='1' report "Error in the design!"
    severity failure;
   end if;
	  
	end process;


  
	timing : process
	begin -- timing
    
	  wait for 375 ns;
	  assert false report "Simulation successful!" severity failure;
	  
	end process;

END ARCHITECTURE rtl;

