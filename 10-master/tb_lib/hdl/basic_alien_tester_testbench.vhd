--
-- VHDL Architecture tb_lib.basic_alien_tester.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 13:05:16 11.09.2019
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

ENTITY basic_alien_tester IS
PORT( 
      duv_x_out     : IN     std_logic_vector (7 DOWNTO 0);
      duv_y_out     : in std_logic_vector (7 downto 0);
      duv_color_out : in std_logic_vector (23 downto 0);
      clk           : OUT    std_logic;
      en            : OUT    std_logic;
      rst_n         : OUT    std_logic;
      hit           : out std_logic
   );

-- Declarations

END basic_alien_tester ;

--
ARCHITECTURE testbench OF basic_alien_tester IS
  
  constant clk_period : time := 20 ns;

	signal clk_tb : std_logic :='0';
	signal rst_n_tb : std_logic:='0';
	
	signal en_tb : std_logic :='0';
	
	signal en_counter :integer range 0 to 4:=0;
	
	signal hit_tb : std_logic:='0';
	signal hit_done : std_logic:='0';
	
	constant zero_color : std_logic_vector(23 downto 0):=(others=>'0');
	constant no_coord : std_logic_vector(7 downto 0):=(others=>'0');
	
  BEGIN
  --port assignemnts
  clk<= clk_tb;
  rst_n <= rst_n_tb;
  en <= en_tb;
  hit <= hit_tb;
   
  --internal signals
  clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 2*clk_period;
	
	enable_proc :process (clk_tb, rst_n_tb)
	begin
	  if (rst_n_tb='0') then
	    en_tb <='0';
	  elsif ( clk_tb'event and clk_tb='1') then
	   if (en_counter =4) then 
	     en_tb <= '1';
	     en_counter <= 0;
	   else--en counter    
	    en_tb<= '0';
	    en_counter<= en_counter +1;
	   end if;--en counter
    end if;--clk'event
  end process;
	
	
	simulation_time_out : process
	begin
	  wait for 5000 ns;
	  hit_tb <='1';
	  hit_done <='1';
	  wait for 40 ns;
	  hit_tb<='0';
	  wait for 460 ns;
	  
	  assert false report "Simulation done, inspect wave for details!"
	  severity failure;
	
	end process;
	
	asserting_proc : process (clk_tb,rst_n_tb)
	begin
	  if(rst_n_tb='0') then

	  elsif(clk_tb'event and clk_tb='1') then
	    
	    if(hit_done='0') then
      	    
      	    if(duv_x_out=no_coord ) then
      	      assert false report "X-coordinate is set as all zeros!" severity error;
      	      
   	       elsif( not(or_reduce(duv_x_out)='1' or or_reduce(duv_x_out)='0')) then
      	      assert false report "No X-coordinate has been set!" severity error;
  	        end if;
      	    if (duv_y_out=no_coord) then
      	      assert false report "Y-coordinate is set as all zeros!" severity error;
      	      
   	       elsif( not(or_reduce(duv_y_out)='1' or or_reduce(duv_y_out)='0')) then
      	      assert false report "No Y-coordinate has been set!" severity error;
 	         end if;
    	      if (duv_color_out=zero_color) then
    	        assert false report "Color value is set as all zeros" severity error;
    	        
 	         elsif( not(or_reduce(duv_color_out)='1' or or_reduce(duv_color_out)='0')) then
      	      assert false report "No colour has been set!" severity error;

           end if;
      end if;

	  end if;
	    
	 end process;
	  

END ARCHITECTURE testbench;

