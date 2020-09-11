--
-- VHDL Architecture tb_lib.bullet_test_block.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 13:40:53 31.05.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY bullet_test_block IS
-- Declarations
  port(
    gun_x : out std_logic_vector (7 downto 0);
    clk : out std_logic;
    rst_n : out std_logic;
    
    btn : out std_logic_vector (3 downto 0);
    en : out std_logic;
      
    bullet_x : in std_logic_vector (7 downto 0);
    bullet_y : in std_logic_vector (7 downto 0);
    bullet_colour : in std_logic_vector (23 downto 0)
);
END bullet_test_block ;

--
ARCHITECTURE testbench OF bullet_test_block IS
  constant clk_period : time :=20 ns;
  
  signal clk_tb : std_logic:='0';
  
  signal rst_n_tb : std_logic:='0';
  signal btn_tb : std_logic_vector(3 downto 0) := "0000";
  
  signal bullet_tb : std_logic_vector (7 downto 0) :=(others=>'0');
  signal bullet_old_tb : std_logic_vector (7 downto 0):=(others=>'0');
  
  signal shots : integer:=0;
  
  signal cntr : integer:=0;
  signal en_tb : std_logic:='0';
  
  signal en_cntr : integer:=0;
  
  signal gun_x_tb : std_logic_vector (7 downto 0):=(others=>'0');
  
BEGIN
  --port signal assignments
  clk<=clk_tb;
  rst_n <= rst_n_tb;
  btn <= btn_tb;
  en <=en_tb;
  gun_x<=gun_x_tb;
  bullet_tb <=bullet_y;

  
 	-- testbench signal assignments
	clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 3*clk_period;
	
	clocked_proc : process (clk_tb,rst_n_tb)
	begin --clocked_proc
	  if(rst_n_tb='0') then
	    bullet_old_tb <=(others=>'0');
	    gun_x_tb<="10000000";
	    cntr<=0;
      en_tb<='0';
      en_cntr<=0;
      shots<=0;
      
	  elsif(clk_tb'event and clk_tb='1') then 
	    
	    if (bullet_tb(0)='0' and bullet_old_tb(0)='1') then
        gun_x_tb <= '0' & gun_x_tb(7 downto 1);
        shots<=shots+1;
      end if;	    
	    
	    bullet_old_tb <= bullet_tb;	
	    
	    if en_cntr=20 then 
	      en_tb<='1';
	      en_cntr<=0;
	      
  	     if cntr=15 then
  	       btn_tb(0)<='1';
  	       cntr<=0;
        else 
          btn_tb(0)<='0';
          cntr<=cntr+1;
        end if;
      else
        en_cntr<=en_cntr+1;
    	   en_tb<='0';
    	 end if;
	    
	  end if;
  end process;--clocked_proc
-------------------------
  assert_proc:process (bullet_tb,gun_x_tb,rst_n_tb)
  begin
    if rst_n_tb='1' then
      if (bullet_tb(0)='0' and bullet_old_tb(0)='1') then
        assert false report "bullet shot completed successfully" severity note;   
      end if;
      
      if (gun_x_tb="00000000" and shots=8) then
        assert false report "Simulation successful!" severity failure;
      elsif (gun_x_tb="00000000") then
        assert false report "Simulation ended with errors" severity failure;
      end if;
    end if;
  end process;
  
  ---------------
  timed_simulation : process
  begin
    wait for 100000 ns;
    assert false report "Simulation timed out!" severity failure;

  end process;
  -------------------------
END ARCHITECTURE testbench;

