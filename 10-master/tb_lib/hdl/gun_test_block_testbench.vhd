--
-- VHDL Architecture tb_lib.gun_test_block.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 14:05:19 31.05.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use ieee.std_logic_misc.all;


ENTITY gun_test_block IS
-- Declarations
  port(
    clk : out std_logic;
    rst_n : out std_logic;
    
    gun_x : in std_logic_vector (7 downto 0);
    gun_y : in std_logic_vector (7 downto 0);
    gun_color : in std_logic_vector (23 downto 0);
    
    btn : out std_logic_vector (3 downto 0);
    
    gun_px_idx : out std_logic_vector (4 downto 0);
    
    gun_pixel_amount : in std_logic_vector (4 downto 0);
    
    enable : out std_logic
);
END gun_test_block ;

--
ARCHITECTURE testbench OF gun_test_block IS
  constant clk_period : time := 20 ns;
  
  constant zero_vector : std_logic_vector (23 downto 0) :=(others=>'0'); 
  constant zero_gun : std_logic_vector (7 downto 0):=(others=>'0');

  signal clk_tb : std_logic :='0';
 	signal rst_n_tb : std_logic:='0';
	signal en_tb : std_logic:='0';
	signal btn_tb : std_logic_vector (3 downto 0) := "0000";
	
	signal gun_x_tb : std_logic_vector (7 downto 0):= "00000000";
	signal gun_y_tb : std_logic_vector (7 downto 0):= "00000000";
	
	signal cntr : integer;
	
	signal gun_pix_integer : integer;
	signal gun_index : std_logic_vector (4 downto 0);
	
	signal cntr_wait : integer:=0;
	signal ready : std_logic:='0';
  
  signal errors_in_duv : integer:=0;
  
BEGIN -- testbench
  --port signal assignments
  clk<= clk_tb;
  rst_n<= rst_n_tb;
  btn <= btn_tb;
  enable <= en_tb;  
  gun_px_idx <= gun_index;
  
  --internal assignments
 	clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 2*clk_period;
	
	--generic value from tb_constant
	gun_pix_integer <=to_integer(unsigned(gun_pixel_amount));
	
	--clocked proc for tracking gun location
	clocked_proc : process (clk_tb,rst_n_tb)
	begin --clocked_proc
	  if(rst_n_tb='0') then
      gun_x_tb<="00000000";
      gun_y_tb<="00000000";
      cntr<=0;
      en_tb <= '0';
      ready <='0';
      cntr_wait <=0;
      gun_index<=(others=>'0');
      errors_in_duv<=0;
      
      
	  elsif(clk_tb'event and clk_tb='1') then
	     assert gun_pix_integer>1 report "Your gun is too small"
	     severity failure;
	    
	    if ready = '0' then
  	    if cntr <(gun_pix_integer+1)  then 
 	      gun_index<=std_logic_vector(to_unsigned(cntr,5));
  	     gun_x_tb <= gun_x_tb or gun_x;
  	     gun_y_tb <= gun_y_tb or gun_y;
  	     cntr <= cntr +1;
  	     
  	     if gun_color=(zero_vector) then
  	       assert false report "Your Gun Is Invisible!!" severity error;
	      elsif (or_reduce(gun_color))/='1' then
 	         assert false report "illegal value in gun colour" severity error;
 	         errors_in_duv<=errors_in_duv+1;
	      end if;
	      
	      if gun_x=zero_gun then
    	      assert false report "Gun pixel doesn't have x value!!"
    	      severity error;
    	      errors_in_duv<=errors_in_duv+1;
 	      elsif (or_reduce(gun_x))/='1' then
 	         assert false report "illegal value in X-coordinate" severity error;
 	         errors_in_duv<=errors_in_duv+1;
  	     end if;
  	     
 	      if gun_y=zero_gun then
    	      assert false report "Gun pixel doesn't have y value!!"
    	      severity error;
    	      errors_in_duv<=errors_in_duv+1;
 	      elsif (or_reduce(gun_y))/='1' then
 	         assert false report "illegal value in Y-coordinate" severity error;
 	         errors_in_duv<=errors_in_duv+1;
  	     end if;
	      
  	    else 
	       assert false report "Set of gun coordinates received" severity note;
    	    gun_x_tb <= "00000000";
    	    gun_y_tb <= "00000000";
    	    cntr <= 0;
    	    ready <='1';
  	   end if;
	   else
	     if cntr_wait =13 then
	       en_tb<='1';
	       cntr_wait <= cntr_wait +1;
	     elsif cntr_wait = 14 then
	       en_tb<='0';
	       cntr_wait <= cntr_wait +1;
	     elsif cntr_wait =15 then
	       ready <= '0';
	       cntr_wait<=0;
	     else
	       cntr_wait <= cntr_wait +1;
	     end if;
	   end if;
	  end if;  
	  
	  
	  
	  
	end process;--clocked_proc
	  
	  
  timed_simulation : process
  begin -- timed_simulation
    wait for 2000 ns;
    if errors_in_duv=0 then
      assert false report "Simulation successful! Check the wave for results!" 
      severity failure;
    else
      assert false report "Simulation ended with errors!" severity failure; 
    end if;
  end process;
  
END ARCHITECTURE testbench;

