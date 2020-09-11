--
-- VHDL Architecture tb_lib.reg_ctrl_gen.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 11:41:27 24.08.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY reg_ctrl_gen IS
   PORT( 
      corr     : IN     std_logic;
      simu_end : IN     std_logic;
      clk      : OUT    std_logic;
      rst_n    : OUT    std_logic;
      gathered_chans : in std_logic_vector;
      lat_count : in std_logic_vector (6 downto 0)
   );

-- Declarations

END reg_ctrl_gen ;

--
ARCHITECTURE testbench OF reg_ctrl_gen IS
  --const values needed
 	constant clk_period : time := 20 ns;
 	constant expected_lats : integer := 8;

  --internal signals
  signal clk_tb : std_logic :='0';
 	signal rst_n_tb : std_logic:='0';
BEGIN
   --port assignments
  clk<= clk_tb;
  rst_n<= rst_n_tb;
  
  --internal generation
 	clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 2*clk_period; 
	
	
	--end proc
	--end condition: simu_end ='1'. Assertions based on event gathering.
	end_proc :process
	begin 
	  wait for 20 ns;
	  if (((corr='1' and simu_end='1') and gathered_chans="11111111") 
	      and expected_lats=to_integer(unsigned(lat_count))) then
	    assert false 
	    report "Simulation successful!" 
	    severity failure;
	    
	  elsif ((corr='1' and simu_end='1') 
	         and expected_lats=to_integer(unsigned(lat_count))) then
	    assert false 
	    report "Simulation completed without all channels triggering!" 
	    severity failure;
	    
	  elsif ((corr='1' and simu_end='1') and gathered_chans="11111111") then
	    assert false 
	    report "Simulation completed without incorrect number of lat triggers!" 
	    severity failure;
	    
    elsif (corr='0' and simu_end='1') then
      assert false 
      report "Simulation completed with data transmit errors!" 
      severity failure;
    else
      --avoid doing anything if simu_end is '0'.
      null;
    end if; 	
	end process;
	
	----------------------
	--timeout proc
	timed_simu : process
	begin
	  wait for 10000000 ns;
	  assert false report "Simulation Timed Out!" severity failure;
  end process;
  ------------
END ARCHITECTURE testbench;