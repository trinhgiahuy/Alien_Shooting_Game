--
-- VHDL Architecture tb_lib.broken_paddle_tester.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 11:17:34 12.09.2019
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY broken_paddle_tester IS
   PORT( 
      write   : IN     std_logic;
      x_coord : IN     std_logic_vector (7 DOWNTO 0);
      btn     : OUT    std_logic_vector (3 DOWNTO 0);
      clk     : OUT    std_logic;
      rst_n   : OUT    std_logic;
      w_rdy   : OUT    std_logic
   );

-- Declarations

END broken_paddle_tester ;

--
ARCHITECTURE testbench OF broken_paddle_tester IS
    constant clk_period : time := 20 ns;

	signal clk_tb : std_logic :='0';
	signal rst_n_tb : std_logic:='0';
  
  signal btn_tb : std_logic_vector (3 downto 0):=(others=>'0');
  
  signal left_cntr : integer;
  signal right_cntr : integer;
  signal end_cntr : integer;
  
  signal change_cntr : integer;
  
  signal w_rdy_cntr : integer;
  
  signal write_old : std_logic;
  
  signal x_old : std_logic_vector (7 downto 0):=(others=>'0');
  
  signal end_phase : std_logic:='0';
BEGIN
     --port assignemnts
  clk<= clk_tb;
  rst_n <= rst_n_tb;
  
  --
  
  btn<=btn_tb;
  --
    
    
  --internal signals
  clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 2*clk_period;
	
	
		clkd_simulation: process ( clk_tb, rst_n_tb)
	begin
	  if(rst_n_tb='0') then
	    btn_tb<=(others=>'0');
	    left_cntr <= 0;
	    right_cntr <= 0;
	    end_cntr <= 0;
	    x_old<=(others=>'0');
	    change_cntr<=0;
	    end_phase<='0';
	    write_old<='0';
	    w_rdy_cntr<=0;
	  elsif(clk_tb'event and clk_tb='1') then
 	    if (write='0' and write_old='0') then
 	      w_rdy_cntr<=w_rdy_cntr+1;
 	    end if;
	    
	    write_old<=write;
	    x_old<=x_coord;
	    if end_phase='0' then
	    if left_cntr < 67 then 
	      if left_cntr mod 10 = 0 then
	        btn_tb<="1000";
	      else 
	        btn_tb<="0000";
	      end if;
	      left_cntr<=left_cntr+1;
	    else 
	      if right_cntr < 101 then
	        if right_cntr mod 10 = 0 then
	          btn_tb<="0001";
	        else 
	          btn_tb<="0000";
	        end if;
	        right_cntr <= right_cntr+1;
	      else
	         if end_cntr<25 then
	           btn_tb<="1000";
	         elsif end_cntr <30 then
	           btn_tb<="0000";
	         elsif end_cntr < 50 then
	           btn_tb<="1000";
	         elsif end_cntr<100 then
	           btn_tb<="0001";
	         else
	           if change_cntr =13 then
	             assert false report "Paddle seems to be moving correctly!" severity error;
	             end_phase <= '1';
	           else
	             assert false report "Errors with paddle movement!" severity error;
	             end_phase<='1';
	           end if;
	           if w_rdy_cntr=0 then
	             
	           end if;
	         end if;
	         end_cntr<=end_cntr+1;
	         
	      end if;--right_cntr
	    end if;--left_cntr
	    end if;--phase
	    
	    if x_coord ="00000000" then
	      assert false report "Paddle has escaped!" severity failure;
	    end if;
	    
	    if x_coord/=x_old then
	      assert x_coord=x_old report "X-coordinate changed!" severity note;
	      change_cntr<=change_cntr+1;
	    end if;
	  end if;--clk'event
	end process;--clkd_simulation
	
	combo_proc : process (write,write_old)
	begin
	  if (write='0' and write_old='0') then
 	    w_rdy<='1'; 
    else
      w_rdy<='0';
    end if;
	end process;
	
	timed_simulation : process
	begin
	  wait for 6000 ns;
	  if(w_rdy_cntr = 0) then
	    assert false report "Errors in write signal!" severity failure;
	  end if;
	  assert false report "simulation timed out" severity failure;
	end process;
	
	
END ARCHITECTURE testbench;

