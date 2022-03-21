LIBRARY IEEE;

use ieee.std_logic_1164.all;

entity reset is
    port (
        Mclk        : in std_logic;
        reset_in    : in std_logic;
        reset_out   : out std_logic);
end reset;

architecture rtl of reset is
begin
sync_reset: process(reset_in,Mclk)
begin
    if reset_in = '0' then
        reset_out <= '0';
    elsif rising_edge(Mclk) AND reset_in = '1' then
        reset_out <= '1';
    end if;
end process;
end rtl;
