LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity adcTest is
    generic (
        nbits   : integer := 11); --Databits - 1
    
    port (
        CLOCK_50    : in std_logic; --PIN_R8
        KEY_0       : in std_logic; --PIN_J15 3.3V
        GPIO_09     : out std_logic; --PIN_D5 3.3V
        
        ADC_SDAT    : in std_logic; --PIN_A9 3.3V
        ADC_SCLK    : out std_logic; --PIN_B14 3.3V
        ADC_CS_N    : out std_logic; --PIN_A10 3.3V
        ADC_SADDR   : out std_logic); --PIN_B10 3.3V
end adcTest;

architecture structure of adcTest is

    signal adcValid : std_logic;
    signal adcData  : std_logic_vector(nbits downto 0);
    signal IOData   : std_logic_vector(nbits downto 0);
    signal adcAddr  : std_logic_vector(2 downto 0);
    signal sigClk   : std_logic;

begin

adc128s022 : entity work.adc128s022
    generic map (
        nbits => nbits)
        
    port map (
        Mclk        => CLOCK_50,
        rst_n       => KEY_0,
        read_adc    => sigClk,
        add_adc     => adcAddr,
        Q           => adcData,
        Q_valid     => adcValid,
        
        adc_Dout    => ADC_SDAT,     
        adc_clk     => ADC_SCLK,    
        adc_n_cs    => ADC_CS_N,   
        adc_Din     => ADC_SADDR);

IOctrl : entity work.IOctrl
    generic map (
        nbits       => nbits)
    port map (
        clk         => CLOCK_50,
        rst_n       => KEY_0,
        sClk        => sigClk,
        addr        => adcAddr,
        D           => adcData,
        Q           => IOData);
        
SimpleDac : entity work.SimpleDac
    generic map (
        nbits       => nbits)
    port map (
        DataIn      => unsigned(IOData),
        dataOut     => GPIO_09,
        mClk        => CLOCK_50,
        sClk        => sigClk,
        rst_n       => KEY_0);
end structure;
