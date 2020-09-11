--
-- VHDL Architecture tb_lib.serial_to_bus_block.rtl
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 11:42:22 31.05.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY serial_to_bus_block IS
   PORT( 
      clk   : IN     std_logic;
      rst_n : IN     std_logic;
      sb    : IN     std_logic;
      sck   : IN     std_logic;
      sda   : IN     std_logic;
      data_out  : OUT    std_logic_vector (7 DOWNTO 0);
      gamma_out : OUT    std_logic_vector (5 DOWNTO 0)
   );

-- Declarations

END serial_to_bus_block ;

--
ARCHITECTURE rtl OF serial_to_bus_block IS
  signal data : std_logic_vector (7 downto 0);
	signal gamma : std_logic_vector (5 downto 0);
	
	signal indexer : integer:=0;
	signal data_ind : integer:=0;
	signal sck_old : std_logic;
	
BEGIN
  clocked_proc : process (
	clk, rst_n)
	
	begin --clocked proc
	
		if (rst_n ='0' )then
			data <= (others=>'0');
			gamma <= (others=>'0');
			indexer <= 0;
			data_ind<= 0;
			sck_old<='0';
			
			data_out <=(others=>'0');
			gamma_out <=(others=>'0');
			
		elsif (clk'event and clk='1') then
			sck_old <= sck;
			if(sck='1' and sck_old ='0') then
				if(sb='0') then
					if (indexer = 0) then
						gamma_out <=gamma;			
					end if;
					
					gamma(indexer)<= sda;
					
					if(indexer +1 = 6 ) then
						indexer <= 0;
						
					else
						indexer<= indexer+1;
					end if;
					
				else
					if (data_ind=0) then 
					
					data_out <= data;
					end if;
					
					
					data(data_ind)<= sda;
						if(data_ind +1 = 8 ) then
							data_ind <= 0;
							
						else
							data_ind <= data_ind+1;
						end if;
				
				
				end if;
			end if;
		end if;
		
	end process;
	
END ARCHITECTURE rtl;

