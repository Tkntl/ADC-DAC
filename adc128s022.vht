LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity adc128s022_tb is
end adc128s022_tb;

architecture stim of adc128s022_tb is

    signal Mclk     : std_logic := '0';
    signal rst_n      : std_logic := '0';
    signal read_adc : std_logic := '0';
    signal add_adc  : std_logic_vector(2 downto 0) := (others => '0');
    signal Q        : std_logic_vector(11 downto 0);
    signal Q_valid  : std_logic;
    
    signal adc_Dout : std_logic := '1';
    signal adc_clk  : std_logic;
    signal adc_n_cs : std_logic;
    signal adc_Din  : std_logic;
    
    constant mtime  : time := 10 ns;
    
component adc128s022
    port (
        Mclk        : in std_logic;
        rst_n         : in std_logic;
        read_adc    : in std_logic;
        add_adc     : in std_logic_vector(2 downto 0);
        Q           : out std_logic_vector(11 downto 0);
        Q_valid     : out std_logic;
        
        adc_Dout    : in std_logic;
        adc_clk     : out std_logic;
        adc_n_cs    : out std_logic;
        adc_Din     : out std_logic
    );
end component;

begin

duv1: adc128s022
    port map (
        Mclk => Mclk,
        rst_n => rst_n,
        read_adc => read_adc,
        add_adc => add_adc,
        Q => Q,
        Q_valid => Q_valid,
        
        adc_Dout => adc_Dout,
        adc_clk => adc_clk,
        adc_n_cs => adc_n_cs,
        adc_Din => adc_Din
    );
    
Mclock: process
    begin
        Mclk <= not Mclk;
        wait for mtime;
end process Mclock;

Reset: process
    begin
        wait for 4*mtime;
        rst_n <= '1';
end process Reset;

RW: process

begin
    wait until rising_edge(adc_clk);
    read_adc <= '1';
    add_adc <= "101";
    wait until rising_edge(adc_clk);
    wait until rising_edge(adc_clk);
    read_adc <= '0';
    wait until Q_valid = '1';
end process RW;

adc_output: process 

    variable dataOut: std_logic_vector(4+11 downto 0) :="0000101010101010";
    variable Dcntr : integer range 0 to 15 := 15;
begin
    if Dcntr = 15 then
        wait until falling_edge(adc_n_cs);
    else
        wait until falling_edge(adc_clk);
    end if;

    adc_Dout <= dataOut(Dcntr);
    if Dcntr = 0 then
        Dcntr := 15;
    else
        Dcntr := Dcntr - 1;
    end if;
end process adc_output;

end stim;
