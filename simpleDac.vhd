 library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;
 
 entity simpleDac is
    generic (
        NBITS : integer := 11);
    
    port (
        mClk : in std_logic;
        sClk : in std_logic;
        rst_n : in std_logic;
        dataIn : in unsigned(NBITS downto 0);
        dataOut : out std_logic);
end simpleDac;

architecture rtl of simpleDac is
    signal start : std_logic;
    signal dataToDac : unsigned(NBITS downto 0);
    
begin
startDac : process(rst_n,sClk)
begin
    if rst_n = '0' then
        start <= '0';
        dataToDac <= (others => '0');
    elsif rising_edge(sClk) then
        start <= '1';
        dataToDac <= dataIn;
    end if;
end process;

dac :process(rst_n,mClk)
    variable outCntr : unsigned(NBITS downto 0);
    constant CLEAR : unsigned(NBITS downto 0) := (others => '1');

begin

    if rst_n = '0' then
        outCntr := (others => '0');
        dataOut <= '0';
    
    elsif rising_edge(mClk) and start = '1' then
        if outCntr < dataToDac then
            dataOut <= '1';
        elsif outCntr >= DataToDac then
            dataOut <= '0';
        end if;
        
        if outCntr = CLEAR - 1 then
            outCntr := (others => '0');
        else
            outCntr := outCntr + 1;
        end if;
    end if;
end process;
end rtl;
