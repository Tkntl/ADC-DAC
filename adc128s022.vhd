 LIBRARY IEEE;
 USE ieee.std_logic_1164.all;
 USE ieee.numeric_std.all;
 
 entity adc128s022 is
    generic (
        nbits       : integer := 11;    --Number of Data bits - 1
        rbits       : integer := 7;     --Number of bits in control register - 1
        read_delay  : integer := 5      --Delay from falling edge of n_cs to valid Dout
        );
    port(
        Mclk        : in std_logic;
        rst_n       : in std_logic;
        read_adc    : in std_logic;
        add_adc     : in std_logic_vector(2 downto 0);
        adc_clk     : in std_logic;    --specified performance 0.8 Mhz - 3.2 Mhz
        Q           : out std_logic_vector(nbits downto 0);
        Q_valid     : out std_logic;
        
        adc_Dout    : in std_logic;     --read pin on rising edge
        
        adc_n_cs    : out std_logic;    --conversion starts at the falling edge and continues as long pin is LOW 
        adc_Din     : out std_logic     --set pin on falling edge
    );
end adc128s022;
    
architecture rtl of adc128s022 is
    signal adc_set : std_logic;
    signal adc_read : std_logic;
    signal adc_stop : std_logic;
begin

fsm_adc: process(rst_n,adc_clk)

    type fsm_flow is (IDLE,SET,READ);
    variable fsm : fsm_flow;
    variable delay_cntr : integer range 0 to read_delay;
    variable read_cntr : integer range 0 to nbits;
    variable set_cntr : integer range 0 to rbits;
    variable en_n : std_logic;

begin

    if rst_n = '0' then
        fsm := IDLE;
        adc_set <= '0';
        adc_read <= '0';
        adc_stop <= '0';
    elsif rising_edge(adc_clk) then
        case fsm is
            when IDLE =>
                if read_adc = '1' and en_n = '0' then
                    adc_set <= '1';
                    fsm := SET;
                    delay_cntr := 0;
                    en_n := '1';
                elsif read_adc = '0' then
                    en_n := '0';
                end if;
                
            when SET =>
                if delay_cntr = (read_delay - 2) then
                    adc_read <= '1';
                    fsm := READ;
                    read_cntr := 0;
                    set_cntr := 0;
                else
                    delay_cntr := delay_cntr + 1;
                end if;
            when READ =>
                if set_cntr = rbits - 4 then
                    adc_set <= '0';
                else
                    set_cntr := set_cntr + 1;
                end if;
                if read_cntr = (nbits) then
                    adc_read <= '0';
                    adc_stop <= '0';
                    fsm := IDLE;
                else
                    if read_cntr = (nbits - 1) then
                        adc_stop <= '1';
                    end if;
                    read_cntr := read_cntr + 1;
                end if;
                
        end case;
    end if;
end process fsm_adc;

set_adc: process(rst_n,adc_clk)
    -- Bits 7, 6, 2, 1, 0 DONTC ; 5 ADD2; 4 ADD1; 3 ADD0;
    variable ctrlRegBits : std_logic_vector(rbits downto 0); 
    variable cntr : integer range 0 to rbits;
begin
    if rst_n = '0' then
        adc_n_cs <= '1';
        cntr := rbits;
        ctrlRegBits := (others => '0'); -- Default input IN0
    elsif falling_edge(adc_clk) AND adc_set = '1' then
        adc_n_cs <= '0';
        ctrlRegBits(5 downto 3) := add_adc;
        
        adc_Din <= ctrlRegBits(cntr);
        if cntr > 0 then
            cntr := cntr - 1;
        else
            cntr := rbits;
        end if;
    elsif falling_edge(adc_clk) AND adc_stop = '1' then
        adc_n_cs <= '1';
    end if;
end process set_adc;

read_data_adc: process(rst_n, adc_clk)

    variable cntr : integer range 0 to nbits;

begin
    if rst_n = '0' then
        cntr := nbits;
        Q <= (others => '0');
        Q_valid <= '0';
    elsif rising_edge(adc_clk) AND adc_read = '1' then
        Q(cntr) <= adc_Dout;
        if cntr > 0 then
            Q_valid <= '0';
            cntr := cntr - 1;
        else
            cntr := nbits;
            Q_valid <= '1';
        end if;
    end if;
end process read_data_adc;
end rtl;
