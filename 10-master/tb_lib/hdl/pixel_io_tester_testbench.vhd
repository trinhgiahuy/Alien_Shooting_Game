--
-- VHDL Architecture tb_lib.pixel_io_tester.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 10:35:17  3.07.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY pixel_io_tester IS
   PORT( 
      color : IN     std_logic_vector (23 DOWNTO 0);
      x     : IN     std_logic_vector (7 DOWNTO 0);
      y     : IN     std_logic_vector (7 DOWNTO 0);
      btn   : OUT    std_logic_vector (3 DOWNTO 0);
      sw0   : OUT    std_logic
   );

-- Declarations

END pixel_io_tester ;

--
ARCHITECTURE testbench OF pixel_io_tester IS
 	constant clk_period : time := 20 ns;

	signal clk_tb : std_logic :='0';
	signal rst_n_tb : std_logic:='0';
	
	signal btn_tb : std_logic_vector (3 downto 0):="0000";
	signal btn_tb_old : std_logic_vector (3 downto 0):="0000";
	signal sw0_tb : std_logic:='0';
	signal sw0_tb_old : std_logic:='0';
	
	signal x_old : std_logic_vector (7 downto 0);
	signal y_old : std_logic_vector (7 downto 0);
	signal color_old : std_logic_vector (23 downto 0);
	
	signal btn_counter : integer:=0;
	
	signal done_once :std_logic:='0';
	
	signal changed_0 : std_logic:='0';
	signal no_change_0 : std_logic:='0';

	signal changed : std_logic:='0';
	signal no_change : std_logic:='0';	
	
BEGIN
  
  --internal generation
  clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 2*clk_period;
	
	--output assignments
	btn<=btn_tb;
	sw0<=sw0_tb;
	
	clked_proc : process (rst_n_tb,clk_tb)
	begin--clked_proc
	  if rst_n_tb='0' then -- async reset
	    btn_counter<=0;
	    btn_tb<=(others=>'0');
	    sw0_tb<='0';
	    done_once <='0';
	    x_old<=(others=>'0');
	    y_old<=(others=>'0');
	    color_old<=(others=>'0');
	    changed_0<='0';
	    no_change_0<='0';
	    changed<='0';
	    no_change<='0';
	  elsif(clk_tb'event and clk_tb='1') then--clk'event
	    --old signals to identify changes in them
	    btn_tb_old<=btn_tb;
	    color_old<=color;
	    x_old<=x;
	    y_old<=y;
	    
	    
	    if(sw0_tb='0') then
	      if (btn_tb_old/=btn_tb) then
	        --if theres change in iputs then
	        if(x_old=x and y_old=y) and color=color_old then
           if changed_0<='0' then
	           no_change_0<='1';
	         end if;
	        else
	         changed_0 <='1';
	         no_change_0<='0';
	         
	       end if;
	    end if;
	    
	    else
	    	 if (btn_tb_old/=btn_tb) then
	      --if theres change in iputs then
	      if(x_old=x and y_old=y) and color=color_old then

	        no_change<='1';
	      else
	        changed <='1';
	      end if;
	    end if;
	    end if;
	    
	    if (btn_counter=17 and done_once='1') then--end condition
        btn_tb<=(others=>'0');
        if (changed='1' and no_change_0='1') then
  	      assert false 
  	      report "Simulation successful! C) Task passes simulation!"
  	      severity failure;
 	      elsif(changed='1' and no_change_0='0') then
 	        assert false
 	        report "Simulation passes B) task!"
 	        severity failure;
	      else
	        assert false
	        report "Simulation ended in errors!"
	        severity failure;
	      end if;
	      
	    elsif btn_counter=17 and done_once='0' then--second loop start condition
	      btn_tb<=(others=>'0');
	      btn_counter<=0;
	      done_once<='1';
	      sw0_tb<='1';--flip the switch signal
	    elsif btn_counter=16 then --avoiding truncation
	      btn_tb<=(others=>'0');
	      btn_counter<=btn_counter+1;
	    else--counter for looping
	      btn_tb<=std_logic_vector(to_unsigned(btn_counter,4));
	      btn_counter<=btn_counter+1;
	    end if;--counter if
	      
	  end if;--clk'event
	end process;--clked_proc
	
	timed_simulation :process
	begin--timed simulation
	  wait for 1500 ns;
	  assert false report "Simulation timed out!" severity failure;
	end process;
  
END ARCHITECTURE testbench;

