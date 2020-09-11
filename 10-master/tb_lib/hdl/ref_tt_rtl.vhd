--
-- VHDL Architecture tb_lib.ref_tt.rtl
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 15:47:11 12.06.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY ref_tt IS
   PORT( 
      to_duv  : IN     std_logic_vector (2 DOWNTO 0);
      ref_res : OUT    std_logic_vector (7 DOWNTO 0)
   );

-- Declarations

END ref_tt ;

--
ARCHITECTURE rtl OF ref_tt IS
BEGIN
  verification_proc : process (to_duv)
  begin --verification proc
    case to_duv is
    when "000" =>ref_res<="00000001";
    when "001" =>ref_res<="00000010";
    when "010" =>ref_res<="00000100";
    when "011" =>ref_res<="00001000";
    when "100" =>ref_res<="00010000";
    when "101" =>ref_res<="00100000";
    when "110" =>ref_res<="01000000";
    when others =>ref_res<="10000000";
    end case;
  end process;
END ARCHITECTURE rtl;

