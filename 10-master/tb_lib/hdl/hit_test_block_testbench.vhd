--
-- VHDL Architecture tb_lib.hit_test_block.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 16:18:06  4.06.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY hit_test_block IS
-- Declarations
  port(
    clk : out std_logic;
    rst_n : out std_logic;
    hit : in std_logic;
    done : in std_logic;
    tested_hits : in std_logic_vector (3 downto 0)
  );
END hit_test_block ;

--
ARCHITECTURE testbench OF hit_test_block IS
 	constant clk_period : time := 20 ns;

	signal clk_tb : std_logic :='0';
	signal rst_n_tb : std_logic:='0';
	
	signal hit_counter : integer:=0;


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
	  elsif (clk_tb'event and clk_tb ='1') then
	   if(hit='1') then
	     hit_counter<= hit_counter +1;
	   end if;
	   
	   if(done ='1') then
	     assert to_integer(unsigned(tested_hits))=hit_counter
	     report "Simulation completed with errors!!"
	     severity failure;
	     assert false report "Simulation successful!"
	     severity failure;
	   end if;--done
	  end if;--clk event
	 end process;--clocked simulation
	  
	
END ARCHITECTURE testbench;

