--
-- VHDL Architecture pre_made.bounce_counter.rtl
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 15:32:56 27.07.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY bounce_counter IS
   PORT( 
      clk     : IN     std_logic;
      deb_btn : IN     std_logic;
      rst_n   : IN     std_logic;
      led     : OUT    std_logic_vector (3 DOWNTO 0)
   );

-- Declarations

END bounce_counter ;

--
ARCHITECTURE rtl OF bounce_counter IS
  signal cntr : integer:=0;
  signal modded : integer:=0;
  
BEGIN
  led <= std_logic_vector(to_unsigned(modded,4));
  
  clkd_proc : process (clk, rst_n)
  begin
    if(rst_n = '0') then
      cntr<=0;
      modded <=0;
      
    elsif (clk'event and clk='1') then
      if deb_btn ='1' then
        cntr<=cntr+1;
        modded <= cntr mod 16;
      end if;
    end if;
  end process;--clkd_proc
END ARCHITECTURE rtl;

