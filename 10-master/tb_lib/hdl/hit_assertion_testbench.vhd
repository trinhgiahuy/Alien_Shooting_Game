--
-- VHDL Architecture tb_lib.hit_assertion.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 14:44:37  7.10.2019
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY hit_assertion IS
   PORT( 
      clk     : OUT    std_logic;
      rst_n   : OUT    std_logic;
      hit     : IN     std_logic;
      done    : IN     std_logic;
      ref_hit : IN     std_logic
   );

-- Declarations

END hit_assertion ;

--
ARCHITECTURE testbench OF hit_assertion IS
 	constant clk_period : time := 20 ns;

	signal clk_tb : std_logic :='0';
	signal rst_n_tb : std_logic:='0';
	
	signal hit_counter : integer:=0;

  signal ref_counter : integer:=0;
  
BEGIN
  
  --port assignemnts
  clk<= clk_tb;
  rst_n <= rst_n_tb;
   
  --internal signals
  clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 2*clk_period;
	
	clocked_simulation : process (clk_tb,rst_n_tb)
	begin --clocked_simulation
	  if(rst_n_tb = '0') then
	     hit_counter <= 0;
	     ref_counter <= 0;
	  elsif (clk_tb'event and clk_tb ='1') then
	    
	   if (ref_hit='1') then
	     ref_counter <= ref_counter	+1;     
	   end if;
	   
	   if (hit='1') then 
	     hit_counter <= hit_counter +1;
	   end if;
	   
	   if(done ='1') then --end condition
	     if (hit_counter = ref_counter) then
	       assert false
	       report "Simulation successful!!"
	       severity failure;
	     else
	       assert false report "Simulation ended with errors! False or missed hits during simulation"
	       severity failure;
	     end if;
	   end if;--done
	   
	  end if;--clk event
	 end process;--clocked simulation
	 
	 timed_simulation : process
	 begin 
	   
	   wait for 300000 ns;
	   assert false
	   report "Simulation timed out!"
	   severity failure;
	   
	 end process;

END ARCHITECTURE testbench;

