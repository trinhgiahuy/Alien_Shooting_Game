--
-- VHDL Architecture tb_lib.register_single.testbench
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 16:36:09  4.06.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY register_single IS
-- Declarations
port(
  clk : out std_logic;
  rst_n : out std_logic;
  pix_d : out std_logic_vector (23 downto 0);
  pix_from_duv : in std_logic_vector (23 downto 0);
  write : out std_logic;
  nullify : out std_logic
  );
  

END register_single ;

--
ARCHITECTURE testbench OF register_single IS
  
 	constant clk_period : time := 20 ns;

  signal clk_tb : std_logic :='0';
 	signal rst_n_tb : std_logic:='0';
 	
 	--operation counters
 	signal event_counter : integer:=0;
 	signal error_counter : integer:=0;
 	
 	--constants
 	constant white : std_logic_vector (23 downto 0):=(others=>'1');
 	constant blue : std_logic_vector (23 downto 0):=(23 downto 16=>'1', others=>'0');
 	constant green : std_logic_vector (23 downto 0):=(15 downto 8=>'1', others=>'0');
 	constant red : std_logic_vector (23 downto 0):=(7 downto 0=>'1', others=>'0');
 	constant zeros : std_logic_vector (23 downto 0):=(others=>'0');
 	
 	--tb signals
 	signal write_tb : std_logic:='0';
 	signal nullify_tb : std_logic:='0';
 	signal pix_d_tb : std_logic_vector (23 downto 0):=(others=>'0');
 	
BEGIN
  --port assignments
  clk<= clk_tb;
  rst_n<= rst_n_tb;
  
  pix_d <= pix_d_tb;
  write <= write_tb;
  nullify<=nullify_tb;
  
  --internal generation
 	clk_tb <= not clk_tb after clk_period/2;
	rst_n_tb <= '1' after 2*clk_period;
	
	-----------------------------------------------------
	clkd_proc : process (clk_tb,rst_n_tb)
	begin
	  if (rst_n_tb='0') then
	    write_tb<='0';
	    nullify_tb<='0';
	    pix_d_tb<=(others=>'0');
	    event_counter<=0;
	    error_counter<=0;
	    
	  elsif (clk_tb'event and clk_tb='1') then
	    event_counter<=event_counter+1;
	    if(event_counter=0) then
	      pix_d_tb<=(others=>'1');
	      write_tb<='1';
	      
	    elsif(event_counter=1) then
	      write_tb<='0';
	    
	    elsif(event_counter=10) then
	      if (pix_from_duv/=white) then
	        error_counter<=error_counter+1;
	        assert false report "Colour did not get set to register!" severity error;
	      end if;
	      nullify_tb<='1';
	      
	    elsif(event_counter=11) then
	      nullify_tb<='0';	      
	      
	    elsif(event_counter=12) then
	      if (pix_from_duv/=zeros) then
	        error_counter<=error_counter+1;
	        assert false report "Registers did not null their value!" severity error;
        end if;
        write_tb<='1';
        pix_d_tb<=blue;
        
	    elsif(event_counter=13) then
	      write_tb<='0';
	      
	    elsif(event_counter=20) then
	      if (pix_from_duv/=blue) then
	        error_counter<=error_counter+1;
	        assert false report "Colour did not get set to register!" severity error;
	      end if;
	      nullify_tb<='1';
	      
	    elsif(event_counter=21) then
	      nullify_tb<='0';
	      
	    elsif(event_counter=30) then
	      if (pix_from_duv/=zeros) then
	        error_counter<=error_counter+1;
	        assert false report "Registers did not null their value!" severity error;
        end if;
        write_tb<='1';
        pix_d_tb<=green;
	      
	    elsif(event_counter=31) then
	      write_tb<='0';
	      
      elsif(event_counter=40) then
	      if (pix_from_duv/=green) then
	        error_counter<=error_counter+1;
	        assert false report "Colour did not get set to register!" severity error;
	      end if;
	      nullify_tb<='1';
	      
	    elsif(event_counter=41) then
	      nullify_tb<='0';
	      
	    elsif(event_counter=50) then
	      if (pix_from_duv/=zeros) then
	        error_counter<=error_counter+1;
	        assert false report "Registers did not null their value!" severity error;
        end if;
        write_tb<='1';
        pix_d_tb<=red;
      
      elsif(event_counter=51) then
	      write_tb<='0';
	      
      elsif(event_counter=60) then
	      if (pix_from_duv/=red) then
	        error_counter<=error_counter+1;
	        assert false report "Colour did not get set to register!" severity error;
	      end if;
	      nullify_tb<='1';
	      
	    elsif(event_counter=61) then
	      nullify_tb<='0';
	      
	    elsif(event_counter=70) then
	      if (pix_from_duv/=zeros) then
	        error_counter<=error_counter+1;
	        assert false report "Registers did not null their value!" severity error;
        end if;
        
      elsif(event_counter=75) then
        if error_counter = 0 then
          assert false report "Simulation Successful!" severity failure;
        else
          assert false report "Simulation ended with errors!" severity failure;
        end if;
  
  	      
      end if;
    end if;
  end process;--clkd_proc
  
  ----------------------------------------------------
  timed_simulation : process
  begin
    wait for 20000 ns;
    assert false report "Simulation time ended" severity failure;
  end process;
  
  ----------------------------------------------------
END ARCHITECTURE testbench;

