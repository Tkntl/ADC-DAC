LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity adcTest is
    generic (
        nbits   : integer := 11); --Databits - 1
    
    port (
        CLOCK_50    : in std_logic; --PIN_R8
        KEY_0       : in std_logic; --PIN_J15 3.3V
		  KEY_1       : in std_logic; --PIN_J15 3.3V
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
    signal adcClk   : std_logic;
	signal synrst	: std_logic;

begin

reset : entity work.reset
	port map(
        Mclk        => CLOCK_50,
        reset_in    => KEY_0,
        reset_out   => synrst);

logicPLL : entity work.logicPLL
    port map(
        clk_in      => CLOCK_50,
        rst_n       => synrst,
        adcClk_out  => adcClk,
        sClk_out    => sigClk,
        adcClk_ext  => ADC_SCLK);

adc128s022 : entity work.adc128s022
    generic map (
        nbits => nbits)
        
    port map (
        Mclk        => CLOCK_50,
        rst_n       => synrst,
        read_adc    => sigClk,
        add_adc     => adcAddr,
        Q           => adcData,
        Q_valid     => adcValid,
        
        adc_Dout    => ADC_SDAT,     
        adc_clk     => adcClk,    
        adc_n_cs    => ADC_CS_N,   
        adc_Din     => ADC_SADDR);

IOctrl : entity work.IOctrl
    generic map (
        nbits       => nbits)
    port map (
        clk         => CLOCK_50,
        rst_n       => synrst,
		sel_in		  => KEY_1,
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
        rst_n       => synrst);
end structure;
