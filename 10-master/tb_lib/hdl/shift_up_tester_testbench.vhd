--
-- VHDL Architecture tb_lib.shift_up_tester.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 09:19:52  9.08.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY shift_up_tester IS
   PORT( 
      from_up_shifter : IN     std_logic_vector (7 DOWNTO 0);
      correct         : OUT    std_logic;
      to_up_shifter   : OUT    std_logic_vector (7 DOWNTO 0)
   );

-- Declarations

END shift_up_tester ;

--
ARCHITECTURE testbench OF shift_up_tester IS
    
 	constant clk_period : time := 20 ns;

	signal clk_tb : std_logic :='0';
	signal rst_n_tb : std_logic:='0';
	
	signal error_cntr : integer:=0;
	
	signal x_out : std_logic_vector (7 downto 0):=(others=>'0');
	signal x_in : std_logic_vector (7 downto 0):=(others =>'0'); 
	
	signal cntr : integer:=0;
	
	signal correct_tb : std_logic:='0';
	
BEGIN
  
    --internal timing signals
  clk_tb <= not clk_tb after clk_period/2;
  rst_n_tb <= '1' after clk_period*3;
  
  --port assignments
  to_up_shifter <= x_out;
  x_in <= from_up_shifter;
  correct<= correct_tb;
  
  clked_simulation: process (clk_tb, rst_n_tb)
  begin --
    if(rst_n_tb ='0') then
      error_cntr<=0;
      x_out<=(others=>'0');
      cntr<=0;
      correct_tb<='0';
    elsif (clk_tb'event and clk_tb='1') then
      
      --analyse test cases
      if( x_out ="00000000" ) then
        if x_in/="00000000" then
          assert false report "Error in the design!" severity error;     
          error_cntr <= error_cntr+1;
          correct_tb<='0';
        else
          correct_tb<='1';
        end if;
      elsif (x_out ="00000001" ) then
        if x_in/="00000010" then
          assert false report "Error in the design!" severity error;     
          error_cntr <= error_cntr+1;
          correct_tb<='0';
        else
          correct_tb<='1';
          end if;
      elsif (x_out ="00000010" ) then
        if x_in/="00000100" then
          assert false report "Error in the design!" severity error;     
          error_cntr <= error_cntr+1;
          correct_tb<='0';
        else
          correct_tb<='1';
          end if;
      elsif (x_out ="00000100" ) then
        if x_in/="00001000" then
          assert false report "Error in the design!" severity error;     
          error_cntr <= error_cntr+1;
          correct_tb<='0';
        else
          correct_tb<='1';
        end if;
      elsif (x_out ="00001000" ) then
        if x_in/="00010000" then
          assert false report "Error in the design!" severity error;     
          error_cntr <= error_cntr+1;
          correct_tb<='0';
        else
          correct_tb<='1';
        end if;
      elsif (x_out ="00010000" ) then
        if x_in/="00100000" then
          assert false report "Error in the design!" severity error;     
          error_cntr <= error_cntr+1;
          correct_tb<='0';
        else
          correct_tb<='1';
        end if;
      elsif (x_out ="00100000" ) then
        if x_in/="01000000" then
          assert false report "Error in the design!" severity error;     
          error_cntr <= error_cntr+1;
          correct_tb<='0';
        else
          correct_tb<='1';
        end if;
      elsif (x_out ="01000000" ) then
        if x_in/="10000000" then
          assert false report "Error in the design!" severity error;     
          error_cntr <= error_cntr+1;
          correct_tb<='0';
        else
          correct_tb<='1';
        end if;
      elsif (x_out ="10000000" ) then
        if x_in/="00000000" then
          assert false report "Error in the design!" severity error;     
          error_cntr <= error_cntr+1;
          correct_tb<='0';
        else
          correct_tb<='1';
        end if;
      end if;--end test cases
      
      
      --crete counter to end simulation
      cntr<=cntr+1;
      --create test cases
      if(x_out = "00000000") then
        x_out<= "00000001";
      else 
        x_out<=x_out(6 downto 0) & '0';
      end if;
            
      --end of a simulation.
      if(cntr=19) then
        if error_cntr=0 then
          assert false report "Simulation successful!" severity failure;
        else
          assert false report "Simulation ended with errors!" severity failure;
        end if;
      end if;--end assertions
    end if;--clk'evennt
  end process;--clocked simulation
  
  --------------------------------------------------------------------------------
  --timing out the simulation in case missing assertions.
  timed_simulation : process
  begin -- 
    wait for 2000 ns;
    assert false report "Simulation timed out!" severity failure;
  end process;

  --------------------------------------------------------------------------------  


END ARCHITECTURE testbench;