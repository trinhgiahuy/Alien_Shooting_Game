--
-- VHDL Architecture tb_lib.pixel_conf_tester.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 09:44:06  3.07.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY pixel_conf_tester IS
   PORT( 
      color : IN     std_logic_vector (23 DOWNTO 0);
      x     : IN     std_logic_vector (7 DOWNTO 0);
      y     : IN     std_logic_vector (7 DOWNTO 0)
   );

-- Declarations

END pixel_conf_tester ;

--
ARCHITECTURE testbench OF pixel_conf_tester IS
  signal red_tb : std_logic:='0';
  signal green_tb : std_logic:='0';
  signal blue_tb : std_logic:='0';
BEGIN

	
  timed_simulation:process
  begin--timed simulation
      wait for 20 ns;
      
      assert x/="00000000" report "No x coordinate set!" severity failure;
      assert y/="00000000" report "No y coordinate set!" severity failure;
      
      if (color(23 downto 16)="00000000") then
        blue_tb<='1';
        assert false report "No Blue value set!"
        severity note;
      end if;
      if (color(15 downto 8)="00000000") then
        green_tb<='1';
        assert false report "No Green value set!"
        severity note;
      end if;
      if (color(7 downto 0)="00000000") then 
        red_tb<='1';
        assert false report "No Red value set!"
        severity note;
      end if;
      
      if ((red_tb='1' and green_tb='1') and blue_tb='1') then
        assert false
        report "No colour value set at all!"
        severity failure;
      end if;
      
      wait for 80 ns;
      assert false report "Simulation successful!"
      severity failure;
      

  end process;
  
  
END ARCHITECTURE testbench;

