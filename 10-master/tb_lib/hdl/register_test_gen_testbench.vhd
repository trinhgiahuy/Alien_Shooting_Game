--
-- VHDL Architecture tb_lib.register_test_gen.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 13:44:14 23.08.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY register_test_gen IS
   PORT( 
      clk      : OUT    std_logic;
      rst_n    : OUT    std_logic;
      corr     : IN     std_logic;
      simu_end : IN     std_logic
   );

-- Declarations

END register_test_gen ;

--
ARCHITECTURE testbench OF register_test_gen IS
 	constant clk_period : time := 20 ns;

  signal clk_tb : std_logic :='0';
 	signal rst_n_tb : std_logic:='0';
 	

BEGIN
  --port assignments
  clk<= clk_tb;
  rst_n<= rst_n_tb;
  
  --internal generation
 	clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 2*clk_period; 
	
	------------
	corr_proc :process (corr,simu_end)
	begin
	  if (simu_end='1') then
  	  if (corr ='1') then
  	    assert false report "Simulation succesful!"
  	    severity failure;
      else
        assert false report "Simulation ended with errors!" severity failure;
      end if;
    else
      null;
    end if;
  end process;
	
	--------
	simu_time_out : process
	begin
	  wait for 250000 ns;
	  assert false report "Simulation timed out!" severity failure;
  end process;
	--------------
END ARCHITECTURE testbench;

