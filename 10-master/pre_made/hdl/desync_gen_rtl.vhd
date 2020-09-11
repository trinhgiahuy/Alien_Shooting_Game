--
-- VHDL Architecture pre_made.desync_gen.rtl
--
-- Created:
--          by - kayra.UNKNOWN (WS-11696-PC)
--          at - 13:39:53 31.07.2018
--
-- using Mentor Graphics HDL Designer(TM) 2012.2a (Build 3)
--
--original desing:
-------------------------------------------------------------------------------
-- Title      : Kytkinvärähdyssimulaattori
-- Project    : Digitaalisuunnittelu
-------------------------------------------------------------------------------
-- File       : tb_buttonsync.vhd
-- Author     :   <alhonena@BUMMALO>
-- Company    : 
-- Last update: 2008/05/07
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2008/05/07  1.0      alhonena	Created
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY desync_gen IS
   PORT( 
      btn_dff_dff : IN     std_logic;
      clk         : IN     std_logic;
      prand       : IN     std_logic;
      rst_n       : IN     std_logic;
      bouncing    : OUT    std_logic
   );

-- Declarations

END desync_gen ;

--
ARCHITECTURE rtl OF desync_gen IS
  
  constant varahtelypituus_c : integer := 10;
                                
  constant varahtelykellojakaja_c : integer := 50;
  
  signal edel_nappi_r : std_logic;
  signal sotkemistila_r : std_logic;

  signal sotkemislaskuri_r : integer range 0 to varahtelypituus_c;

  signal kellojakolaskuri_r : integer range 0 to varahtelykellojakaja_c;

  signal lahteva_nappi_r : std_logic;
  
BEGIN--rtl
    
  desync: process (clk, rst_n)
  begin  -- process desync_looppi
    if rst_n = '0' then                 -- asynchronous reset (active low)
      sotkemistila_r <= '0';
      edel_nappi_r <= '0';
      lahteva_nappi_r<='0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      edel_nappi_r <= btn_dff_dff;
      if edel_nappi_r /= btn_dff_dff then
        sotkemistila_r <= '1';
      end if;

      if sotkemistila_r = '1' then
        if sotkemislaskuri_r = varahtelypituus_c then
          sotkemislaskuri_r <= 0;
          sotkemistila_r <= '0';
        else
          if kellojakolaskuri_r = varahtelykellojakaja_c then
            kellojakolaskuri_r <= 0;
            sotkemislaskuri_r <= sotkemislaskuri_r + 1;
            -- Laitetaan sotkukamaa linjalle:
            lahteva_nappi_r <= prand;
          else
            kellojakolaskuri_r <= kellojakolaskuri_r + 1;
          end if;
         end if;
      else
      -- ei sotkemistila:
      lahteva_nappi_r <= btn_dff_dff;
        
      end if;
      
    end if;
  end process desync;  
  

   bouncing <= lahteva_nappi_r;
  
END ARCHITECTURE rtl;