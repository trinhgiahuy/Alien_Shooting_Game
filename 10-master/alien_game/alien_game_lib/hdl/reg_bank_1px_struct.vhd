--* ><(((('> * Puli puli * ><(((('> // Ƹ̵̡Ӝ̵̨̄Ʒ * swish swish* Ƹ̵̡Ӝ̵̨̄Ʒ Ƹ̵̡Ӝ̵̨̄Ʒ // (っ◕‿◕)╭∩╮^H^H^Hっ
LIBRARY ieee;USE ieee.std_logic_1164.all;USE ieee.std_logic_arith.all;ENTITY reg_bank_1px IS PORT(clk:IN std_logic;nullify:IN std_logic;pixd_in:IN std_logic_vector(23 DOWNTO 0);rst_n:IN std_logic;write:IN std_logic;pixd_out:OUT std_logic_vector(23 DOWNTO 0));END reg_bank_1px ;LIBRARY ieee;USE ieee.std_logic_1164.all;USE ieee.std_logic_arith.all;ARCHITECTURE struct OF reg_bank_1px IS SIGNAL z5bf0509d2:std_logic_vector(23 DOWNTO 0);SIGNAL z508ec0017:std_logic_vector(23 DOWNTO 0);SIGNAL z6981ad0b9:std_logic_vector(1 DOWNTO 0);SIGNAL zf6569350a:std_logic_vector(23 DOWNTO 0);SIGNAL zeca5e5e74:std_logic_vector(23 DOWNTO 0);BEGIN zf6569350a<=zeca5e5e74;z126461a59:PROCESS(clk, rst_n)BEGIN IF(rst_n='0')THEN zeca5e5e74<="000000000000000000000000";ELSIF(clk'EVENT AND clk='1')THEN zeca5e5e74<=z508ec0017;END IF;END PROCESS z126461a59;z5bf0509d2<="000000000000000000000000";z6981ad0b9<=nullify & write;z430e8384e:PROCESS(zf6569350a, pixd_in, z5bf0509d2, z6981ad0b9)BEGIN CASE z6981ad0b9 IS WHEN"00"=>z508ec0017<=zf6569350a;WHEN"01"=>z508ec0017<=pixd_in;WHEN"10"=>z508ec0017<=z5bf0509d2;WHEN"11"=>z508ec0017<=z5bf0509d2;WHEN OTHERS=>z508ec0017<=(OTHERS=>'X');END CASE;END PROCESS z430e8384e;pixd_out<=zf6569350a;END struct;