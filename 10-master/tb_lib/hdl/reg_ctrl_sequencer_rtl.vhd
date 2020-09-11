--
-- VHDL Architecture tb_lib.reg_ctrl_sequencer.rtl
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 12:01:01 24.08.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY reg_ctrl_sequencer IS
   PORT( 
      clk           : IN     std_logic;
      rst_n         : IN     std_logic;
      x             : IN     std_logic_vector (7 DOWNTO 0);
      y             : IN     std_logic_vector (7 DOWNTO 0);
      pixdata       : OUT    std_logic_vector (23 DOWNTO 0);
      simu_end      : OUT    std_logic;
      corr          : OUT    std_logic;
      composed_data : IN     std_logic_vector (23 DOWNTO 0)
   );

-- Declarations

END reg_ctrl_sequencer ;

--
ARCHITECTURE rtl OF reg_ctrl_sequencer IS
--signal array declarations
  type data_array is array (63 downto 0) of std_logic_vector (23 downto 0);

  signal looped_data : data_array :=(others=>(others=>'0'));
  signal loop_indexer : integer range 0 to 63:=0;
  signal cntr_end : integer:=0;
  
  signal first_round_pass : std_logic := '1';
  signal stop_simulation : std_logic :='0';

  signal data : data_array := (
  0=>"110111101010110110101010",
  1=>"110111101010110110101011",
  2=>"110111101010110110101100",
  3=>"110111101010110110101101",
  4=>"110111101010110110101110",
  5=>"110111101010110110101111",
  6=>"110111101010110110110000",
  7=>"110111101010110110110001",
  8=>"110111101010110110110010",
  9=> "110111101010110110110011",
  10=>"110111101010110110110100",
  11=>"110111101010110110110101",
  12=>"110111101010110110111111",
  13=>"110111101010110111000000",
  14=>"110111101010110111000001",
  15=>"110111101010110111000011",
  16=>"110111101010110111000100",
  17=>"110111101010110111000101",
  18=>"110111101010110111000110",
  19=>"110111101010110111001000",
  20=>"110111101010110111001001",
  21=>"110111101010110111001011",
  22=>"110111101010110111001111",
  23=>"110111101010110111010000",
  24=>"110111101010110111010001",
  25=>"110111101010110111010010",
  26=>"110111101010110111010011",
  27=>"110111101010110111010100",
  28=>"110111101010110111010101",
  29=>"110111101010110111010110",
  30=>"110111101010110111010111",
  31=>"110111101010110111011000",
  32=>"110111101010110111011001",
  33=>"110111101010110111011010",
  34=>"110111101010110111011011",
  35=>"110111101010110111011100",
  36=>"110111101010110111011101",
  37=>"110111101010110111011110",
  38=>"110111101010110111011111",
  39=>"110111101010110111100000",
  40=>"110111101010110111100001",
  41=>"110111101010110111100010",
  42=>"110111101010110111100011",
  43=>"110111101010110111100100",
  44=>"110111101010110111100101",
  45=>"110111101010110111100111",
  46=>"110111101010110111101000",
  47=>"110111101010110111101001",
  48=>"110111101010110111101010",
  49=>"110111101010110111101011",
  50=>"110111101010110111101100",
  51=>"110111101010110111101101",
  52=>"110111101010110111101111",
  53=>"110111101010110111110000",
  54=>"110111101010110111110001",
  55=>"110111101010110111110010",
  56=>"110111101010110111110011",
  57=>"110111101010110111110100",
  58=>"110111101010110111110101",
  59=>"110111101010110111110110",
  60=>"110111101010110111110111",
  61=>"110111101010110111111000",
  62=>"110111101010110111111001",
  others=>"110111101010110111111111"
  );
 
  signal indexer : integer range 0 to 63:=0;
  
BEGIN
  

  x_y_proc : process (x, y)
  begin
    case y is
      when "00000001"=>
        case x is
          when "00000001"=> indexer<=0;
          when "00000010"=> indexer<=1;
          when "00000100"=> indexer<=2;
          when "00001000"=> indexer<=3;
          when "00010000"=> indexer<=4;
          when "00100000"=> indexer<=5;
          when "01000000"=> indexer<=6;
          when others=> indexer<=7;
        end case;
      when "00000010"=>
        case x is
          when "00000001"=> indexer<=8;
          when "00000010"=> indexer<=9;
          when "00000100"=> indexer<=10;
          when "00001000"=> indexer<=11;
          when "00010000"=> indexer<=12;
          when "00100000"=> indexer<=13;
          when "01000000"=> indexer<=14;
          when others=> indexer<=15;
        end case;
      when "00000100"=>
        case x is
          when "00000001"=> indexer<=16;
          when "00000010"=> indexer<=17;
          when "00000100"=> indexer<=18;
          when "00001000"=> indexer<=19;
          when "00010000"=> indexer<=20;
          when "00100000"=> indexer<=21;
          when "01000000"=> indexer<=22;
          when others=> indexer<=23;
        end case;
      when "00001000"=>
        case x is
          when "00000001"=> indexer<=24;
          when "00000010"=> indexer<=25;
          when "00000100"=> indexer<=26;
          when "00001000"=> indexer<=27;
          when "00010000"=> indexer<=28;
          when "00100000"=> indexer<=29;
          when "01000000"=> indexer<=30;
          when others=> indexer<=31;
        end case;
      when "00010000"=>
        case x is
          when "00000001"=> indexer<=32;
          when "00000010"=> indexer<=33;
          when "00000100"=> indexer<=34;
          when "00001000"=> indexer<=35;
          when "00010000"=> indexer<=36;
          when "00100000"=> indexer<=37;
          when "01000000"=> indexer<=38;
          when others=> indexer<=39;
        end case;
      when "00100000"=>
        case x is
          when "00000001"=> indexer<=40;
          when "00000010"=> indexer<=41;
          when "00000100"=> indexer<=42;
          when "00001000"=> indexer<=43;
          when "00010000"=> indexer<=44;
          when "00100000"=> indexer<=45;
          when "01000000"=> indexer<=46;
          when others=> indexer<=47;
        end case;
      when "01000000"=>
        case x is
          when "00000001"=> indexer<=48;
          when "00000010"=> indexer<=49;
          when "00000100"=> indexer<=50;
          when "00001000"=> indexer<=51;
          when "00010000"=> indexer<=52;
          when "00100000"=> indexer<=53;
          when "01000000"=> indexer<=54;
          when others=> indexer<=55;
        end case;
      when others=>
        case x is
          when "00000001"=> indexer<=56;
          when "00000010"=> indexer<=57;
          when "00000100"=> indexer<=58;
          when "00001000"=> indexer<=59;
          when "00010000"=> indexer<=60;
          when "00100000"=> indexer<=61;
          when "01000000"=> indexer<=62;
          when others=> indexer<=63;
        end case;
    end case;
  end process;
             
  --
  indexer_proc:process (indexer)
  begin
    pixdata<=data(indexer);
  end process;
  
  ---
  compose_proc:process (composed_data,rst_n)
  begin
    if (rst_n='0') then
      first_round_pass<='0';
      stop_simulation<='0';

    elsif rst_n='1' then
      if(stop_simulation='0') then
        if(first_round_pass='1') then
          looped_data(loop_indexer)<=composed_data;
           if (loop_indexer<63) then
             loop_indexer<=loop_indexer+1;
           else
             stop_simulation<='1';
          end if;
        else 
          first_round_pass<='1';
        end if;
      end if;
    end if;
  end process;
  
  clocked_proc : process(clk, rst_n)
  begin
    if rst_n ='0' then
      cntr_end <=0;
      simu_end<='0';
      corr<='0';
    elsif (clk'event and clk='1') then
      if loop_indexer=63 then
        if cntr_end =200 then
          simu_end<=stop_simulation;
          if (data=looped_data) then
            corr<='1';
          else 
            corr<='0';
          end if;
        else
          cntr_end<=cntr_end+1;
        end if;
      end if;
    end if;
  end process;
  
  
END ARCHITECTURE rtl;

