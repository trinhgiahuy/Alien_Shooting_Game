--
-- VHDL Architecture pre_made.en_wr.rtl
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 14:47:45 10.09.2019
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY en_wr IS
   PORT( 
      clk    : IN     std_logic;
      rst_n  : IN     std_logic;
      enable : OUT    std_logic;
      wr  : OUT    std_logic
   );

-- Declarations

END en_wr ;

--
ARCHITECTURE rtl OF en_wr IS
  signal cntr : integer:=0;
  signal enable_internal : std_logic:='0';
  signal write_internal : std_logic:='0';
BEGIN
  
  wr<=write_internal;
  enable<=enable_internal;
  
  clkd_proc : process (clk, rst_n)
  begin
    if (rst_n ='0') then
      cntr<=0;
      enable_internal<='0';
      write_internal<='0';
    elsif (clk'event and clk='1') then
      if cntr = 15000000 then
        cntr<=0;
        write_internal<='0';
      elsif cntr = 499999 then
        cntr<=cntr+1;
        write_internal<='1';
      elsif cntr = 499990 then
        cntr<=cntr+1;      
        enable_internal<='0';
      elsif cntr = 499989 then
        cntr<=cntr+1;
        enable_internal<='1';
      else
        cntr<=cntr+1;
      end if;
      
    end if;
  end process;
  
  
END ARCHITECTURE rtl;

