--
-- VHDL Architecture pre_made.trigger_counter.rtl
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 14:10:52 13.08.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY trigger_counter IS
   PORT( 
      clk        : IN     std_logic;
      rst_n      : IN     std_logic;
      triggerbit : OUT    std_logic
   );

-- Declarations

END trigger_counter ;

--
ARCHITECTURE rtl OF trigger_counter IS
  signal cntr : integer:=0;
  signal trigger : std_logic:= '0';
BEGIN
  
  triggerbit<=trigger;
  
  clkd_proc : process (clk, rst_n)
  begin
    if (rst_n ='0') then
      cntr<=0;
      trigger<='0';
    elsif (clk'event and clk='1') then
      if cntr = 488282 then
        trigger <= not trigger;
        cntr<=0;
      else
        cntr<=cntr+1;
      end if;
    end if;
  end process;
END ARCHITECTURE rtl;