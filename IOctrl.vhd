library ieee;
use ieee.std_logic_1164.all;

entity IOctrl is

    generic (
        nbits : integer :=11);
    port (
        clk : in std_logic;
        rst_n : in std_logic;
        sClk : out std_logic;
        addr  : out std_logic_vector(2 downto 0);
        D : in std_logic_vector(nbits downto 0);
        Q : out std_logic_vector(nbits downto 0));
end IOctrl;

architecture rtl of IOctrl is

begin

data : process(ALL)
begin
    if rst_n = '0' then
        Q <= (others => '0');
    else
        Q <= D;
    end if;
end process;

signalClk : process(rst_n,clk)
    variable sClkCntr : integer range 0 to 4095;
    
begin
    if rst_n = '0' then
        sClkCntr := 0;
        sClk <= '0';
    elsif rising_edge(clk) then
        if sClkCntr < 2047 Then
            sClk <= '1';
        elsif sClkCntr < 4095 then
            sClk <= '0';
        end if;
        
        if sClkCntr = 4095 then
            sClkCntr := 0;
        else
            sClkCntr := sClkCntr + 1;
        end if;
    end if;
end process;

inputSel : process(ALL)

begin
    if rst_n = '0' then
        addr <= "000";
    end if;
end process;
end rtl;
