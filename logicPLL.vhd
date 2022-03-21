library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logicPLL is

    port (
        clk_in          : in std_logic;
        rst_n           : in std_logic;
        adcClk_out      : out std_logic;
        sClk_out        : out std_logic;
        adcClk_ext      : out std_logic);
end logicPLL;

architecture rtl of logicPLL is

begin

signalClk : process(rst_n,clk_in)
    variable sClkCntr : integer range 0 to 4095;
    
begin
    if rst_n = '0' then
        sClkCntr := 0;
		  sClk_out <= '0';
    elsif rising_edge(clk_in) then
        if sClkCntr < 2047 Then
            sClk_out <= '1';
        elsif sClkCntr < 4095 then
            sClk_out <= '0';
        end if;
        
        if sClkCntr = 4095 then
            sClkCntr := 0;
        else
            sClkCntr := sClkCntr + 1;
        end if;
    end if;
end process;
gen_adc_clk: process(rst_n,clk_in)
    
    variable clkDivCntr : unsigned(4 downto 0);
    
begin
    if rst_n = '0' then
        clkDivCntr := (others => '0');
        
    elsif rising_edge(clk_in) then
        clkDivCntr := clkDivCntr + 1;
        adcClk_out <= clkDivCntr(4);
        adcClk_ext <= clkDivCntr(4);
    end if;
end process gen_adc_clk;
end rtl;
