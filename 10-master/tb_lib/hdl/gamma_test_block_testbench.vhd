--
-- VHDL Architecture tb_lib.gamma_test_block.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 16:10:03  4.06.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY gamma_test_block IS
-- Declarations
  port(
    clk     : out std_logic;
    rst_n   : out std_logic;
    sb      : in  std_logic;
    reg_set : in  std_logic_vector (5 downto 0)
    );

END gamma_test_block ;

--
ARCHITECTURE testbench OF gamma_test_block IS
 	constant clk_period : time := 20 ns;

	signal clk_tb : std_logic :='0';
	signal rst_n_tb : std_logic:='0';

  signal end_counter : integer :=0;

BEGIN
  --port assignemnts
  clk<= clk_tb;
  rst_n <= rst_n_tb;
   
    
  --internal signals
  clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 2*clk_period;
	
	
	
	
----------------------------------------------------------------------
	clocked_proc : process(clk_tb,rst_n_tb)
	begin--clocked_proc
	  if(rst_n_tb ='0') then
	    end_counter <= 0;
	  elsif(clk_tb'event and clk_tb='1') then
	    if(sb='1') then
	      if end_counter =5 then
	       assert (to_integer(signed(reg_set))/=24) 
	       report "Simulation successful! All gamma registers set, check their values from the simulation."
	       severity failure;
	       
	       assert false report "Simulation completed with errors!"
	       severity failure;
	       
	      else
	        end_counter <= end_counter +1;
	      end if;
      end if;--sb
      	    
	  end if;--clk'event

	end process;--clocked_proc
	
----------------------------------------------------------------------	
	
	
	timed_simulation: process
	begin --timed
	  wait for 75000 ns;
	  
	  assert false
	  report "Simulation timed out!"
	  severity failure;
	  
	end process;

END ARCHITECTURE testbench;

