--
-- VHDL Architecture tb_lib.crementer_tester.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 14:21:42  8.08.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
--
-- VHDL Architecture tb_lib.incrementer_tester.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 13:54:47  5.06.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;

ENTITY crementer_tester IS
   PORT( 
      reference_res : IN     std_logic_vector (2 DOWNTO 0);
      to_duv        : OUT    std_logic_vector (2 Downto 0);
      correct       : OUT    std_logic;
      res           : IN     std_logic_vector (2 DOWNTO 0)
   );

-- Declarations

END crementer_tester ;

--
ARCHITECTURE testbench OF crementer_tester IS

	constant clk_period : time := 20 ns;
	
	signal clk_tb : std_logic:='0';
	signal rst_n_tb : std_logic:='0';
	
	signal res_tb : std_logic_vector(2 downto 0):="000";
	
	signal correct_tb : std_logic:='0'; 
	signal error_counter : integer:=0;

begin


  rst_n_tb <= '1' after clk_period*2;
  clk_tb <= not clk_tb after clk_period/2;

  to_duv <= res_tb;
  correct <= correct_tb;
  

  clocked_simulation : process (clk_tb, rst_n_tb)
  begin --clocked_simu
    if(rst_n_tb='0') then
        res_tb<="000";
        correct_tb<='0';
    elsif(clk_tb'event and clk_tb ='1') then
      res_tb<=res;
      if (res = reference_res) then
        correct_tb <= '1';
      else 
        correct_tb <='0';
        error_counter <=error_counter +1;
        assert false report "Error in the design!" severity error; --error
        
      end if;
    end if;
  end process;--clocked_simulation
--------------------------------------------------------------------------------
	simulation_timer : process
	begin -- simulation

	  wait for 700 ns;
	  
	  if (error_counter = 0) then
	    assert false report "Simulation successful!"
	    severity failure;
	  else
	   assert false report "Simulation  completed with errors!" 
	   severity failure;
	  end if;
	  
	end process; --simulation timer
END ARCHITECTURE testbench;

