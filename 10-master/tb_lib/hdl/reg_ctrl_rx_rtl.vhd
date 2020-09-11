--
-- VHDL Architecture tb_lib.reg_ctrl_rx.rtl
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 13:22:56 24.08.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY reg_ctrl_rx IS
   PORT( 
      bit_from_duv       : IN     std_logic;
      chans         : IN     std_logic_vector (7 DOWNTO 0);
      clk           : IN     std_logic;
      lat           : IN     std_logic;
      rst_n         : IN     std_logic;
      tx            : IN     std_logic;
      composed_data : OUT    std_logic_vector (23 DOWNTO 0);
      run           : OUT    std_logic;
      gathered : out std_logic_vector (7 downto 0);
      rising_lats : out std_logic_vector (6 downto 0)
   );

-- Declarations

END reg_ctrl_rx ;

--
ARCHITECTURE rtl OF reg_ctrl_rx IS
  signal comp : std_logic_vector (23 downto 0):=(others=>'0');
  signal bit_indexer : integer range 0 to 23;
  
  signal counter : integer;
  
  signal gather_channels : std_logic_vector (7 downto 0) :=(others=>'0');
  
  signal lat_old : std_logic := '0';
  signal count_lats : integer :=0;
  
BEGIN
  gathered<=gather_channels;
  rising_lats<=std_logic_vector(to_unsigned(count_lats,7));

  clocked_proc : process (rst_n, clk)
  begin --clocked proc
    if(rst_n='0') then
      run<='0';
      counter<=0;
      bit_indexer<=23;
      composed_data<=(others=>'0');
      comp<=(others=>'0');
      gather_channels<=(others=>'0');
      count_lats<=0;
      lat_old<='0';
    elsif (clk'event and clk ='1') then
      --gathering up the channel count
      gather_channels<=gather_channels or chans;

      ----------------------------------------------
      --lat edge detection
      lat_old<=lat;
      if (lat_old='0' and lat='1') then
        count_lats<=count_lats+1;
      end if;
      
      ----------------------------------------------
      --tx and run stimulus
      if(tx ='1' and counter>5 ) then
        counter<=0;
        run<='0';
        if (bit_indexer=0) then
          bit_indexer<=23;
          comp(bit_indexer)<=bit_from_duv;

        elsif (bit_indexer=23)then
          bit_indexer<=bit_indexer-1;
          comp(bit_indexer)<=bit_from_duv;
          composed_data<=comp;
        else
   
          bit_indexer<=bit_indexer-1;
          comp(bit_indexer)<=bit_from_duv;
        end if;
      else
        counter<=counter+1;
        if (counter =4) then
          run<='1';
        end if;


      end if;--tx
      
      
         
    end if;-- clk'event
  end process;--clocked_proc
  
END ARCHITECTURE rtl;