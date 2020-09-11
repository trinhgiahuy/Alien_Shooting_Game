--
-- VHDL Architecture tb_lib.half_adder_test_block.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 09:07:11  9.08.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY half_adder_test_block IS
   PORT( 
      carry : IN     std_logic;
      sum   : IN     std_logic;
      sw0   : OUT    std_logic;
      sw1   : OUT    std_logic
   );

-- Declarations

END half_adder_test_block ;

--
ARCHITECTURE testbench OF half_adder_test_block IS
BEGIN
  
  
  simulation :process
  begin -- simulation
    sw0<='0';
    sw1<='0';
    wait for 20 ns;
    assert (carry='0' and sum='0') report "Error in the design" 
    severity failure;
    --------------------------------------------------------------
    wait for 20 ns;
    sw0<='1';
    sw1<='0';
    wait for 20 ns;
    assert (carry='0' and sum='1') report "Error in the design" 
    severity failure;
    wait for 10 ns;
    -------------------------------------------------------------
    sw0<='0';
    sw1<='1';
    wait for 20 ns;
    assert (carry='0' and sum='1') report "Error in the design" 
    severity failure;
    wait for 20 ns;
    -------------------------------------------------------------
    sw0<='1';
    sw1<='1';
    wait for 20 ns;
    assert (carry='1' and sum='0') report "Error in the design" 
    severity failure;
    wait for 20 ns;
    --------------------------------------------------------------
    assert false report "Simulation successful!" severity failure;
    
  end process;--simulation
  
END ARCHITECTURE testbench;