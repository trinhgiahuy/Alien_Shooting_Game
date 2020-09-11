--
-- VHDL Architecture tb_lib.shield_rst_block.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 15:13:07 31.05.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY shield_rst_block IS
-- Declarations
  port(
    clk : out std_logic;
    rst_n : out std_logic;
    s_rst : in std_logic;
    done : in std_logic
  );

END shield_rst_block ;

--
ARCHITECTURE testbench OF shield_rst_block IS
	constant clk_period : time := 20 ns;

	signal clk_tb : std_logic :='0';
	signal rst_n_tb : std_logic:='0';

  signal s_rst_tb : std_logic:='0';
  signal s_rst_old_tb : std_logic:='0';
  
  signal reset_rised : std_logic:='0'; 
  
  signal zero_cycle_count : integer:=0;
  
  signal ready_for_done : std_logic:='0';
  
BEGIN
  --port assignemnts
  clk<= clk_tb;
  rst_n <= rst_n_tb;
   
  --internal signals
  clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 2*clk_period;
	
	simulation :process(clk_tb,rst_n_tb)
	begin--simulation
	  if rst_n_tb = '0' then
  	    --asynce low reset values
  	    s_rst_tb<='1';
  	    ready_for_done<='0';
  	    
  	    zero_cycle_count<=0;
  	    reset_rised<='0';
  	    
 	  elsif (clk_tb'event and clk_tb='1') then
 	    s_rst_tb<=s_rst;
 	    if(s_rst = '0' and reset_rised='0') then
 	      zero_cycle_count<=zero_cycle_count+1;
 	    end if;
 	    
 	    if(s_rst='1' and s_rst_tb='0') then 
 	      s_rst_tb<=s_rst;
 	      s_rst_old_tb<=s_rst_tb;
 	      reset_rised<='1';
 	    end if;
    
      if ((((s_rst='1' and s_rst_tb='0') or reset_rised='1') and zero_cycle_count>=5) and ready_for_done='0') then
        assert false report "Shield reset compeleted!" severity note;
        ready_for_done<='1';
      elsif(reset_rised='1' and ready_for_done='0') then
        assert false report "Error with reset singal duration!" severity failure;
      end if;
      
      if (ready_for_done='0' and done='1') then
        assert false report "Error in the design: Ready signal needs to be raised after reset!!"
        severity failure;
      end if;--failure completion
      
      if (ready_for_done='1' and done='1') then
        assert false report "Simulation successful! Shield reset and done signal *done*!!"
        severity failure;
      end if;--success condition
    end if;--clocked proc
  end process;
  
  timed_simulation:process
  begin --timed
    wait for 15000 ns;
    assert false report "Simulation timed out!" severity failure;
  end process;
  	 
END ARCHITECTURE testbench;

