--
-- VHDL Architecture tb_lib.incre_vhdl.rtl
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 13:24:27  8.08.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY incre_vhdl IS
   PORT( 
      to_duv        : IN     std_logic_vector (2 DOWNTO 0);
      reference_res : OUT    std_logic_vector (2 DOWNTO 0)
   );

-- Declarations

END incre_vhdl ;

--
ARCHITECTURE rtl OF incre_vhdl IS
  --internal integer
  signal int_int : integer:=0;
BEGIN
  int_int<=to_integer(unsigned(to_duv));
  input_proc: process (int_int)
  begin
    
    if(int_int=7)  then
      reference_res<=(others=>'0');
    else
      reference_res<=std_logic_vector(to_unsigned(int_int+1,3));
    end if;
  end process; 
END ARCHITECTURE rtl;