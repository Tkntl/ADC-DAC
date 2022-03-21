LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity adcTestTb is
end adcTestTb;

architecture stim of adcTestTb is 

    signal CLOCK_50 : std_logic := '0';
    signal KEY_0 : std_logic := '0';
    signal KEY_1 : std_logic := '1';
    signal GPIO_09 : std_logic;

    signal ADC_SDAT : std_logic := '0';
    signal ADC_SCLK : std_logic;
    signal ADC_CS_N : std_logic;
    signal ADC_SADDR : std_logic;
    
    constant mtime : time := 10 ns;

begin

duv: entity work.adcTest
    port map (
    CLOCK_50 => CLOCK_50,
    KEY_0 => KEY_0,
    KEY_1 => KEY_1,
    GPIO_09 => GPIO_09,
    
    ADC_SDAT => ADC_SDAT,
    ADC_SCLK => ADC_SCLK,
    ADC_CS_N => ADC_CS_N,
    ADC_SADDR => ADC_SADDR
    );
    
Mclock: process
    begin
        CLOCK_50 <= not CLOCK_50;
        wait for mtime;
end process Mclock;

inputSelect : process
    begin
        wait for 40*mtime;
        KEY_1 <= '0';
        wait for 4 * mtime;
        KEY_1 <= '1';
        wait;
end process inputSelect;

Reset: process
    begin
        wait for 4*mtime;
        KEY_0 <= '1';
end process Reset;


adc_output: process 

    variable dataOut: std_logic_vector(4+11 downto 0) :="0000100000000000";
    variable Dcntr : integer range 0 to 15 := 15;
begin
    if Dcntr = 15 then
        wait until falling_edge(ADC_CS_N);
    else
        wait until falling_edge(ADC_SCLK);
    end if;

    ADC_SDAT <= dataOut(Dcntr);
    if Dcntr = 0 then
        Dcntr := 15;
    else
        Dcntr := Dcntr - 1;
    end if;

end process adc_output;

end stim;
