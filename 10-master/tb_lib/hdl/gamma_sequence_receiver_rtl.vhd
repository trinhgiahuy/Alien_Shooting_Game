--
-- VHDL Architecture tb_lib.gamma_sequence_receiver.rtl
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 14:00:52 19.06.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY gamma_sequence_receiver IS
   PORT( 
      bit   : IN     std_logic;
      clk   : IN     std_logic;
      rst_n : IN     std_logic;
      tx    : IN     std_logic;
      run   : OUT    std_logic;
      sb    : in     std_logic;
      reg_set : out  std_logic_vector (5 downto 0);
      gamma_value : out std_logic_vector (5 downto 0)
      
   );

-- Declarations

END gamma_sequence_receiver ;

--
ARCHITECTURE rtl OF gamma_sequence_receiver IS
  --signal array declarations
  type gamma_array is array (7 downto 0) of std_logic_vector (5 downto 0);

  signal gamma_b : gamma_array := (others => (others => '0'));
  signal gamma_g : gamma_array := (others => (others => '0'));
  signal gamma_r : gamma_array := (others => (others => '0'));

  signal arr_indexer : integer range 0 to 7:=0;
  signal data_vector : std_logic_vector (5 downto 0):="000000";
  signal pixel_indexer : integer range 0 to 5:=5;
  signal rgb_indexer : integer range -1 to 2:=0;
  
  signal counter : integer :=0;
  
  signal reg_set_int : integer range -1 to 30 :=0;
  signal sb_once : std_logic:='0';

  --this signal exists purely for avoiding array being
  --optimized away.
  signal gamma_debug : std_logic_vector (5 downto 0);
  
  constant zeroes : std_logic_vector:="000000";
  
BEGIN
  reg_set <= std_logic_vector(to_signed(reg_set_int,6));
  
  clocked_proc : process (rst_n, clk)
  begin --clocked proc
    if(rst_n='0') then
      --async reset values
      run <='0';
      data_vector <=(others=>'0');
      pixel_indexer<=5;
      gamma_b <=(others => (others => '0'));
      gamma_g <=(others => (others => '0'));
      gamma_r <=(others => (others => '0'));
      rgb_indexer <=-1;
      counter <=0;
      reg_set_int <=-1;
      sb_once <= '0';
      gamma_value<=(others=>'0');
      gamma_debug<=(others=>'0');
      
    elsif (clk'event and clk ='1') then
      
      if(sb='1') then
        gamma_r(7)<=data_vector;
        if(sb_once='0') then
          reg_set_int <= reg_set_int +1;
          sb_once <='1';
        end if;
        
        for I in 0 to 5 loop
          
          if gamma_b(I)=zeroes or gamma_g(I)=zeroes or gamma_r(I)=zeroes then
            assert false 
            report "Simulation ended in failure: Empty gamma register found!"
            severity failure;
          end if;
          
        end loop;
        
      end if;
      
      if(tx ='1'and counter>5) then
        counter<=0;
        run<='0';
        if(pixel_indexer=0) then
          pixel_indexer<=5;
          data_vector(pixel_indexer)<=bit;
          
          
        elsif(pixel_indexer=5) then
          case rgb_indexer is
            when -1 =>gamma_b(arr_indexer)<=data_vector;
                      gamma_debug<=gamma_b(arr_indexer);
            when 0 => gamma_b(arr_indexer)<=data_vector;
                      gamma_debug<=gamma_b(arr_indexer);
            when 1 => gamma_g(arr_indexer)<=data_vector;
                      gamma_debug<=data_vector;
            when 2 => gamma_r(arr_indexer)<=data_vector;
                      
          end case;
          gamma_value<=data_vector;
          
          reg_set_int <= reg_set_int +1;
          
          pixel_indexer<=pixel_indexer-1;
          data_vector(pixel_indexer)<=bit;
         
          if(rgb_indexer=2) then
            rgb_indexer<=0;
            if arr_indexer /= 7 then
              arr_indexer<= arr_indexer +1;
            end if;
          else
            rgb_indexer<=rgb_indexer+1;
          end if;--rgb
          
          
          
          
        else
          pixel_indexer<=pixel_indexer-1;
          data_vector(pixel_indexer)<=bit;
        end if;--pixel 
      else
        counter <=counter +1;
        if(counter =4) then
          run<='1';
        end if;
      end if;--tx
        
        
    
    end if;-- clk'event
  end process;--clocked_proc
  

    
END ARCHITECTURE rtl;

