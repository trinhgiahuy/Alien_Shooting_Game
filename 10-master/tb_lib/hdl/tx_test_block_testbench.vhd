--
-- VHDL Architecture tb_lib.tx_test_block.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 15:06:48 31.05.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tx_test_block IS
-- Declarations
port(
  clk : out std_logic;
  rst_n : out std_logic;
  done : in std_logic;
  correct : in std_logic
  
);
END tx_test_block ;

--
ARCHITECTURE testbench OF tx_test_block IS
  
	constant clk_period : time := 20 ns;

	signal clk_tb : std_logic :='0';
	signal rst_n_tb : std_logic:='0';

BEGIN
  --port assignemnts
  clk<= clk_tb;
  rst_n <= rst_n_tb;
  
    
  --internal signals
 	clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 2*clk_period;
	
	asserting_proc : process (done,correct)
	begin --asserting_proc
  	if done ='1' then
  	 assert correct='0' 
  	 report "Simulation successful!"
  	 severity failure;
  	 
  	 assert correct='1' report "Simulation completed with errors!" severity failure;
  	end if;
	end process;
	 
	 
	timed_simulation : process
	begin --timed proc
	  wait for 10000 ns;
	  assert false report "simulation timed out!" severity failure;  
	end process;
END ARCHITECTURE testbench;

