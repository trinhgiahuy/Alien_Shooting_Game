--
-- VHDL Architecture tb_lib.wr_seq_tester.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 11:29:56 18.09.2019
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY wr_seq_tester IS
   PORT( 
      enable          : IN     std_logic;
      wr_done         : IN     std_logic;
      write           : IN     std_logic;
      clk             : OUT    std_logic;
      rst_n           : OUT    std_logic;
      write_ready     : OUT    std_logic;
      simulation_ends : IN     std_logic
   );

-- Declarations

END wr_seq_tester ;

--
ARCHITECTURE testbench OF wr_seq_tester IS
  
  constant clk_period : time := 20 ns;
  
  signal clk_tb : std_logic :='0';
  signal rst_n_tb : std_logic:='0';
  
  signal cntr : integer:=0;
  
  signal write_ready_tb : std_logic:='0';
  
  signal frame_timer : std_logic:='1';
  
  signal write_done : std_logic:='0';
  signal write_done_old : std_logic:='0';
  
BEGIN
  --port assignemnts
  clk<= clk_tb;
  rst_n <= rst_n_tb;
  
  --internal signals
  clk_tb <= not clk_tb after clk_period/2;
  rst_n_tb <= '1' after 2*clk_period;
  
  write_ready<=write_ready_tb;
  write_done<=wr_done;
  
  asserting_proc : process (clk_tb,rst_n_tb)
  begin
    if(rst_n_tb='0') then
      write_ready_tb<='0';  
      cntr<=0;
      frame_timer<='1';
      write_done_old<='0';
     
    elsif(clk_tb'event and clk_tb='1') then
      if frame_timer<='0' then
        write_done_old<=write_done;
        if(write_done_old='0' and write_done='1') then
          write_ready_tb<='0';
          frame_timer<='1';
          
        end if;
      else
        if cntr=7 then
          cntr<=0;
          frame_timer<='0';
          write_ready_tb<='1';
        else
          cntr<=cntr+1;
        end if;  
      end if;
    end if;
      
    end process;
    
    
    timed_simulation : process 
    begin
      wait for 2000 ns;
      if (simulation_ends='1') then
        
      
        assert false report "Simulation done, inspect wave for details!"
        severity failure;
      end if;
      
    end process;
  END ARCHITECTURE testbench;
  
  
  
