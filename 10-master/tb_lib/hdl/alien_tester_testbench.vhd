--
-- VHDL Architecture tb_lib.alien_tester.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 17:08:23  8.08.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)

--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY alien_tester IS
  -- Declarations
  port(
    color   : in  std_logic_vector (23 downto 0);
    y       : in  std_logic_vector (7  downto 0);
    x       : in  std_logic_vector (7  downto 0);
    clk     : out std_logic;
    rst_n   : out std_logic; 
    sw0     : out std_logic;
    en      : out std_logic;
    hit     : out std_logic;
    alien_hp: in std_logic_vector (3 downto 0);
    x_end : in std_logic_vector (7 downto 0);
    y_end : in std_logic_vector (7 downto 0);
    color_end : in std_logic_vector (23 downto 0);
    alien_defeated : in std_logic
  );
END alien_tester ;

--
ARCHITECTURE testbench OF alien_tester IS
  
  constant clk_period : time := 20 ns;
  
  signal clk_tb   : std_logic:='0';
  signal rst_n_tb : std_logic:='0';
  signal en_tb    : std_logic:='0';
  signal sw0_tb: std_logic:='0';
  signal hit_tb   : std_logic:='0';
  
  signal loop_cntr : integer:=0;
  signal hit_cntr : integer:=0;
  signal en_cntr : integer:=0;
  
  signal end_cntr : integer:=0;
  
  signal alien_defeated_tb: std_logic:='0';
  
  signal print_once : std_logic:='0';
BEGIN
  
  clk<= clk_tb;
  rst_n<= rst_n_tb;
  en <= en_tb;
  sw0 <= sw0_tb;
  hit <= hit_tb;  
  
  alien_defeated_tb<=alien_defeated;
  
  clk_tb <= not clk_tb after clk_period/2;
  rst_n_tb <= '1' after 2*clk_period;
  
  clkd_simulation : process (clk_tb,rst_n_tb)
  begin --clked_simulation
    if rst_n_tb = '0'  then
      --reset values 
      loop_cntr<=0;
      hit_cntr<=0;
      en_cntr<=0;
      print_once<='0';
      elsif(clk_tb'event and clk_tb='1') then
        --clocked test logic
        if hit_cntr = to_integer(unsigned(alien_hp)) then -- alien hp reached
          if end_cntr=5 then -- end counter to give full waveform
            if(print_once ='0') then
              if(alien_defeated_tb='1') then
                assert false report "Simulation successful! Defeated signal found!"
                severity note;
              elsif (( x = x_end and y = y_end) and color = color_end) then
                assert false report "Simulation successful! End effect regocnized!"
                severity note;
              else 
                assert false report "Simulation ended in failure! No ending detected!"
                severity error;
              end if;
              print_once<='1';
            end if;
          else--increment end counter
            end_cntr<=end_cntr+1;
          end if;
          else-- if alien is alive
            if loop_cntr = 10 then
              loop_cntr<=0;
              en_tb<='1';
              if en_cntr =5 then
                hit_cntr<=hit_cntr+1;
                en_cntr<=0;
                hit_tb<='1';
                assert false report "Alien was hit!" severity note;
              else
                en_cntr<=en_cntr+1;
              end if;
            else 
              loop_cntr<=loop_cntr+1;
              en_tb<='0';
              hit_tb<='0';
                
            end if;
             
          end if;
        end if;
  end process; --clked_simulation 
        
  timed_simulation : process
  begin --timed_simulation
     wait for 20000 ns;
     --
     assert false report "Simulation timed out!!"
     severity failure;
   end process;--timed_simulation
        
END ARCHITECTURE testbench;