--
-- VHDL Architecture tb_lib.victory_text_test_block.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 16:22:38  4.06.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY victory_text_test_block IS
-- Declarations
port(
  clk : out std_logic;
  rst_n : out std_logic;
  color : in std_logic_vector (23 downto 0);
  x_data : in std_logic_vector (7 downto 0);
  y_data : in std_logic_vector (7 downto 0);
  pixel_amount : in std_logic_vector (5 downto 0)
  );

END victory_text_test_block ;

--
ARCHITECTURE testbench OF victory_text_test_block IS
	
	constant clk_period : time := 20 ns;

	signal clk_tb : std_logic :='0';
	signal rst_n_tb : std_logic:='0';
	
	signal in_counter : integer:=0;
	signal error_counter : integer:=0;
	
	signal set_received : std_logic:='0';
	
	constant zero_color : std_logic_vector (23 downto 0):=(others=>'0');
	constant zero_coordinate : std_logic_vector (7 downto 0):=(others=>'0');

BEGIN
  --port assignemnts
  clk<= clk_tb;
  rst_n <= rst_n_tb;
    
  --internal signals
  clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 3*clk_period;
	
	
	------------------------------
	clkd_proc : process (clk_tb, rst_n_tb)
	begin
	  if (rst_n_tb ='0') then
	    in_counter <= to_integer(unsigned(pixel_amount));
	    set_received <='0';
	    error_counter<=0;
      
	  elsif (clk_tb'event and clk_tb='1') then
      if (set_received ='0') then
        
        if(color(23 downto 16)="00000000") then
          assert false report "No BLUE value set!" severity note;
        end if;
        if(color(15 downto 8)="00000000") then
          assert false report "No GREEN value set!" severity note;
        end if;
        if(color(7 downto 0)="00000000") then
          assert false report "No RED value set!" severity note;
        end if;
        
        if(color=zero_color) then
          error_counter<=error_counter+1;
          assert false report "No color value set at all!!" severity error;
        end if;
        
        if(x_data = zero_coordinate) then
          error_counter<= error_counter+1;
          assert false report "No X-coordinate set for data!" severity error;
        end if;
        
        if(y_data = zero_coordinate) then
          error_counter<= error_counter+1;
          assert false report "No Y-coordinate set for data!" severity error;
        end if;

        if(in_counter>0) then
          in_counter<=in_counter-1;
         
        else
          set_received<='1';
        end if;--in_counter
        
      else--set receive else
        if error_counter = 0 then
          assert false report "Simulation successful!" severity failure;
        else
          assert false report "Simulation ended with errors!" severity failure;
        end if;--error counter
       
	    end if;--set receive
	  end if;--clk'event
  end process;--clk simulation    
	------------------------------
	
	------------------------------
	timed_simulation : process
  begin -- timed_simulation
    wait for 2000 ns;
    assert false report "Simulation timed out!" severity failure;   
  end process;--time out proc
	------------------------------
END ARCHITECTURE testbench;

